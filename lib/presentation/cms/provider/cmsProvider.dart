

import 'package:flutter/material.dart';
import 'package:samrat_chaudhary/presentation/leadershipVision/model/leader_milestone_model.dart';
import 'package:samrat_chaudhary/presentation/leadershipVision/model/leadership_detail_model.dart';
import 'package:samrat_chaudhary/presentation/leadershipVision/model/leadership_story_model.dart';
import 'package:samrat_chaudhary/presentation/cms/model/cmsModel.dart';

import '../../../core/widgets/utils/utils.dart';
import '../../../data/services/api_service.dart';




class CMSProvider extends ChangeNotifier {


  final UserService userService;

  CMSProvider(this.userService);

  bool loading = false;


  CMSModel? cmsModel;


  void setLoading(bool loader) {
    loading = loader;
    notifyListeners();
  }




  void getCms(
      {required BuildContext context}) async {
    setLoading(true);
    var response = await userService.getCMS();
    try {

      if (response.success == true) {
        cmsModel = response;

      } else {
        Utils.toastMessage(
          response.message.toString(),
        );

      }
    } finally {
      setLoading(false);
    }

    notifyListeners();
  }











}
