import 'package:flutter/material.dart';
import '../../../core/api/api_exceptions.dart';
import '../../../core/widgets/components/errorScreen.dart';
import '../../Culture_Heritage/model/districtModel.dart';
import '../model/directoryCategory_model.dart';
import '../../../core/widgets/utils/utils.dart';
import '../../../data/services/api_service.dart';

class DirectoryCategoryProvider extends ChangeNotifier {
  final UserService userService;

  DirectoryCategoryProvider(this.userService);

  bool loading = false;
  DirectoryCategoryModel?directoryCategoryModel;
  DistrictListModel?districtListModel;

  void setLoading(bool loader) {
    loading = loader;
    notifyListeners();
  }

  Future<void> getDirectoryCategory({required BuildContext context}) async {
    setLoading(true);
    try {
      final response = await userService.getDirectoryCategory();
      if (response.status==true) {
        directoryCategoryModel = response;
      } else {
        Utils.toastMessage("No directoryCategory found.");
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