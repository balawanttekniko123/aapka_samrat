import 'package:flutter/material.dart';
import 'package:samrat_chaudhary/presentation/scheme_and_policies/model/scheme_model.dart';
import '../../../core/api/api_exceptions.dart';
import '../../../core/widgets/components/errorScreen.dart';
import '../model/policyListModel.dart';
import '../../../core/widgets/utils/utils.dart';
import '../../../data/services/api_service.dart';

class PolicyListProvider extends ChangeNotifier {
  final UserService userService;

  PolicyListProvider(this.userService);

  bool loading = false;
  // List<SchemeModel> schemes = [];
  PoliciesModel?policiesModel;

  void setLoading(bool loader) {
    loading = loader;
    notifyListeners();
  }

  Future<void> getPolicy({required BuildContext context, required String id}) async {
    setLoading(true);
    print(">>>>>>>>1>>>>>>>");
    try {
      print(">>>>>>>>2>>>>>>>");
      final response = await userService.getPolicy(id);
      print(">>>>>>9>>>>>>>>>");
      if (response.status == true) {
        print(">>>>>>>3>>>>>>>>");
        policiesModel = response;
        notifyListeners();
        print(">>>>>>>4>>>>>>>>");
      } else {
        print(">>>>>>5>>>>>>>>>");
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