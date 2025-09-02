

import 'package:flutter/material.dart';
import 'package:samrat_chaudhary/presentation/leadershipVision/model/leader_milestone_model.dart';
import 'package:samrat_chaudhary/presentation/leadershipVision/model/leadership_detail_model.dart';
import 'package:samrat_chaudhary/presentation/leadershipVision/model/leadership_story_model.dart';
import 'package:samrat_chaudhary/presentation/leadershipVision/model/roadMapModel.dart';

import '../model/home_selected_model.dart';
import '../model/leadership_banner_model.dart';
import '../../auth/model/otp_model.dart';
import '../../../core/widgets/utils/utils.dart';
import '../../home_screen.dart';
import '../../auth/ui/otp_screen.dart';
import '../../../data/services/api_service.dart';

class HomeProvider extends ChangeNotifier {


  final UserService userService;

  HomeProvider(this.userService);

  bool loading = false;
  bool storyLoading = false;
  bool detailLoading = false;

  HomeSelectedModel? homeSelectedModel;
  LeadershipBannerModel? leadershipBannerModel;
  LeadershipStoryModel? leadershipStoryModel;
  LeadershipDetailModel? leadershipDetailModel;
  LeadershipMileStoneModel? leadershipMileStoneModel;
  RoadMapModel?roadMapModel;

  void setLoading(bool loader) {
    loading = loader;
    notifyListeners();
  }
  void setStoryLoading(bool loader) {
    storyLoading = loader;
    notifyListeners();
  } void setDetailLoading(bool loader) {
    detailLoading = loader;
    notifyListeners();
  }


  void getHomeCategory(
      {required BuildContext context}) async {
    setLoading(true);
    var response = await userService.getHomeCategory();
    try {

      if (response.status == true) {
        homeSelectedModel = response;

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

  void getLeadershipBanner(
      {required BuildContext context}) async {
    setLoading(true);
    var response = await userService.getLeadershipBanner();
    try {

      if (response.status == true) {
        leadershipBannerModel = response;

      } else {
        Utils.toastMessage(
          response.message.toString(),
        );

      }
    } finally {
      setLoading(false);
    }

    notifyListeners();
  } void getroadMap(
      {required BuildContext context}) async {
    setLoading(true);
    var response = await userService.getRoadMap();
    try {

      if (response.status == true) {
        roadMapModel = response;

      } else {
        print(
          response.message.toString(),
        );

      }
    } finally {
      setLoading(false);
    }

    notifyListeners();
  }


  void getLeadershipStory(
      {required BuildContext context}) async {
    setStoryLoading(true);
    var response = await userService.getLeadershipStory();
    try {

      if (response.status == true) {
        leadershipStoryModel = response;

      } else {
        Utils.toastMessage(
          response.message.toString(),
        );

      }
    } finally {
      setStoryLoading(false);
    }

    notifyListeners();
  }

  Future getLeadershipDetail(
      {required BuildContext context}) async {
    setDetailLoading(true);
    var response = await userService.getLeadershipDetail();
    try {

      if (response.status == true) {
        leadershipDetailModel = response;

      } else {
        Utils.toastMessage(
          response.message.toString(),
        );

      }
    } finally {
      setDetailLoading(false);
    }

    notifyListeners();
  }


  Future getLeadershipMilestone(
      {required BuildContext context}) async {
    setDetailLoading(true);
    var response = await userService.leadershipMilestone();
    try {

      if (response.status == true) {
        leadershipMileStoneModel = response;

      } else {
        Utils.toastMessage(
          response.message.toString(),
        );

      }
    } finally {
      setDetailLoading(false);
    }

    notifyListeners();
  }



}
