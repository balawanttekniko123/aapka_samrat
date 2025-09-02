import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:samrat_chaudhary/core/network/api-config.dart';
import 'package:samrat_chaudhary/core/widgets/components/shimmerEffect.dart';
import 'package:samrat_chaudhary/core/widgets/components/translatorWidget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../presentation/cms/provider/cmsProvider.dart';
import '../../../presentation/cms/ui/cmsScreen.dart';
import '../../../presentation/cms/ui/contactusScreen.dart';
import '../../../presentation/cms/ui/faqScreen.dart';
import '../../../presentation/cms/ui/supportScreen.dart';
import '../../../presentation/editProfile/provider/editProfileProvider.dart';
import '../../../presentation/editProfile/ui/editProfileScreen.dart';
import '../../../presentation/splash_screen.dart';
import '../../storage/auth_token_provider.dart';
import '../../utils/helper_functions.dart';
import '../helper/deHlepr4.dart';
import '../helper/fHelper3.dart';
import '../helper/helper1.dart';
import '../helper/lhepler2.dart';
import 'custom_dialoge.dart';

class CustomDrawer extends StatefulWidget {
  // final BuildContext context;
  // final dynamic profileProvider; // Replace `dynamic` with your actual provider type

  const CustomDrawer({
    super.key,
    // required this.context,
    // required this.profileProvider,
  });

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  Widget _drawerTextWidget({required String title}) {
    return TranslatedText(
      title,
      style: const TextStyle(
        color: Color(0xFF333333),
        fontSize: 13,
        fontFamily: 'Roboto',
        fontWeight: FontWeight.w500,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    init();
  }



  init() {
    final provider = Provider.of<CMSProvider>(context, listen: false);
    provider.getCms(context: context);
    final pro = Provider.of<EditProfileProvider>(context, listen: false);
    pro.getProfile(context: context,);
  }




  @override
  Widget build(BuildContext context) {
    return Consumer2<CMSProvider, EditProfileProvider>(
      builder: (context, provider, editProvider, child) {
        return Drawer(
          backgroundColor: Colors.white,
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: MediaQuery.of(context).size.height * 0.08),
                        Padding(
                          padding: const EdgeInsets.only(left: 5, right: 12),
                          child: GestureDetector(
                            onTap: () {
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) => EditProfileScreen(),
                              //   ),
                              // );
                            },
                            child: Container(
                              height: 85,
                              width: MediaQuery.of(context).size.width,
                              // height: 200,
                              decoration: ShapeDecoration(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                shadows: [
                                  const BoxShadow(
                                    color: Color(0x3F000000),
                                    blurRadius: 4,
                                    offset: Offset(0, 0),
                                  )
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 5),
                                child:ListTile(
                                  leading: CircleAvatar(
                                    radius: 30,
                                  backgroundImage: AssetImage("assets/images/samratIcon.png"),
                                  //   backgroundImage: editProvider.profileModel!.data!.profileImage != ""
                                  //       ? NetworkImage(
                                  //     ApiConfig.imageBaseUrl +
                                  //         editProvider.profileModel!.data!.profileImage!,
                                  //   ) as ImageProvider
                                  //       : AssetImage("assets/images/emptyImage.jpg"),
                                   ),
                                  title: TranslatedText(
                                    "Samrat Choudhary",
                                   // editProvider.profileModel!.data!.name!,
                                    style: const TextStyle(
                                      color: Color(0xFF333333),
                                      fontSize: 13,
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  subtitle: TranslatedText(
                                    'Finance Minister of Bihar',
                                    style: TextStyle(
                                      color: Colors.black.withOpacity(0.5),
                                      fontSize: 11,
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                )

                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                        ListTile(
                          leading: const Icon(Icons.article_outlined),
                          title: _drawerTextWidget(title: 'FAQ'),
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => FAQScreen()));
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.privacy_tip_outlined),
                          title: _drawerTextWidget(title: 'Privacy Policy'),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CMSScreen(
                                  title: 'Privacy Policy',
                                  content: provider.cmsModel!.data!.first.privacyPolicy!,
                                ),
                              ),
                            );
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.note_alt_outlined),
                          title: _drawerTextWidget(title: 'Terms & Conditions'),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CMSScreen(
                                  title: 'Terms & Conditions',
                                  content: provider.cmsModel!.data!.first.termCondition!,
                                ),
                              ),
                            );
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.account_box_outlined),
                          title: _drawerTextWidget(title: 'About Us'),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CMSScreen(
                                  title: 'About Us',
                                  content: provider.cmsModel!.data!.first.aboutUs!,
                                ),
                              ),
                            );
                          },
                        ),
                        // ListTile(
                        //   leading: const Icon(Icons.support),
                        //   title: _drawerTextWidget(title: 'Support'),
                        //   onTap: () {
                        //     Navigator.push(context, MaterialPageRoute(builder: (context) => SupportScreen()));
                        //   },
                        // ),
                        // ListTile(
                        //   leading: const Icon(Icons.contacts_rounded),
                        //   title: _drawerTextWidget(title: 'Contact Us'),
                        //   onTap: () {
                        //     Navigator.push(context, MaterialPageRoute(builder: (context) => ContactUsScreen()));
                        //   },
                        // ),
                        // ListTile(
                        //   leading: const Icon(Icons.logout),
                        //   title: _drawerTextWidget(title: 'Logout'),
                        //   onTap: () {
                        //     showDialog(
                        //       context: context,
                        //       builder: (context) => LogoutDialog(
                        //         onConfirm: () async {
                        //           SharedPreferences prefs = await SharedPreferences.getInstance();
                        //           await prefs.clear();
                        //           await AuthTokenProvider().clearToken();
                        //           Navigator.pushAndRemoveUntil(
                        //             context,
                        //             MaterialPageRoute(builder: (context) => SplashScreen()),
                        //                 (Route<dynamic> route) => false,
                        //           );
                        //         },
                        //       ),
                        //     );
                        //   },
                        // ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      socialSection(
                        image: "assets/icons/facebook.png",
                        onPressed: () => HelperFunctions.launchExternalUrl('https://www.facebook.com/samratchoudharyofficial'),
                      ),
                      const SizedBox(width: 10),
                      socialSection(
                        image: "assets/icons/x-twitter.png",
                        onPressed: () => HelperFunctions.launchExternalUrl('https://x.com/'),
                      ),
                      const SizedBox(width: 10),
                      socialSection(
                        image: "assets/icons/instagram.png",
                        onPressed: () => HelperFunctions.launchExternalUrl('https://www.instagram.com/samratchoudharybjp/'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget socialSection({
    required String image,
    required VoidCallback onPressed
}){
    return GestureDetector(
      onTap: onPressed,
        child: Image.asset(image,height: 20,));
  }
}
