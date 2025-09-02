import 'package:flutter/material.dart';
import 'package:samrat_chaudhary/presentation/Culture_Heritage/model/districkDetailModel.dart';

import '../../../core/api/api_exceptions.dart';
import '../../../core/widgets/components/errorScreen.dart';
import '../../../core/widgets/utils/utils.dart';
import '../../../data/services/api_service.dart';

class DistrictDetailProvider extends ChangeNotifier{
  final UserService userService;

  DistrictDetailProvider(this.userService);

  bool loading = false;
  bool storyLoading = false;

  DistrictDetailModel? districtDetailModel;
  void clearData() {
    districtDetailModel = null;

    notifyListeners();
  }


  void setLoading(bool loader) {
    loading = loader;
    notifyListeners();
  }
  void setStoryLoading(bool loader) {
    storyLoading = loader;
    notifyListeners();
  }



  void getDistrictDetailApi(
      {required BuildContext context,required String id}) async {
    clearData();
    setLoading(true);
    var response = await userService.districtDetailApi(id: id);
    try {

      if (response.status == true) {
        districtDetailModel = response;

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
}