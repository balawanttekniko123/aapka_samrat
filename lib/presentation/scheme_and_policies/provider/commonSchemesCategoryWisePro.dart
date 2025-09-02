
import 'package:flutter/material.dart';
import '../../../core/api/api_exceptions.dart';
import '../../../core/widgets/components/errorScreen.dart';
import '../model/commonCategoryWiseModel.dart';
import '../../../core/widgets/utils/utils.dart';
import '../../../data/services/api_service.dart';

class CommonSchemesCategoryWisePro extends ChangeNotifier {
  final UserService userService;

  CommonSchemesCategoryWisePro(this.userService);

  bool loading = false;
  CommonSchemeCategoryWiseModel? commonSchemeCategoryWiseModel;

  void setLoading(bool loader) {
    loading = loader;
    notifyListeners();
  }

  void clearData() {
    commonSchemeCategoryWiseModel = null;
    notifyListeners();
  }

  Future<void> getcommonSchemeCategory({
    required BuildContext context,
    required String departmentID,
    required String governmentID,
  }) async {
    clearData();
    setLoading(true);

    try {
      final response = await userService.commonSchemeCategory(
        departmentID: departmentID,
        governmentID: governmentID,
      );

      if (response.status == true) {
        commonSchemeCategoryWiseModel = response;
        notifyListeners();
      } else {
        Utils.toastMessage("No schemes found.");
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
