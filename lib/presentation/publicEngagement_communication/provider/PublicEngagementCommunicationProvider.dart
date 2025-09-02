import 'package:flutter/material.dart';
import 'package:samrat_chaudhary/presentation/publicEngagement_communication/model/publicNwsModel.dart';
import 'package:samrat_chaudhary/presentation/publicEngagement_communication/model/publicPhotoModel.dart';
import 'package:samrat_chaudhary/presentation/publicEngagement_communication/model/videoPlayerModel.dart';
import '../../../core/api/api_exceptions.dart';
import '../../../core/widgets/components/errorScreen.dart';
import '../../leadershipVision/model/leadership_banner_model.dart';
import '../../../../core/widgets/utils/utils.dart';
import '../model/publicBannerModel.dart';
import '../../../data/services/api_service.dart';

class PublicEngagementCommunicationProvider extends ChangeNotifier{
  final UserService userService;

  PublicEngagementCommunicationProvider(this.userService);

  bool loading = false;
  bool storyLoading = false;
  int currentPage = 1;
  bool hasMore = true;
  bool isLoadMoreRunning = false;

  VideoPlayerModel? videoPlayerModel;
  PublicBannerModel? publicBannerModel;
  PublicNewsModel?publicNewsModel;
  PublicPhotoModel?publicPhotoModel;
  void setLoading(bool loader) {
    loading = loader;
    notifyListeners();
  }
  void setStoryLoading(bool loader) {
    storyLoading = loader;
    notifyListeners();
  }



  Future<void> getPublicVideo({
    required BuildContext context,
    bool isFirst = false,
  }) async {
    if (isFirst) {
      currentPage = 1;
      hasMore = true;
      videoPlayerModel = null;
      setLoading(true);
    } else {
      isLoadMoreRunning = true;
      notifyListeners();
    }

    try {
      var response = await userService.publicVideo(page: currentPage);

      if (response.status == true && response.data != null) {
        if (response.data!.isNotEmpty) {
          if (videoPlayerModel == null || isFirst) {
            // 🔹 fresh model assign
            videoPlayerModel = response;
          } else {
            // 🔹 append new page data to existing model
            videoPlayerModel!.data!.addAll(response.data!);
          }
          currentPage++;
        } else {
          hasMore = false;
        }
      } else {
        Utils.toastMessage(response.message.toString());
      }
    } on NetworkException {
      navigateToError(context, 'No internet connection. Please try again.', context.widget);
    } on ServerException catch (e) {
      navigateToError(context, e.message, context.widget);
    } catch (e) {
      navigateToError(context, 'Something went wrong. Please try again.', context.widget);
    } finally {
      setLoading(false);
      isLoadMoreRunning = false;
      notifyListeners();
    }
  }
  void getPublicNews(
      {required BuildContext context}) async {
    setLoading(true);
    var response = await userService.publicNews();
    try {

      if (response.status == true) {
        publicNewsModel = response;

      } else {
        Utils.toastMessage(
          response.message.toString(),
        );

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

    notifyListeners();
  }
  void getPublicPhoto(
      {required BuildContext context}) async {
    setLoading(true);
    var response = await userService.publicPhoto();
    try {

      if (response.status == true) {
        publicPhotoModel = response;

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
  void getPublicBanner(
      {required BuildContext context}) async {
    setLoading(true);
    var response = await userService.publicBanner();
    try {

      if (response.status == true) {
        publicBannerModel = response;

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