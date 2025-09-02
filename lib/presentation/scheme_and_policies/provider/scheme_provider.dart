import 'package:flutter/material.dart';
import 'package:samrat_chaudhary/presentation/scheme_and_policies/model/scheme_model.dart';
import '../../../core/api/api_exceptions.dart';
import '../../../core/widgets/components/errorScreen.dart';
import '../../../core/widgets/utils/utils.dart';
import '../../../data/services/api_service.dart';

class SchemeProvider extends ChangeNotifier {
  final UserService userService;

  SchemeProvider(this.userService);

  bool loading = false;
  // List<SchemeModel> schemes = [];
  SchemeModel?schemeModel;

  void setLoading(bool loader) {
    loading = loader;
    notifyListeners();
  }
  void clearData() {
    schemeModel = null;

    notifyListeners();
  }

  Future<void> getScheme({required BuildContext context, required String schemeCategory,required String goverment ,required String department}) async {
    clearData(); setLoading(true);

    try {

      final response = await userService.getSchemes(department:department ,goverment: goverment,schemeCategory: schemeCategory);

      if (response.status == true) {

        schemeModel = response;
        notifyListeners();

      } else {

        Utils.toastMessage("No schemes found.");
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