import 'package:flutter/material.dart';
import 'package:samrat_chaudhary/presentation/Culture_Heritage/model/districkDetailModel.dart';

import '../../../core/api/api_exceptions.dart';
import '../../../core/widgets/components/errorScreen.dart';
import '../../../core/widgets/utils/utils.dart';
import '../../../data/services/api_service.dart';
import '../model/culture_heritage_Detail_Model.dart';

class CultureHeritageDetailProvider extends ChangeNotifier{
  final UserService userService;

  CultureHeritageDetailProvider(this.userService);

  bool loading = false;
  bool storyLoading = false;

  CultureHeritagDetailModel? cultureHeritagDetailModel;
  void clearData() {
    cultureHeritagDetailModel = null;

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



  void cultureHeritageDetailApi(
      {required BuildContext context,required String id}) async {

    clearData(); setLoading(true);
    setLoading(true);
    var response = await userService.cultureHeritageDetailApi(id: id);
    try {

      if (response.success == true) {
        cultureHeritagDetailModel = response;

      } else {
        Utils.toastMessage(
          response.message.toString(),
        );

      }
    }on NetworkException {
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