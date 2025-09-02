import 'package:flutter/material.dart';
import 'package:samrat_chaudhary/data/services/api_service.dart';

import '../../../core/api/api_exceptions.dart';
import '../../../core/widgets/components/errorScreen.dart';
import '../../../core/widgets/utils/utils.dart';
import '../../thankyouScreen.dart';
import '../model/feedbackModel.dart';

class FeedbackProvider with ChangeNotifier {
  final UserService userService;

  FeedbackProvider(this.userService);

  //feedbackApi
  final nameController = TextEditingController();
  final mobileController = TextEditingController();
  final addressController = TextEditingController();
  final feedbackController = TextEditingController();
  FeedbackModel? feedbackModel;
  bool loading =false;

  final formKey = GlobalKey<FormState>();
  void setLoading(bool loader) {
    loading = loader;
    notifyListeners();
  }

  bool validateForm() {
    return formKey.currentState?.validate() ?? false;
  }

   submitFeedback( BuildContext context) {
    if (validateForm()) {
      feedbackApi(context);
      debugPrint("Feedback Submitted:\n"
          "Name: ${nameController.text}\n"
          "Mobile: ${mobileController.text}\n"
          "Address: ${addressController.text}\n"
          "Feedback: ${feedbackController.text}");
    }
  }

  void feedbackApi(
      BuildContext context
      ) async {
    setLoading(false);
    var response = await userService.feedbackApi(
        name: nameController.text,
        address: addressController.text,
        feedback: feedbackController.text,
        mobile: mobileController.text);
    try {
      if (response.status == true) {
        feedbackModel = response;
       Navigator.push(context, MaterialPageRoute(builder: (context) => ThankYouScreen(),));
        clear();
      } else {
        Utils.toastMessage(
          response.message.toString(),
        );
      }
    } on NetworkException {
      navigateToError(context, 'No internet connection. Please try again.', context.widget);
    }on ServerException catch (e) {
      navigateToError(context, e.message, context.widget);
    }catch (e) {
      navigateToError(context, 'Something went wrong. Please try again.', context.widget);
    } finally {
      setLoading(false);
    }

    notifyListeners();
  }
  clear(){
    nameController.clear();
    mobileController.clear();
    addressController.clear();
    feedbackController.clear();
  }

  void disposeControllers() {
    nameController.dispose();
    mobileController.dispose();
    addressController.dispose();
    feedbackController.dispose();
  }
}
