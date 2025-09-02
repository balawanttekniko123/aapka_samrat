import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:samrat_chaudhary/core/widgets/components/custom_appbar.dart';
import 'package:samrat_chaudhary/presentation/Culture_Heritage/provider/culture_heritage_Provider.dart';
import 'package:samrat_chaudhary/presentation/publicFeedback/ui/subDirectory.dart';

import '../../../core/network/api-config.dart';
import '../../../core/widgets/components/customCard.dart';
import '../../../core/widgets/components/custom_drawer.dart';
import '../../../core/widgets/components/shimmerEffect.dart';
import '../../../core/widgets/components/translatorWidget.dart';
import '../../letestDrawer.dart';
import '../../publicEngagement_communication/provider/PublicEngagementCommunicationProvider.dart';
import 'feedback_details.dart';

class DistricWiseTelephoneDirect extends StatefulWidget {
  final String directoryCategoryId;
  final String title;

  const DistricWiseTelephoneDirect(
      {super.key, required this.directoryCategoryId, required this.title});

  @override
  State<DistricWiseTelephoneDirect> createState() =>
      _DistricWiseTelephoneDirectState();
}

class _DistricWiseTelephoneDirectState
    extends State<DistricWiseTelephoneDirect> {
  @override
  void initState() {
    super.initState();
    init();
  }

  init() {
    final pro = Provider.of<CultureHeritageProvider>(context, listen: false);

    // pro.getCultureBannerApi(context: context);
    pro.getDistrictApi(context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommonAppBar(
        title: "List Of District",
        leadingBackButton: true,
      ),
     drawer: CustomDrawer2(),
     // drawer: CustomDrawer(),
      body: Consumer<CultureHeritageProvider>(
        builder: (context, provider, child) {
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                provider.districtListModel?.data == null
                    ? CustomShimmerContainer(
                        height: 160,
                        width: MediaQuery.of(context).size.width,
                      )
                    : ListView.builder(
                        // gridDelegate:
                        //     const SliverGridDelegateWithFixedCrossAxisCount(
                        //   crossAxisCount: 2,
                        //   childAspectRatio: 3.5,
                        //   crossAxisSpacing: 12,
                        //   mainAxisSpacing: 12,
                        // ),
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,

                        itemCount: provider.districtListModel!.data!.length,
                        itemBuilder: (context, index) {
                          var sNo=index+1;
                          final district =
                              provider.districtListModel!.data![index];
                          final colorModel =
                              colorList[index % colorList.length];
                          return GestureDetector(
                            onTap: (){
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) =>  FeedbackDetails(
                              //                 title: widget.title,
                              //                 directoryCategoryId:
                              //                     widget.directoryCategoryId,
                              //                 districtId: district.sId!,
                              //               ),
                              //   ),
                              // );
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>  subDirectories(
                                    title: widget.title,
                                    directoryCategoryID:
                                    widget.directoryCategoryId,
                                    districtID: district.sId!,
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 8),
                              margin: EdgeInsets.symmetric(vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    offset: const Offset(0, 4),
                                    // Pushes shadow only downward
                                    blurRadius: 6,
                                    spreadRadius: 0,
                                  ),
                                ],
                              ),
                              child:  Row(
                                children: [
                                  Text(
                                    "$sNo.",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16,
                                      // color: colorModel,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Text(
                                      district.districtName ?? "Unknown", style: const TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                          // return Padding(
                          //   padding: EdgeInsets.symmetric(vertical: 5),
                          //   child: buttonSection(
                          //     sNo: sNo.toString(),
                          //     color: colorModel.primaryColor,
                          //     buttonColor: colorModel.borderColor,
                          //     title: district.districtName ?? "Unknown",
                          //     onTap: () {
                          //       Navigator.push(
                          //           context,
                          //           MaterialPageRoute(
                          //             builder: (context) => FeedbackDetails(
                          //               title: widget.title,
                          //               directoryCategoryId:
                          //                   widget.directoryCategoryId,
                          //               districtId: district.sId!,
                          //             ),
                          //           ));
                          //     },
                          //   ),
                          // );
                        },
                      ),
                // const SizedBox(height: 40),
                //
                // const SizedBox(height: 16),
                // provider.cultureAndHeritagModel?.data == null
                //     ? CustomShimmerContainer(
                //     width: MediaQuery
                //         .of(context)
                //         .size
                //         .width,
                //     height: 150)
                //     : ListView.builder(
                //
                //   physics: const NeverScrollableScrollPhysics(),
                //   shrinkWrap: true,
                //   itemCount: provider.cultureAndHeritagModel!.data!.length,
                //   itemBuilder: (context, index) {
                //     final data = provider.cultureAndHeritagModel!.data![index];
                //     final colorModel = colorList[index % colorList.length];
                //
                //     return GestureDetector(
                //       onTap: () {
                //         //  Navigator.push(context, MaterialPageRoute(builder: (context) => CultureDetailsScreen(id: data.sId!,name: data.name!,),));
                //
                //       },
                //       child: Container(
                //         // height: 80,
                //         padding: EdgeInsets.symmetric(
                //             horizontal: 12, vertical: 12),
                //         margin: EdgeInsets.only(bottom: 10),
                //         alignment: Alignment.center,
                //         decoration: BoxDecoration(
                //           color: colorModel.primaryColor,
                //           borderRadius: BorderRadius.circular(12),
                //           border: Border.all(color: colorModel.borderColor),
                //         ),
                //         child: Row(
                //           children: [
                //             CircleAvatar(
                //               radius: 30,
                //
                //               backgroundImage: NetworkImage(
                //                   ApiConfig.imageBaseUrl +
                //                       data.image!.first.toString()),
                //             ),
                //             SizedBox(width: 5,),
                //             TranslatedText(
                //               data.name ?? "Unknown",
                //               style: const TextStyle(
                //                   fontWeight: FontWeight.w500),
                //               textAlign: TextAlign.center,
                //             ),
                //           ],
                //         ),
                //       ),
                //     );
                //   },
                // ),
                // const SizedBox(height: 40),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget buttonSection({
    required Color color,
    required Color buttonColor,
    required String title,
    required String sNo,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 55,
        width: MediaQuery.of(context).size.width * 0.45,
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: buttonColor),
        ),
        child: Row(
          children: [
            TranslatedText(
              "${sNo} : ",
              style: const TextStyle(fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
            SizedBox(width: 5,),
            TranslatedText(
              title,
              style: const TextStyle(fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
