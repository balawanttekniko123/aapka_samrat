import 'package:flutter/material.dart';
import '../../../core/api/api_exceptions.dart';
import '../../../core/widgets/components/errorScreen.dart';
import '../../../core/widgets/utils/utils.dart';
import '../../../data/services/api_service.dart';
import '../model/subDirectoryModel.dart';

class SubDirectoryProvider extends ChangeNotifier {
  final UserService userService;

  SubDirectoryProvider(this.userService);

  bool loading = false;
  SubDirectoryModel? subDirectoryModel;

  void setLoading(bool value) {
    loading = value;
    notifyListeners();
  }

  void clearData() {
    subDirectoryModel = null;
    notifyListeners();
  }

  Future<void> getSubDirectory({
    required BuildContext context,
    required String directoryCategoryID,
    required String districtId,
  }) async {
    clearData();
    setLoading(true);
    try {
      final response = await userService.getSubDirectoryDetails(directoryCategory:directoryCategoryID,districtId:districtId);
      if (response.status == true) {
        subDirectoryModel = response;
        notifyListeners();
      } else {
        Utils.toastMessage("No sub-directory data found.");
      }
    } on NetworkException {
      navigateToError(context, 'No internet connection. Please try again.', context.widget);
    } on ServerException catch (e) {
      navigateToError(context, e.message, context.widget);
    } catch (e) {
      navigateToError(context, 'Something went wrong. Please try again.', context.widget);
    } finally {
      setLoading(false);
    }
  }
}
