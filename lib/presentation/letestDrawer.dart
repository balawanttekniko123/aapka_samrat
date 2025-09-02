import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:samrat_chaudhary/presentation/editProfile/ui/editProfileScreen.dart';
import 'package:samrat_chaudhary/presentation/publicFeedback/ui/public_feedback.dart';
import 'package:samrat_chaudhary/presentation/scheme_and_policies/ui/goverments.dart';
import 'package:samrat_chaudhary/presentation/scheme_and_policies/ui/schemePolicies_screen.dart';
import 'package:samrat_chaudhary/presentation/splash_screen.dart';

import '../commingSoonScreen.dart';
import '../core/network/api-config.dart';
import '../core/storage/auth_token_provider.dart';
import '../core/utils/helper_functions.dart';
import '../core/widgets/custom_image_view.dart';
import 'cms/provider/cmsProvider.dart';
import 'cms/ui/cmsScreen.dart';
import 'editProfile/provider/editProfileProvider.dart';
import 'feedBack/ui/complaint.dart';
import 'feedBack/ui/feedbackScreen.dart';
import 'notification/notificationScreen.dart';

class CustomDrawer2 extends StatefulWidget {
  @override
  State<CustomDrawer2> createState() => _CustomDrawer2State();
}

class _CustomDrawer2State extends State<CustomDrawer2> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      init();
    });
  }

  void init() {
    final cmsProvider = Provider.of<CMSProvider>(context, listen: false);
    cmsProvider.getCms(context: context);

    // final profileProvider = Provider.of<EditProfileProvider>(context, listen: false);
    // profileProvider.getProfile(context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CMSProvider>(
      builder: (context, provider, child) {
        return Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              Consumer<EditProfileProvider>(
                builder: (context, provider, child) {
                  final userName = provider.profileModel?.data?.name ?? 'User Name';
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => EditProfileScreen()),
                      );
                    },
                    child: Container(
                      height: 170,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xFFFF5F00),
                            Color(0xFFFFB300),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: const BorderRadius.only(
                          bottomRight: Radius.circular(40),
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.orange,
                            radius: 30,
                            backgroundImage: provider.profileImagePath != null
                                ? FileImage(File(provider.profileImagePath??''))
                                : (provider.imagePath.isNotEmpty
                                ? NetworkImage(ApiConfig.imageBaseUrl+provider.imagePath)
                                : AssetImage("assets/images/emptyImage.jpg")
                            as ImageProvider),
                          ),
                          const SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                userName,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),

              // Mailboxes
              drawerItem(() {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditProfileScreen(),
                    ));
                final pro =
                    Provider.of<EditProfileProvider>(context, listen: false);
                pro.getProfile(context: context);
              }, Icons.account_circle, "My Profile", ""),
              drawerItem(() {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NotificationScreen(),
                    ));
              }, Icons.notifications_active, "Notification", ""),
              drawerItem(() {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FeedbackScreen(),
                    ));
              }, Icons.feedback_outlined, "Feedback", "",
                  badgeColor: Colors.blue),
              // drawerItem(() {
              //   Navigator.push(context, MaterialPageRoute(builder: (context) => ComplaintScreen(),));
              // HelperFunctions.launchExternalUrl(
              // 'https://lokshikayat.bihar.gov.in/onlinegrivance.aspx');
              //
              // }, Icons.report_problem, "Complaint", "",
              //     badgeColor: Colors.green),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
                child: Text("All labels",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black54)),
              ),

              drawerItem(() {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GovermentScreen(
                        // title: 'About Us', departmentID: '',
                        // content: provider.cmsModel!.data!.first.aboutUs!,
                        ),
                  ),
                );
              }, Icons.schema, "Initiative", ""),
        //drawerItem(() {
              //   Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //       builder: (context) => PublicFeedback(
              //           // title: 'About Us', departmentID: '',
              //           // content: provider.cmsModel!.data!.first.aboutUs!,
              //           ),
              //     ),
              //   );
              // }, Icons.call, "Contact", ""),
              drawerItem(() {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CMSScreen(
                      title: 'About Us',
                      content: provider.cmsModel!.data!.first.aboutUs!,
                    ),
                  ),
                );
              }, Icons.info_outline, "About Us", ""),
              drawerItem(() {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CMSScreen(
                      title: 'Terms & Conditions',
                      content: provider.cmsModel!.data!.first.termCondition!,
                    ),
                  ),
                );
              }, Icons.description_outlined, "Terms and Conditions", ""),
              drawerItem(() {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CMSScreen(
                      title: 'Privacy Policy',
                      content: provider.cmsModel!.data!.first.privacyPolicy!,
                    ),
                  ),
                );
              }, Icons.privacy_tip_outlined, "Privacy Policy", ""),
              drawerItem(() {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ComminSoonScreen(),
                    ));
              }, Icons.star_rate_outlined, "Rate Us", ""),
              drawerItem(() {
                HelperFunctions.launchExternalUrl(
                    'https://admin.samratchoudhary.com/#/deleteaccount');
              }, Icons.delete_forever_outlined, "Delete Account", ""),
              // drawerItem(() {
              //   Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //         builder: (context) => ComminSoonScreen(),
              //       ));
              // }, Icons.delete_forever_outlined, "Delete Profile", ""),
              drawerItem(() {
                Logout(context);
              }, Icons.logout, "LogOut", ""),
            ],
          ),
        );
      },
    );
  }

  void Logout(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        title: Text('Confirm Logout'),
        content: Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () async {
              print('LOGOUT');
              Navigator.of(context).pop();
              await AuthTokenProvider().clearToken();
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const SplashScreen()),
                (Route<dynamic> route) => false,
              );
            },
            style: TextButton.styleFrom(
              side: BorderSide(color: Colors.orange),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: Text('Yes'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              foregroundColor: Colors.white,
            ),
            child: Text('No'),
          ),
        ],
      ),
    );
  }

  Widget drawerItem(
      VoidCallback onTap, IconData icon, String title, String count,
      {Color badgeColor = Colors.grey}) {
    return ListTile(
      leading: Icon(icon, color: Colors.grey[700]),
      title: Text(title),
      onTap: onTap,
      trailing: count.isNotEmpty
          ? Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: badgeColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                count,
                style: TextStyle(
                    color: badgeColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 12),
              ),
            )
          : null,
    );
  }
}
