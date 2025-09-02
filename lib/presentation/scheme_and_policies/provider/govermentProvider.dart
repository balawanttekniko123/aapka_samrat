import 'package:flutter/material.dart';
import 'package:samrat_chaudhary/presentation/scheme_and_policies/model/scheme_model.dart';
import '../../../core/api/api_exceptions.dart';
import '../../../core/widgets/components/errorScreen.dart';
import '../../../core/widgets/utils/utils.dart';
import '../../../data/services/api_service.dart';

import '../model/govermentModel.dart';


class GovermentProvider extends ChangeNotifier {
  final UserService userService;

  GovermentProvider(this.userService);

  bool loading = false;
  // List<SchemeModel> schemes = [];
  GovernmentModel?governmentModel;


  void setLoading(bool loader) {
    loading = loader;
    notifyListeners();
  }

  Future<void> getGovernment({required BuildContext context}) async {
    setLoading(true);
    try {
      final response = await userService.getGovernment();
      if (response.status==true) {
        governmentModel = response;
        notifyListeners();
      } else {
        Utils.toastMessage("No government found.");
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