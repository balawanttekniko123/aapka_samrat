import 'dart:io';

import 'package:flutter/material.dart';
import 'package:samrat_chaudhary/presentation/auth/model/consult_login_model.dart';
import 'package:samrat_chaudhary/core/storage/auth_token_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/otp_model.dart';
import '../../../core/widgets/utils/utils.dart';
import '../../bottomNav.dart';
import '../../home_screen.dart';
import '../ui/otp_screen.dart';
import '../../../data/services/api_service.dart';

class SignUpProvider extends ChangeNotifier {


  final UserService userService;

  SignUpProvider(this.userService);
  LoginModel? loginModel;
  OtpVerifyModel? otpVerifyModel;

  bool showOTP = false;
  bool otpSent = false;
  bool newUser = false;
  bool loading = false;
  bool loginLoading = false;

  void setLoading(bool loader) {
    loading = loader;
    notifyListeners();
  }

  void setLoginLoading(bool loader) {
    loginLoading = loader;
    notifyListeners();
  }

  // void phoneNumberChange({required mobileLenght}) {
  //   if (mobileLenght < 10) {
  //     showOTP = false;
  //     otpSent = false;
  //     notifyListeners();
  //   }
  // }

  void sendOTPMethod(
      {required BuildContext context, required String mobile}) async {
    setLoginLoading(true);
    var response = await userService.loginUser(context: context,mobile: mobile);
    try {

      if (response.status == true) {
        loginModel = response;

        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => OtpScreen(phoneNumber: mobile)));
        otpSent = true;
      } else {
        Utils.toastMessage(
          response.message.toString(),
        );
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => RegisterPage()),
        // );
      }
    } finally {
      setLoginLoading(false);
    }

    notifyListeners();
  }

  void verifyOtp(
      {required BuildContext context,
      required String mobile,
      required String otp}) async {
    setLoading(true);
    var response = await userService.otpVerify(context: context,mobile: mobile, otp: otp);
    try {

      if (response.status == true) {
        Utils.toastMessage(
          response.message.toString(),
        );
        otpVerifyModel = response;

        AuthTokenProvider().saveToken(response.token.toString());

        // SharedPreferences prefs = await SharedPreferences.getInstance();
        // prefs.setString(UserToken, response.token.toString());

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => BottomNavigationScreen(index: 0,)),
          (route) => false,
        );
      } else {
        Utils.toastMessage(
          response!.message.toString(),
        );
      }
    } finally {
      setLoading(false);
    }

    notifyListeners();
  }
  //
  // void getUserProfile({
  //   required BuildContext context,
  // }) async {
  //   setLoading(true);
  //   var response = await httpClients.getUserProfile();
  //   try {
  //
  //     if (response?.status == true) {
  //       // Utils.toastMessage(
  //       //   response!.message.toString(),
  //       // );
  //       userProfileModel = response;
  //     } else {
  //       Utils.toastMessage(
  //         response!.message.toString(),
  //       );
  //     }
  //   } finally {
  //     setLoading(false);
  //   }
  //
  //   notifyListeners();
  // }
  //
  // void registerUser({
  //   required BuildContext context,
  //   required String name,
  //   required String mobile,
  //   required String email,
  //   required String address,
  //   File? profileImage,
  // }) async {
  //   setLoading(true);
  //   var response = await httpClients.registerUser(
  //       mobile: mobile,
  //       name: name,
  //       address: address,
  //       email: email,
  //       profileImage: profileImage);
  //   try {
  //
  //     if (response?.status == true) {
  //       Utils.toastMessage(
  //         response!.message.toString(),
  //       );
  //       registerModel = response;
  //       Navigator.push(
  //           context,
  //           MaterialPageRoute(
  //               builder: (context) => OtpPage(mobileNumber: mobile)));
  //     } else {
  //       Utils.toastMessage(
  //         response!.message.toString(),
  //       );
  //     }
  //   } finally {
  //     setLoading(false);
  //   }
  //
  //   notifyListeners();
  // }
  //
  // void reSendOTPMethod(
  //     {required BuildContext context, required String mobile}) async {
  //   setLoading(true);
  //   var response = await httpClients.sendOtp(mobile: mobile);
  //   try {
  //
  //     if (response?.success == true) {
  //       Utils.toastMessage(
  //         response!.message.toString(),
  //       );
  //       loginModel = response;
  //     } else {
  //       Utils.toastMessage(
  //         response!.message.toString(),
  //       );
  //     }
  //   } finally {
  //     setLoading(false);
  //   }
  //
  //   notifyListeners();
  // }


}
