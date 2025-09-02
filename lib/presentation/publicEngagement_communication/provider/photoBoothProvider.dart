import 'package:flutter/material.dart';
import 'package:samrat_chaudhary/presentation/publicEngagement_communication/model/publicNwsModel.dart';
import 'package:samrat_chaudhary/presentation/publicEngagement_communication/model/publicPhotoModel.dart';
import 'package:samrat_chaudhary/presentation/publicEngagement_communication/model/videoPlayerModel.dart';

import '../../../core/api/api_exceptions.dart';
import '../../../core/widgets/components/errorScreen.dart';
import '../../leadershipVision/model/leadership_banner_model.dart';
import '../../../core/widgets/utils/utils.dart';
import '../../../data/services/api_service.dart';
import '../model/socialMediaModel.dart';
//
// class PhotoBoothProvider extends ChangeNotifier {
//   final UserService userService;
//
//   PhotoBoothProvider(this.userService);
//
//   bool loading = false;
//   bool storyLoading = false;
//
//   PublicPhotoModel? publicPhotoModel;
//   SocialMediaModel?socialMediaModel;
//
//   void setLoading(bool loader) {
//     loading = loader;
//     notifyListeners();
//   }
//
//   void setStoryLoading(bool loader) {
//     storyLoading = loader;
//     notifyListeners();
//   }
//
//   void getPhotoBooth(
//       {required BuildContext context,
//       required String startDate,
//       required String endDate}) async {
//     setLoading(true);
//     var response = await userService.publicPhotoBooth(
//         startDate: startDate, endDate: endDate,page: 1);
//     try {
//       if (response.status == true) {
//         publicPhotoModel = response;
//       } else {
//         Utils.toastMessage(
//           response.message.toString(),
//         );
//       }
//     } on NetworkException {
//       navigateToError(context, 'No internet connection. Please try again.', context.widget);
//     }on ServerException catch (e) {
//       navigateToError(context, e.message, context.widget);
//     }catch (e) {
//       navigateToError(context, 'Something went wrong. Please try again.', context.widget);
//     } finally {
//       setLoading(false);
//     }
//
//     notifyListeners();
//   }
//
// }

class PhotoBoothProvider extends ChangeNotifier {
  final UserService userService;

  PhotoBoothProvider(this.userService);

  bool loading = false;
  bool isLoadMoreRunning = false;
  bool hasNextPage = true;

  int page = 1;
  PublicPhotoModel? publicPhotoModel;

  void setLoading(bool loader) {
    loading = loader;
    notifyListeners();
  }

  Future<void> getPhotoBooth({
    required BuildContext context,
    required String startDate,
    required String endDate,
    bool isLoadMore = false,
  }) async {
    if (!isLoadMore) {
      page = 1;
      hasNextPage = true;
      publicPhotoModel = null;
      setLoading(true);
    } else {
      isLoadMoreRunning = true;
      notifyListeners();
    }

    try {
      var response = await userService.publicPhotoBooth(
        startDate: startDate,
        endDate: endDate,
        page: page,
      );

      if (response.status == true) {
        if (response.data != null && response.data!.isNotEmpty) {
          if (isLoadMore && publicPhotoModel != null) {
            publicPhotoModel!.data!.addAll(response.data!); // merge data
          } else {
            publicPhotoModel = response;
          }
          page++;
        } else {
          hasNextPage = false;
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
      if (!isLoadMore) {
        setLoading(false);
      } else {
        isLoadMoreRunning = false;
        notifyListeners();
      }
    }
  }
}
