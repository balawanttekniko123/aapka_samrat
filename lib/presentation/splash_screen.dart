// import 'dart:async';
// import 'dart:developer';
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:samrat_chaudhary/core/storage/auth_token_provider.dart';
// import 'package:samrat_chaudhary/presentation/home_screen.dart';
//
// import 'bottomNav.dart';
// import 'auth/ui/login_screen.dart';
//
// class SplashScreen extends StatefulWidget {
//   const SplashScreen({Key? key}) : super(key: key);
//
//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }
//
// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
//     Timer(Duration(seconds: 2), () {
//       getRouteNavigate();
//     });
//     super.initState();
//   }
//
//   getRouteNavigate() async {
//     final token = await AuthTokenProvider().getToken();
//     log('tokenSplashCheck===>$token');
//     if (token != null && token != "") {
//       Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(
//             builder: (context) => BottomNavigationScreen(
//               index: 0,
//             ),
//           ));
//     } else {
//       Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(
//             builder: (context) => BottomNavigationScreen(
//               index: 0,
//             ),
//           ));
//       // Navigator.pushReplacement(
//       //     context,
//       //     MaterialPageRoute(
//       //       builder: (context) => LoginScreen(),
//       //     ));
//     }
//
//     // SharedPreferences prefs = await SharedPreferences.getInstance();
//     // final token = prefs.getString(UserToken);
//
//     // if (token != null && token != "") {
//     //   log('yeeeeeenhi');
//     //   Navigator.pushReplacement(
//     //       context,
//     //       MaterialPageRoute(
//     //         builder: (context) => HomePage(),
//     //       ));
//     // } else {
//     //   log('asdasdhashdhas');
//     //   Navigator.pushReplacement(
//     //       context,
//     //       MaterialPageRoute(
//     //         builder: (context) => LoginPage(),
//     //       ));
//     // }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Container(
//         width: MediaQuery.of(context).size.width,
//         height: MediaQuery.of(context).size.height,
//         decoration: BoxDecoration(color: Color(0xFFF47216)),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             SizedBox(
//               height: 10,
//             ),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Image.asset(
//                   'assets/images/samratIcon.png',
//                   scale: 4,
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 SizedBox(
//                     width: MediaQuery.of(context).size.width * 0.8,
//                     child: Text(
//                       "Samart Choudhary, Deputy Chief Minister, Government of Bihar",
//                       textAlign: TextAlign.center,
//                       style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500),
//                     )),
//               ],
//             ),
//             Text(
//               "Developed By Tekniko Global",
//               style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 12,
//                   letterSpacing: 0.3,
//                   fontWeight: FontWeight.w500,
//                   height: 1.5),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:samrat_chaudhary/core/storage/auth_token_provider.dart';
import 'auth/ui/login_screen.dart';
import 'bottomNav.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late AnimationController _imageController;
  late AnimationController _textController;
  late AnimationController _footerController;

  late Animation<Offset> _imageSlideAnimation;
  late Animation<Offset> _textSlideAnimation;
  late Animation<double> _imageFadeAnimation;
  late Animation<double> _textFadeAnimation;
  late Animation<double> _footerFadeAnimation;

  @override
  void initState() {
    super.initState();

    _imageController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _textController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _footerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _imageSlideAnimation = Tween<Offset>(
      begin: const Offset(0, -1.0), // From top
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _imageController, curve: Curves.easeOut));

    _textSlideAnimation = Tween<Offset>(
      begin: const Offset(0, 1.0), // From bottom
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _textController, curve: Curves.easeOut));

    _imageFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _imageController, curve: Curves.easeIn),
    );

    _textFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _textController, curve: Curves.easeIn),
    );

    _footerFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _footerController, curve: Curves.easeIn),
    );

    _startAnimations();

    Timer(const Duration(seconds: 3), () {
      getRouteNavigate();
    });
  }

  void _startAnimations() async {
    await _imageController.forward();
    await _textController.forward();
    await _footerController.forward();
  }

  @override
  void dispose() {
    _imageController.dispose();
    _textController.dispose();
    _footerController.dispose();
    super.dispose();
  }

  Future<void> getRouteNavigate() async {
    final token = await AuthTokenProvider().getToken();
    log('tokenSplashCheck===>$token');
    if(token != null) {
      Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => BottomNavigationScreen(index: 0)),
    );
    }else{
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF47216),
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(height: 10),
              Column(
                children: [
                  SlideTransition(
                    position: _imageSlideAnimation,
                    child: FadeTransition(
                      opacity: _imageFadeAnimation,
                      child: Container(
                        // padding: EdgeInsets.all(0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(100)
                        ),
                          
                          // child: Icon(Icons.person,size: 100,)),
                        child: Container(
                          // padding: const EdgeInsets.all(1),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: ClipOval(
                            child: Image.asset(
                              'assets/images/samratImageSpash.jpeg',
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),),
                        // child: Image.asset(
                      //   'assets/images/samratIcon.png',
                      //   scale: 4,
                      // ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SlideTransition(
                    position: _textSlideAnimation,
                    child: FadeTransition(
                      opacity: _textFadeAnimation,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0,),
                        child: RichText(
                          textAlign: TextAlign.center,

                          text: TextSpan(
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              height: 1.4,
                            ),
                            children: [

                              TextSpan(
                                text: 'Samrat Choudhary\n',
                                style: TextStyle(
                                  fontSize: 25, // Larger font
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              // TextSpan(
                              //   text: 'Deputy Chief Minister, Government of Bihar.',
                              //   style: TextStyle(
                              //     fontSize: 16, // Smaller font
                              //     color: Colors.white,
                              //   ),
                              // ),
                            ],
                          ),
                        )

                      ),
                    ),
                  ),
                ],
              ),


               Padding(
                padding: EdgeInsets.only(bottom: 20.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image.asset("assets/icons/Frame 3.png",height: 45,),

                          Image.asset("assets/icons/Frame 4.png",height: 45,),
                          Image.asset("assets/icons/Frame 5.png",height: 45,),
                          Image.asset("assets/icons/Frame 6.png",height: 45,),
                        ],
                      ),
                    ),
                    SizedBox(height: 20,),
                    Text(
                      "© 2025. All Rights Reserved APKA SAMRAT.",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        letterSpacing: 0.3,
                        fontWeight: FontWeight.w500,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
