import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:samrat_chaudhary/presentation/notification/model/notificationModel.dart';
import 'package:samrat_chaudhary/presentation/publicFeedback/model/directory_details_model.dart';
import 'package:samrat_chaudhary/presentation/publicEngagement_communication/model/publicBannerModel.dart';
import 'package:samrat_chaudhary/presentation/cms/model/cmsModel.dart';
import 'package:samrat_chaudhary/presentation/scheme_and_policies/model/departmentModel.dart';
import 'package:samrat_chaudhary/presentation/scheme_and_policies/model/govermentModel.dart';

import '../../core/api/api_helper.dart';

// import '../../core/model/cms_page_model.dart';
import '../../presentation/Culture_Heritage/model/cultureHeritageModel.dart';
import '../../presentation/Culture_Heritage/model/culture_heritage_Detail_Model.dart';
import '../../presentation/auth/model/consult_login_model.dart';
import '../../presentation/Culture_Heritage/model/cultureBannerModel.dart';
import '../../presentation/feedBack/model/feedbackModel.dart';
import '../../presentation/leadershipVision/model/roadMapModel.dart';
import '../../presentation/publicEngagement_communication/model/socialMediaModel.dart';
import '../../presentation/publicFeedback/model/directoryCategory_model.dart';
import '../../presentation/Culture_Heritage/model/districkDetailModel.dart';
import '../../presentation/Culture_Heritage/model/districtModel.dart';
import '../../presentation/leadershipVision/model/home_selected_model.dart';
import '../../presentation/leadershipVision/model/leader_milestone_model.dart';
import '../../presentation/leadershipVision/model/leadership_banner_model.dart';
import '../../presentation/leadershipVision/model/leadership_detail_model.dart';
import '../../presentation/leadershipVision/model/leadership_story_model.dart';
import '../../presentation/auth/model/otp_model.dart';
import '../../presentation/publicFeedback/model/subDirectoryModel.dart';
import '../../presentation/scheme_and_policies/model/allSchemesCategoryWiseModel.dart';
import '../../presentation/scheme_and_policies/model/commonCategoryWiseModel.dart';
import '../../presentation/scheme_and_policies/model/policyListModel.dart';
import '../../presentation/scheme_and_policies/model/polociesModel.dart';
import '../../presentation/auth/model/profileModel.dart';
import '../../presentation/publicEngagement_communication/model/publicNwsModel.dart';
import '../../presentation/publicEngagement_communication/model/publicPhotoModel.dart';
import '../../presentation/scheme_and_policies/model/schemeCategory_Model.dart';
import '../../presentation/scheme_and_policies/model/scheme_model.dart';
import '../../presentation/publicEngagement_communication/model/videoPlayerModel.dart';
import '../../core/network/api-config.dart';
import '../../presentation/editProfile/model/editProfileModel.dart';
import '../../presentation/youth/model/youthModel.dart';

class UserService {
  final ApiHelper apiHelper;

  UserService(this.apiHelper);

  Future<LoginModel> loginUser({
    required BuildContext context,
    required String mobile,
  }) async {
    final url = ApiConfig.login;
    final body = {
      'mobile': mobile,
      // 'password': password,
    };

    final response = await apiHelper.post(url, body: body);
    return LoginModel.fromJson(response);
  }

  Future<OtpVerifyModel> otpVerify({
    required BuildContext context,
    required String mobile,
    required String otp,
  }) async {
    final url = ApiConfig.verifyOtp;
    final body = {
      'mobile': mobile,
      'otp': otp,
    };

    final response = await apiHelper.post(url, body: body);
    return OtpVerifyModel.fromJson(response);
  }

  Future<HomeSelectedModel> getHomeCategory() async {
    final url = ApiConfig.category;

    final response = await apiHelper.get(
      url,
    );
    return HomeSelectedModel.fromJson(response);
  }

  Future<LeadershipBannerModel> getLeadershipBanner() async {
    final url = ApiConfig.leadershipBanner;

    final response = await apiHelper.get(
      url,
    );
    return LeadershipBannerModel.fromJson(response);
  }  Future<RoadMapModel> getRoadMap() async {
    final url = ApiConfig.roadMap;

    final response = await apiHelper.get(
      url,
    );
    return RoadMapModel.fromJson(response);
  }

  Future<YouthModel> getYouthDetail() async {
    final url = ApiConfig.youth;

    final response = await apiHelper.get(
      url,
    );
    return YouthModel.fromJson(response);
  }

  Future<LeadershipStoryModel> getLeadershipStory() async {
    final url = ApiConfig.leadershipStory;

    final response = await apiHelper.get(
      url,
    );
    return LeadershipStoryModel.fromJson(response);
  }

  Future<CMSModel> getCMS() async {
    final url = ApiConfig.cms;

    final response = await apiHelper.get(
      url,
    );
    return CMSModel.fromJson(response);
  }

  Future<LeadershipDetailModel> getLeadershipDetail() async {
    final url = ApiConfig.leadershipDetail;

    final response = await apiHelper.get(
      url,
    );
    return LeadershipDetailModel.fromJson(response);
  }

  Future<GovernmentModel> getGovernment() async {
    final url = ApiConfig.government;

    final response = await apiHelper.get(
      url,
    );
    return GovernmentModel.fromJson(response);
  }

  Future<LeadershipMileStoneModel> leadershipMilestone() async {
    final url = ApiConfig.leadershipMilestone;

    final response = await apiHelper.get(
      url,
    );
    return LeadershipMileStoneModel.fromJson(response);
  }

  Future<SchemeModel> getSchemes(
      {required String schemeCategory,
      required String goverment,
      required String department}) async {
    final url =
        '${ApiConfig.scheme}?schemeCategory=$schemeCategory&government=$goverment&department=$department';
    // "${ApiConfig.commonSchemeCategory}?government=${governmentID}&department=${departmentID}";
    print(url);
    print("jfdgdskggvf");

    final response = await apiHelper.get(url);
    print("jfdgddfgdsgskggvf");
    return SchemeModel.fromJson(response);
  }

  Future<PoliciesModel> getPolicy(String id) async {
    final url = '${ApiConfig.policy}?id=$id';
    print(url);
    print("jfdgdskggvf");

    final response = await apiHelper.get(url);
    print("jfdgddfgdsgskggvf");
    return PoliciesModel.fromJson(response);
  }

  Future getDirectoryDetails({required String districtId,required String directoryCategory}) async {
    final url = '${ApiConfig.directoryDetail}?district=${districtId}&directoryCategory=${directoryCategory}';
    print(url);
    print("yrre");

    final response = await apiHelper.get(url);
    print("getDirectoryDetails");
    print(response);
    return DirectoryResponse.fromJson(response);
  }

  Future getSubDirectoryDetails({required String districtId,required String directoryCategory}) async {
    final url = '${ApiConfig.subdirectoryCategory}directoryCategory=${directoryCategory}&district=${districtId}';
    print(url);
    print("yrre");

    final response = await apiHelper.get(url);
    print("getDirectoryDetails");
    print(response);
    return SubDirectoryModel.fromJson(response);
  }

  Future<SchemeCategoryModel> getSchemesCategory(String id) async {
    final url = "${ApiConfig.schemeCategory}?department=${id}";

    final response = await apiHelper.get(
      url,
    );
    return SchemeCategoryModel.fromJson(response);
  }

  Future<DepartmentModel> getDepartment(String id) async {
    final url = "${ApiConfig.department}?government=${id}";

    final response = await apiHelper.get(
      url,
    );
    return DepartmentModel.fromJson(response);
  }

  Future<AllSchemeCategoryWiseModel> allSchemeCategory(
      {required String governmentID, required String departmentID}) async {
    final url =
        "${ApiConfig.allSchemeCategory}?government=${governmentID}&department=${departmentID}";


    final response = await apiHelper.get(
      url,
    );
    return AllSchemeCategoryWiseModel.fromJson(response);
  }

  Future<CommonSchemeCategoryWiseModel> commonSchemeCategory(
      {required String governmentID, required String departmentID}) async {
    final url =
        "${ApiConfig.commonSchemeCategory}?government=${governmentID}&department=${departmentID}";


    final response = await apiHelper.get(
      url,
    );
    return CommonSchemeCategoryWiseModel.fromJson(response);
  }

  Future<PoliciesCategoryModel> getPolicesCategory() async {
    final url = ApiConfig.policy;

    final response = await apiHelper.get(
      url,
    );
    return PoliciesCategoryModel.fromJson(response);
  }

  Future<DirectoryCategoryModel> getDirectoryCategory() async {
    final url = ApiConfig.directoryCategory;

    final response = await apiHelper.get(
      url,
    );
    return DirectoryCategoryModel.fromJson(response);
  }  Future<NotificationModel> getNotification() async {
    final url = ApiConfig.notification;

    final response = await apiHelper.get(
      url,
    );
    return NotificationModel.fromJson(response);
  }

  Future<PublicPhotoModel> publicPhoto() async {
    final url = ApiConfig.publicPhoto;
    final response = await apiHelper.get(
      url,
    );
    return PublicPhotoModel.fromJson(response);
  }

  Future<PublicNewsModel> publicNews() async {
    final url = ApiConfig.publicNews;

    final response = await apiHelper.get(
      url,
    );
    return PublicNewsModel.fromJson(response);
  }

  Future<VideoPlayerModel> publicVideo({required int page}) async {
    final url = ApiConfig.publicVideo;

    final response = await apiHelper.get(
      "${ApiConfig.publicVideo}?page=${page}",
    );
    return VideoPlayerModel.fromJson(response);
  }

  Future<PublicBannerModel> publicBanner() async {
    final url = ApiConfig.publicBanner;

    final response = await apiHelper.get(
      url,
    );
    return PublicBannerModel.fromJson(response);
  }

  Future<PublicPhotoModel> publicPhotoBooth(
      {required String startDate, required String endDate,required int page}) async {
    final url = ApiConfig.publicPhoto;

    final response = await apiHelper.get(
      "${url}?startDate=$startDate&endDate=$endDate&page=$page",
    );
    return PublicPhotoModel.fromJson(response);
  }

  Future<CultureBannerModel> cultureBanner() async {
    final url = ApiConfig.cultureBanner;

    final response = await apiHelper.get(
      url,
    );
    return CultureBannerModel.fromJson(response);
  }

  Future<SocialMediaModel> socialMedia() async {
    final url = ApiConfig.socialMedia;

    final response = await apiHelper.get(
      url,
    );
    return SocialMediaModel.fromJson(response);
  }

  Future<CultureAndHeritagModel> cultureHeritageList() async {
    final url = "${ApiConfig.cultureHeritage}";

    final response = await apiHelper.get(
      url,
    );
    return CultureAndHeritagModel.fromJson(response);
  }

  Future<EditProfileModel> updateProfile2({
    required String id,
    required Map<String, String> fields,
  }) async {
    final url = "${ApiConfig.updateProfile}/$id";

    final response = await apiHelper.post2(url, body: fields);
    return EditProfileModel.fromJson(response);
  }

  Future<EditProfileModel> updateProfile({
    required Map<String, String> fields,
    required Map<String, String> filePaths,
    // required String id,
  }) async {
    final url = ApiConfig.updateProfile;

    final response = await apiHelper.postMultipart2(
      fields: fields,
      filePaths: filePaths,
      url,
    );

    return EditProfileModel.fromJson(response);
  }

  Future<DistrictListModel> districtListApi() async {
    final url = ApiConfig.district;

    final response = await apiHelper.get(
      url,
    );
    return DistrictListModel.fromJson(response);
  }
  Future<FeedbackModel> feedbackApi({
    required String name,
    required String mobile,
    required String address,
    required String feedback,
}) async {
    final url = ApiConfig.feedback;
    var data={
    "name":name,
    "mobile":mobile,
    "address":address,
    "feedback":feedback
    };

    final response = await apiHelper.post(
      url,body:data
    );
    return FeedbackModel.fromJson(response);
  }

  Future<ProfileModel> profileApi() async {
    final url = "${ApiConfig.profile}";

    final response = await apiHelper.get(
      url,
    );
    return ProfileModel.fromJson(response);
  }

  Future<DistrictDetailModel> districtDetailApi({required String id}) async {
    final url = ApiConfig.district;

    final response = await apiHelper.get(
      "$url/$id",
    );
    return DistrictDetailModel.fromJson(response);
  }  Future<DistrictDetailModel> directoryDetailApi({required String id}) async {
    final url = ApiConfig.directoryDetail;

    final response = await apiHelper.get(
      "$url/$id",
    );
    return DistrictDetailModel.fromJson(response);
  }

  Future<CultureHeritagDetailModel> cultureHeritageDetailApi(
      {required String id}) async {
    final url = ApiConfig.cultureHeritage;

    final response = await apiHelper.get(
      "$url/$id",
    );
    return CultureHeritagDetailModel.fromJson(response);
  }

// Future<CmsPageModel?> getCmsPage() async {
//     final url = ApiConfig.cmsPages;
//     final response = await apiHelper.get(url,);
//     return CmsPageModel.fromJson(response);
// }
// Future<UserModel> fetchUser() async {
//   final response = await apiHelper.get("https://jsonplaceholder.typicode.com/users/1");
//   return UserModel.fromJson(response);
// }
  Future<Map<String, dynamic>> submitCustomFeedback({
    required String name,
    required String contactNumber,
    required String email,
    required String message,
  }) async {
    final url = ApiConfig.complaint; // Replace with your actual endpoint

    final body = {
      "name": name,
      "contactNumber": contactNumber,
      "email": email,
      "message": message,
    };

    final response = await apiHelper.post(url, body: body);
    return response; // Return the raw response as a Map
  }
}
