import 'package:flutter/material.dart';
import 'package:samrat_chaudhary/presentation/Culture_Heritage/model/cultureBannerModel.dart';
import 'package:samrat_chaudhary/presentation/Culture_Heritage/model/districtModel.dart';

import '../../../core/api/api_exceptions.dart';
import '../../../core/widgets/components/errorScreen.dart';
import '../../../core/widgets/utils/utils.dart';
import '../../../data/services/api_service.dart';
import '../model/cultureHeritageModel.dart';
class CultureHeritageProvider extends ChangeNotifier{
  final UserService userService;

  CultureHeritageProvider(this.userService);

  bool loading = false;
  bool storyLoading = false;

  CultureBannerModel? cultureBannerModel;
  DistrictListModel?districtListModel;
  CultureAndHeritagModel?cultureAndHeritagModel;

  void setLoading(bool loader) {
    loading = loader;
    notifyListeners();
  }
  void setStoryLoading(bool loader) {
    storyLoading = loader;
    notifyListeners();
  }


  void getCultureBannerApi(
      {required BuildContext context}) async {
    setLoading(true);
    var response = await userService.cultureBanner();
    try {

      if (response.status == true) {
        cultureBannerModel = response;

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
  } void getCultureListDistrictIDApi(
      {required BuildContext context,}) async {
    setLoading(true);
    var response = await userService.cultureHeritageList();
    try {

      if (response.success == true) {
        cultureAndHeritagModel = response;

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
  void getDistrictApi(
      {required BuildContext context}) async {
    setLoading(true);
    var response = await userService.districtListApi();
    try {

      if (response.status == true) {
        districtListModel = response;

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