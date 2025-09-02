import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:samrat_chaudhary/presentation/publicFeedback/provider/directory_category_provider.dart';
import '../../../core/network/api-config.dart';

import '../../../core/utils/helper_functions.dart';
import '../../../core/widgets/components/customCard.dart';
import '../../../core/widgets/components/custom_appbar.dart';
import '../../../core/widgets/components/custom_drawer.dart';
import '../../../core/widgets/components/shimmerEffect.dart';
import '../../../core/widgets/components/translatorWidget.dart';
import '../../Culture_Heritage/provider/culture_heritage_Provider.dart';
import '../../Culture_Heritage/ui/Culture_heritage.dart';
import '../../Culture_Heritage/ui/district_deatils.dart';
import '../../letestDrawer.dart';
import 'districWiseLetephoneDirectory.dart';
import 'feedback_details.dart';

class PublicFeedback extends StatefulWidget {
  const PublicFeedback({super.key});

  @override
  State<PublicFeedback> createState() => _PublicFeedbackState();
}

class _PublicFeedbackState extends State<PublicFeedback> {
  @override
  void initState() {
    super.initState();
    getData();
    //init();
  }

  Future<void> getData() async {
    try {
      final provider =
          Provider.of<DirectoryCategoryProvider>(context, listen: false);
      await provider.getDirectoryCategory(context: context);
      provider.getDistrictApi(context: context);
    } catch (e) {
      log('Exception in getData: $e');
    }
  }

  init() {
    final pro = Provider.of<CultureHeritageProvider>(context, listen: false);
    pro.getCultureBannerApi(context: context);
    pro.getDistrictApi(context: context);
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        backgroundColor: Colors.white,

        appBar: const CommonAppBar(
          title:  "Telephone Directory",
          leadingBackButton: false,
        ),
       drawer: CustomDrawer2(),
       // drawer: CustomDrawer(),
        body: Consumer<DirectoryCategoryProvider>(
          builder: (context, directoryProvider, child) {
            return SafeArea(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.02,
                  vertical: screenWidth * 0.02,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    directoryProvider.directoryCategoryModel?.data == null
                        ? CustomShimmerContainer( height: 180,
                      width: MediaQuery.of(context).size.width,)
                        : GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                            ),
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: directoryProvider
                                .directoryCategoryModel!.data!.length,
                            itemBuilder: (context, index) {
                              var item = directoryProvider
                                  .directoryCategoryModel!.data![index];
                              return buildCard(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => DistricWiseTelephoneDirect(
                                        title: item.name!,
                                        directoryCategoryId: item.sId!,

                                      ),
                                    ));
                                 // );
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //     builder: (_) => FeedbackDetails(
                                  //       id: item.sId ?? 'N/A',
                                  //       title: item.name ?? 'N/A',
                                  //     ),
                                  //   ),
                                  // );
                                },
                                image: ApiConfig.imageBaseUrl +
                                    (item.thumbImage ?? ''),
                                title: item.name ?? 'N/A',
                              );
                            },
                          ),


                    const SizedBox(height: 20),
                    // Center(
                    //   child: TranslatedText(
                    //     "${directoryProvider.districtListModel?.data?.length ?? 0} Districts of Bihar",
                    //     style: const TextStyle(
                    //       fontSize: 18,
                    //       fontWeight: FontWeight.bold,
                    //       decoration: TextDecoration.underline,
                    //     ),
                    //   ),
                    // ),
                    // const SizedBox(height: 10),
                    // ClipRRect(
                    //   borderRadius: BorderRadius.circular(12),
                    //   child: Image.asset(
                    //     "assets/images/mapImage.png",
                    //     width: double.infinity,
                    //     height: 180,
                    //     fit: BoxFit.cover,
                    //   ),
                    // ),
                    // const SizedBox(height: 16),
                    // directoryProvider.districtListModel?.data == null
                    //     ? CustomShimmerContainer( height: 160,
                    //   width: MediaQuery.of(context).size.width,)
                    //     : GridView.builder(
                    //         gridDelegate:
                    //             const SliverGridDelegateWithFixedCrossAxisCount(
                    //           crossAxisCount: 2,
                    //           childAspectRatio: 3.5,
                    //           crossAxisSpacing: 12,
                    //           mainAxisSpacing: 12,
                    //         ),
                    //         physics: const NeverScrollableScrollPhysics(),
                    //         shrinkWrap: true,
                    //         itemCount: directoryProvider
                    //             .districtListModel!.data!.length,
                    //         itemBuilder: (context, index) {
                    //           final district = directoryProvider
                    //               .districtListModel!.data![index];
                    //           final colorModel =
                    //               colorList[index % colorList.length];
                    //
                    //           return buttonSection(
                    //             color: colorModel.primaryColor,
                    //             buttonColor: colorModel.borderColor,
                    //             title: district.districtName ?? "Unknown",
                    //             onTap: () {
                    //               Navigator.push(
                    //                 context,
                    //                 MaterialPageRoute(
                    //                   builder: (context) =>
                    //                       DistrictDetailScreen(
                    //                     id: district.sId ?? "",
                    //                     title:
                    //                         district.districtName ?? "Unknown",
                    //                     // districtData: district,
                    //                   ),
                    //                 ),
                    //               );
                    //             },
                    //           );
                    //         },
                    //       ),
                    // const SizedBox(height: 40),
                  ],
                ),
              ),
            );
          },
        ));
  }

  Widget buildCard({
    required String image,
    required String title,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AspectRatio(
        aspectRatio: 1,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.orange,
                    ),
                    padding: const EdgeInsets.all(4),
                    child: const Icon(Icons.north_east,
                        size: 14, color: Colors.white),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Image.network(image,height: 80,),
              // CircleAvatar(
              //   radius: 45,
              //   backgroundImage: NetworkImage(image),
              // ),
              const SizedBox(height: 5),
              Expanded(
                child: Center(
                  child: TranslatedText(
                    title,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buttonSection({
    required Color color,
    required Color buttonColor,
    required String title,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 45,
        width: MediaQuery.of(context).size.width * 0.45,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: buttonColor),
        ),
        child: TranslatedText(
          title,
          style: const TextStyle(fontWeight: FontWeight.w500),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
