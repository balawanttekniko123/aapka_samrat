import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:samrat_chaudhary/core/network/api-config.dart';
import 'package:samrat_chaudhary/core/widgets/components/custom_appbar.dart';

import '../../../core/widgets/components/bottom_button.dart';
import '../../../core/widgets/components/input_TextForm_fields.dart';
import '../provider/editProfileProvider.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  @override
  void initState() {
    super.initState();
    // init();
  }

  init() {
    final pro = Provider.of<EditProfileProvider>(context, listen: false);
    pro.getProfile(context: context,);
  }


  @override
  Widget build(BuildContext context) {
    return Consumer<EditProfileProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: CommonAppBar(title: "Edit Profile"),
          body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            child: Column(
              children: [
                // GestureDetector(
                //   onTap: () {
                //     provider.pickProfileImage();
                //   },
                //   child:
                //   CircleAvatar(
                //     backgroundColor: Colors.orange,
                //     radius: 50,
                //     backgroundImage: provider.profileImagePath != null
                //         ? FileImage(File(provider.profileImagePath??''))
                //         : (provider.imagePath.isNotEmpty
                //         ? NetworkImage(ApiConfig.imageBaseUrl+provider.imagePath)
                //         : AssetImage("assets/images/emptyImage.jpg")
                //     as ImageProvider),
                //     child: GestureDetector(
                //       onTap: (){
                //         provider.pickProfileImageWithCamera();
                //       },
                //       child: Align(
                //         alignment: Alignment.bottomRight,
                //         child: CircleAvatar(
                //           radius: 15,
                //           backgroundColor: Colors.blue,
                //           child: Icon(Icons.camera_alt, color: Colors.white, size: 18),
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
                GestureDetector(
                  onTap: () {
                    _showImagePickerOptions(context, provider);
                  },
                  child: CircleAvatar(
                    backgroundColor: Colors.orange,
                    radius: 50,
                    backgroundImage: provider.profileImagePath != null
                        ? FileImage(File(provider.profileImagePath!))
                        : (provider.imagePath.isNotEmpty
                        ? NetworkImage(ApiConfig.imageBaseUrl + provider.imagePath)
                        : const AssetImage("assets/images/emptyImage.jpg")
                    as ImageProvider),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: CircleAvatar(
                        radius: 15,
                        backgroundColor: Colors.blue,
                        child: const Icon(Icons.camera_alt, color: Colors.white, size: 18),
                      ),
                    ),
                  ),
                ),

                SizedBox(
                  height: 20,
                ),
                inputTextFields(
                    title: "Name*",
                    textEditingController: provider.nameController),
                inputTextFields(
                  title: "Phone No*",
                  textEditingController: provider.phoneController,
                  isRead: provider.phoneController.text.isNotEmpty,
                ),
                inputTextFields(
                    title: "Email*",
                    textEditingController: provider.emailController),
                inputTextFields(
                    title: "State*",
                    textEditingController: provider.stateController),
                inputTextFields(
                    title: "District*",
                    textEditingController: provider.districtController),
                inputTextFields(
                    title: "City*",
                    textEditingController: provider.cityController),
                BottomButton(title: "Update",onPress: () async {
                 await provider.updateProfile(context: context);
                },)
              ],
            ),
          ),
        );
      },
    );
  }
  void _showImagePickerOptions(BuildContext context, EditProfileProvider provider) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Choose from Gallery'),
                onTap: () async {
                  Navigator.pop(context);
                  await provider.pickProfileImage();
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Take a Photo'),
                onTap: () async {
                  Navigator.pop(context);
                  await provider.pickProfileImageWithCamera();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
