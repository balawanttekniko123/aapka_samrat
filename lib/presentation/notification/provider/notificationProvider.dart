import 'package:flutter/material.dart';
import 'package:samrat_chaudhary/presentation/notification/model/notificationModel.dart';
import '../../../core/api/api_exceptions.dart';
import '../../../core/widgets/components/errorScreen.dart';
import '../../Culture_Heritage/model/districtModel.dart';

import '../../../core/widgets/utils/utils.dart';
import '../../../data/services/api_service.dart';

class NotificationProvider extends ChangeNotifier {
  final UserService userService;

  NotificationProvider(this.userService);

  bool loading = false;
  NotificationModel?notificationModel;


  void setLoading(bool loader) {
    loading = loader;
    notifyListeners();
  }

  Future<void> getNotification({required BuildContext context,}) async {
    setLoading(true);
    try {
      final response = await userService.getNotification();
      if (response.status==true) {
        notificationModel = response;
      } else {
        print("No notificationModel found.");
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