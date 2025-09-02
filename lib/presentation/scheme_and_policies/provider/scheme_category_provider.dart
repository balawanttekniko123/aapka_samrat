import 'package:flutter/material.dart';
import 'package:samrat_chaudhary/presentation/scheme_and_policies/model/scheme_model.dart';
import '../../../core/api/api_exceptions.dart';
import '../../../core/widgets/components/errorScreen.dart';
import '../model/polociesModel.dart';
import '../model/schemeCategory_Model.dart';
import '../../../core/widgets/utils/utils.dart';
import '../../../data/services/api_service.dart';

class SchemeCategoryProvider extends ChangeNotifier {
  final UserService userService;

  SchemeCategoryProvider(this.userService);

  bool loading = false;
  // List<SchemeModel> schemes = [];
  SchemeCategoryModel?schemeCategoryModel;
  PoliciesCategoryModel?policiesCategoryModel;

  void setLoading(bool loader) {
    loading = loader;
    notifyListeners();
  }
  void clearData() {
    schemeCategoryModel = null;
    policiesCategoryModel = null;
    notifyListeners();
  }
  Future<void> getSchemesCategory({required BuildContext context,required String id}) async {
    clearData();
    setLoading(true);
    try {
      final response = await userService.getSchemesCategory(id);
      if (response.status==true) {
        schemeCategoryModel = response;
        notifyListeners();
      } else {
        Utils.toastMessage("No SchemesCategory found.");
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
  Future<void> getPolicesCategory({required BuildContext context}) async {
    setLoading(true);
    try {
      final response = await userService.getPolicesCategory();
      if (response.status==true) {
        policiesCategoryModel = response;
        notifyListeners();
      } else {
        Utils.toastMessage("No getPolicesCategory found.");
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
}