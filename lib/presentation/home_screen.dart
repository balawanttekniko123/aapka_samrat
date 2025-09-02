// import 'dart:developer';
//
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:samrat_chaudhary/core/network/environment.dart';
// import 'package:samrat_chaudhary/data/provider/home_provider.dart';
//
// import '../core/network/api-config.dart';
// import '../core/widgets/components/custom_appbar.dart';
// import '../core/widgets/components/custom_drawer.dart';
// import '../core/widgets/components/translatorWidget.dart';
// import 'bottomNav.dart';
// import 'leaderShipVision.dart';
//
// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});
//
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   getDetailData() async {
//     try {
//       final provider = Provider.of<HomeProvider>(context, listen: false);
//       provider.getHomeCategory(context: context);
//     } catch (e) {
//       log('Exception in homeSelectCategory: $e');
//     }
//   }
//
//   @override
//   void initState() {
//     getDetailData();
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: CommonAppBar(
//         title: "",
//         leadingBackButton: false,
//       ),
//       // appBar:AppBar(
//       //   leading: Padding(
//       //     padding: const EdgeInsets.only(left: 15),
//       //     child: Builder(
//       //         builder: (context) => GestureDetector(
//       //           child:
//       //           Image.asset('assets/images/menu_icon.png', scale: 4.5),
//       //           onTap: () => Scaffold.of(context).openDrawer(),
//       //         )),
//       //   ),
//       //   actions: [
//       //     Padding(
//       //       padding: const EdgeInsets.only(right: 15),
//       //       child: Row(
//       //         children: [
//       //           InkWell(
//       //               onTap:(){
//       //                 // Navigator.push(context, MaterialPageRoute(builder: (context) => NotificationScreen(),));
//       //               },
//       //               child: Image.asset('assets/images/language_icon.png', scale: 4.6)),
//       //         ],
//       //       ),
//       //     )
//       //   ],
//       // ),
//       drawer: CustomDrawer(),
//       body: Consumer<HomeProvider>(
//         builder: (context, provider, child) {
//           return provider.loading
//               ? Center(
//                   child: CircularProgressIndicator(),
//                 )
//               : provider.homeSelectedModel!.data!.isEmpty
//                   ? Center(child: Text('No selection available'))
//                   : GridView.builder(
//                       itemCount: provider.homeSelectedModel!.data!.length,
//                       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                           crossAxisCount: 2),
//                       itemBuilder: (context, index) {
//                         final selectedCategory =
//                             provider.homeSelectedModel!.data![index];
//                         return InkWell(
//                           onTap: () {
//                             Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) => BottomNavigationScreen(
//                                     index: 0,
//                                   ),
//                                 ));
// // Navigator.push(context, MaterialPageRoute(builder: (context) => LeadershipVisionScreen(),));
//                           },
//                           child: Container(
//                             // height: context.screenHeight*0.9,
//                             // width: context.screenWidth*0.3,
//                             // padding: EdgeInsets.all(4),
//                             margin: EdgeInsets.all(8),
//                             decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(15),
//                                 gradient: LinearGradient(colors: [
//                                   Color(0xFFF47216),
//                                   Color(0xFFF47216),
//                                 ]),
//                                 boxShadow: [
//                                   BoxShadow(
//                                       blurRadius: 4,
//                                       offset: Offset(0, 0),
//                                       color: Color.fromRGBO(0, 0, 0, 0.25))
//                                 ]),
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 ClipRRect(
//                                     borderRadius: BorderRadius.only(
//                                       topLeft: Radius.circular(15),
//                                       topRight: Radius.circular(15),
//                                     ),
//                                     child: Image.network(
//                                       ApiConfig.imageBaseUrl +
//                                           selectedCategory.image.toString(),
//                                       height: context.screenHeight * 0.136,
//                                       width: context.screenWidth,
//                                       fit: BoxFit.fill,
//                                       errorBuilder: (context, error, stackTrace) {
//                                         return
//                                           Image.asset("assets/images/emptyImage.jpg",   height: context.screenHeight * 0.136,
//                                             width: context.screenWidth,
//                                             fit: BoxFit.fill,);
//                                       },
//                                     )),
//                                 // Container(
//                                 //   // width: context.screenWidth,
//                                 //   // height: context.screenHeight*0.14,
//                                 //   decoration: BoxDecoration(
//                                 //    gradient: LinearGradient(colors: [
//                                 //      Color(0xFFF47216),
//                                 //      Color(0xFFF47216),
//                                 //    ]),
//                                 //     // image: DecorationImage(image: NetworkImage(ApiConfig.imageBaseUrl+selectedCategory.image.toString(),),fit: BoxFit.fill,)
//                                 //
//                                 //   ),
//                                 //   child:
//                                 // ),
//                                 Container(
//                                   height: context.screenHeight * 0.08,
//
//                                   padding: EdgeInsets.symmetric(
//                                       horizontal: 8, vertical: 4),
//                                   decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.only(
//                                       bottomLeft: Radius.circular(15),
//                                       bottomRight: Radius.circular(15),
//                                     ),
//                                     color: Colors.white,
//                                   ),
//                                   // alignment: Alignment.bottomCenter,
//                                   child: Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       SizedBox(
//                                           width: context.screenWidth * 0.3,
//                                           child: TranslatedText(
//                                             selectedCategory.name.toString(),
//                                             style: TextStyle(
//                                                 fontWeight: FontWeight.w500,
//                                                 fontSize: 12),
//                                           )),
//                                       Image.asset(
//                                         'assets/images/homeSelectionIcon.png',
//                                         scale: 4,
//                                       ),
//                                     ],
//                                   ),
//                                 )
//                               ],
//                             ),
//                           ),
//                         );
//                       });
//         },
//       ),
//     );
//   }
// }
