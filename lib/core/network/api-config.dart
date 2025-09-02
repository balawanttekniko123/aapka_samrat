import 'environment.dart';

class ApiConfig {
  static String get baseUrl {
    if (Environment.isDev) {
     // return 'http://192.168.1.14:8978/api/';
    return 'http://167.71.232.245:8978/api/';
    } else {
   //  return 'http://192.168.1.14:8978/api/';
    return 'http://167.71.232.245:8978/api/';
    }
    // return 'http://192.168.1.24:8978/api/';
  }

  static String get imageBaseUrl {
    if (Environment.isDev) {
    //  return 'http://192.168.1.17:8978/';
       return 'http://167.71.232.245:8978/';
    } else {
    //  return 'http://192.168.1.17:8978/';
      return 'http://167.71.232.245:8978/';
    }
  }



  // 🚀 Define endpoints here
  static String get login => '${baseUrl}user/signUp';
  static String get verifyOtp => '${baseUrl}user/verifyOtp';
  static String get category => '${baseUrl}user/category';
  static String get leadershipBanner => '${baseUrl}user/leadershipBanner';
  static String get roadMap => '${baseUrl}user/roadMap';
  static String get youth => '${baseUrl}user/youth';
  static String get leadershipStory => '${baseUrl}user/leadershipStory'; static String get cms => '${baseUrl}user/cms';
  static String get leadershipDetail => '${baseUrl}user/leadershipDetail';
  static String get government => '${baseUrl}user/government';
  static String get leadershipMilestone => '${baseUrl}user/leadershipMilestone';
  static String get scheme => '${baseUrl}user/scheme/';
  static String get directoryDetails => '${baseUrl}user/directory/';
  static String get schemeCategory => '${baseUrl}user/schemeCategory';
  static String get department => '${baseUrl}user/department';
  static String get allSchemeCategory => '${baseUrl}user/scheme/allSchemeCategory';
  static String get commonSchemeCategory => '${baseUrl}user/scheme/commanSchemeCategory';
  static String get policy => '${baseUrl}user/policy';
  static String get directoryCategory => '${baseUrl}user/directoryCategory';
  static String get notification => '${baseUrl}user/notification';
  static String get cultureBanner => '${baseUrl}user/cultureBanner';
  static String get socialMedia => '${baseUrl}admin/socialMedia';
  static String get cultureHeritage => '${baseUrl}user/cultureHeritagePlace';
  static String get updateProfile => '${baseUrl}user/updateProfile';
  static String get district => '${baseUrl}user/district';
  static String get directoryDetail => '${baseUrl}user/directory';
  static String get subdirectoryCategory => '${baseUrl}user/subdirectoryCategory?';
  static String get feedback => '${baseUrl}user/feedback';
  static String get complaint => '${baseUrl}user/complaint';
  static String get profile => '${baseUrl}user/profile';
  static String get cmsPages => '${baseUrl}user/cmsPages';
  static String get register => '${baseUrl}auth/register';
  static String get refreshToken => '${baseUrl}auth/refresh-token';
  static String get publicVideo => '${baseUrl}user/publicVideo';
  static String get publicNews => '${baseUrl}user/publicNews';
  static String get publicPhoto => '${baseUrl}user/publicPhoto';
  static String get publicBanner => '${baseUrl}user/publicBanner';
  static String get getUserProfile => '${baseUrl}user/profile';
  static String updateUserProfile(String userId) => '${baseUrl}user/$userId/update';

  static String uploadFile() => '${baseUrl}files/upload';

// Add more as needed
}
