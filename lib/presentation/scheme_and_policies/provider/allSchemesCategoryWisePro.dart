import 'package:flutter/material.dart';
import 'package:samrat_chaudhary/presentation/scheme_and_policies/model/scheme_model.dart';
import '../../../core/api/api_exceptions.dart';
import '../../../core/widgets/components/errorScreen.dart';
import '../model/allSchemesCategoryWiseModel.dart';
import '../model/departmentModel.dart';
import '../model/polociesModel.dart';
import '../model/schemeCategory_Model.dart';
import '../../../core/widgets/utils/utils.dart';
import '../../../data/services/api_service.dart';

class AllSchemesCategoryWisePro extends ChangeNotifier {
  final UserService userService;

  AllSchemesCategoryWisePro(this.userService);

  bool loading = false;
  // List<SchemeModel> schemes = [];
  AllSchemeCategoryWiseModel?allSchemeCategoryWiseModel;


  void setLoading(bool loader) {
    loading = loader;
    notifyListeners();
  }
  void clearData() {
    allSchemeCategoryWiseModel = null;

    notifyListeners();
  }
  Future<void> getAllSchemeCategory({required BuildContext context,required String departmentID, required String governmentID}) async {
    clearData();
    setLoading(true);
    try {
      final response = await userService.allSchemeCategory(departmentID: departmentID,governmentID:governmentID ,);
      if (response.status==true) {
        allSchemeCategoryWiseModel = response;
        notifyListeners();
      } else {
        Utils.toastMessage("No allSchemeCategoryWiseModel found.");
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
  }

}