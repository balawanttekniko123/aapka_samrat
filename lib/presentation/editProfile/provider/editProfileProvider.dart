import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../auth/model/profileModel.dart';
import '../../../core/widgets/utils/utils.dart';
import '../../../data/services/api_service.dart';
import '../../bottomNav.dart';
import '../model/editProfileModel.dart';

class EditProfileProvider extends ChangeNotifier {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController districtController = TextEditingController();

  final UserService userService;

  EditProfileProvider(this.userService);

  EditProfileModel? editProfileModel;
  ProfileModel? profileModel;
  bool loading = false;
  String imagePath='';

  void setLoading(bool loader) {
    loading = loader;
    notifyListeners();
  }

  String? profileImagePath; // Save path as String


  Future<void> pickProfileImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImagePath = pickedFile.path;
      notifyListeners();
    }
  }
  Future<void> pickProfileImageWithCamera() async {
    final pickedFile =
    await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      profileImagePath = pickedFile.path;
      notifyListeners();
    }
  }

  Future<void> getProfile({required BuildContext context}) async {


    setLoading(true);

    print("Image Path>>>>>>>>>>>>>>>>> ${profileImagePath}");

    try {
      var response = await userService.profileApi();

      if (response.success == true) {
        profileModel = response;
        imagePath=profileModel!.data!.profileImage??'';
        nameController.text=profileModel!.data!.name??''  ;
        phoneController.text=profileModel!.data!.mobile??'' ;
        emailController.text=profileModel!.data!.email??''  ;
        stateController.text=profileModel!.data!.state??''  ;
        cityController.text=profileModel!.data!.city??''  ;
        districtController.text=profileModel!.data!.district??''  ;
      } else {
        Utils.toastMessage(response.message.toString());
      }
    } catch (e) {
      print(">>>>>>>>>>>>>${e}");
      Utils.toastMessage('An error occurred profile: $e');

    } finally {
      setLoading(false);
      notifyListeners();
    }
  }

  Future<void> updateProfile({required BuildContext context}) async {
    if (nameController.text.trim().isEmpty ||
        emailController.text.trim().isEmpty ||
        stateController.text.trim().isEmpty ||
        districtController.text.trim().isEmpty ||
        cityController.text.trim().isEmpty) {
      Utils.toastMessage('Please fill all required fields.');
      return;
    }

    setLoading(true);
    print("Image Path>>>>>>>>>>>>>>>>> ${profileImagePath}");

    try {
      var response = await userService.updateProfile(
        fields: {
          "name": nameController.text.trim(),
          "email": emailController.text.trim(),
          "state": stateController.text.trim(),
          "district": districtController.text.trim(),
          "city": cityController.text.trim(),
        },
        filePaths: profileImagePath != null
            ? {
          "profileImage": profileImagePath!,
        }
            : {},
      );

      print("Image Path ${profileImagePath}");

      if (response.status == true) {
        editProfileModel = response;
        getProfile(context: context);
        notifyListeners();
        Utils.toastMessage("Profile updated successfully");
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => BottomNavigationScreen(index: 0)));
      } else {
        Utils.toastMessage("Profile update failed");
      }
    } catch (e) {
      print(">>>>>>>>>>>>>${e}");
      Utils.toastMessage('An error occurred: $e');
    } finally {
      setLoading(false);
      notifyListeners();
    }
  }
}
