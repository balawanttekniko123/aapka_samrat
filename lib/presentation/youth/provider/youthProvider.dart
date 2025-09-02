

import 'package:flutter/material.dart';
import 'package:samrat_chaudhary/presentation/leadershipVision/model/leader_milestone_model.dart';
import 'package:samrat_chaudhary/presentation/leadershipVision/model/leadership_detail_model.dart';
import 'package:samrat_chaudhary/presentation/leadershipVision/model/leadership_story_model.dart';

import '../../../core/api/api_exceptions.dart';
import '../../../core/widgets/components/errorScreen.dart';
import '../../../core/widgets/utils/utils.dart';
import '../../../data/services/api_service.dart';

import '../model/youthModel.dart';


class YouthProvider extends ChangeNotifier {


  final UserService userService;

  YouthProvider(this.userService);

  bool loading = false;


  YouthModel? youthModel;


  void setLoading(bool loader) {
    loading = loader;
    notifyListeners();
  }




  void getYouthDetail(
      {required BuildContext context}) async {
    setLoading(true);
    var response = await userService.getYouthDetail();
    try {

      if (response.status == true) {
        youthModel = response;

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
