import 'package:flutter/material.dart';

import '../../../core/api/api_exceptions.dart';
import '../../../core/api/api_helper.dart';
import '../../../core/network/api-config.dart';
import '../../../core/widgets/components/errorScreen.dart';
import '../model/directory_details_model.dart';
import '../../../core/widgets/utils/utils.dart';
import '../../../data/services/api_service.dart';

class DirectoryDetailsProvider extends ChangeNotifier {
  final UserService userService;

  DirectoryDetailsProvider(this.userService, this.apiHelper);

  bool loading = false;
  final ApiHelper apiHelper;

  DirectoryResponse? directoryDetailsModel;

  void setLoading(bool loader) {
    loading = loader;
    notifyListeners();
  }
  List<dynamic> directoryData = [];

  Future<void> getFeedBackDetails(
      {required BuildContext context,
      required String directoryCategoryId,
      required String districtId,
      required String subDirectoryCategoryId,
      }) async {
    setLoading(true);
    print(">>>>>>>>1>>>>>>>");
    try {
      print(">>>>>>>>2>>>>>>>");
      final url =
          '${ApiConfig.directoryDetail}?directoryCategory=${directoryCategoryId}&district=${districtId}&subDirectoryCategory=${subDirectoryCategoryId}';
      print(url);
      print("yrre");

      final response = await apiHelper.get(url);

      //final response = await userService.getDirectoryDetails(directoryCategory: directoryCategoryId,districtId:districtId );
      print(">>>>>>9>>>>>>>>>");
      if (response["status"] == true && response["data"] != null) {
        directoryData = response["data"];

      } else {
        directoryData = [];
        print(">>>>>>5>>>>>>>>>");

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
