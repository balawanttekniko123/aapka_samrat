import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:samrat_chaudhary/core/widgets/components/custom_appbar.dart';
import 'package:samrat_chaudhary/core/widgets/components/translatorWidget.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/network/api-config.dart';

import '../../../core/utils/helper_functions.dart';
import '../../../core/widgets/components/shimmerEffect.dart';
import '../../../core/widgets/components/translatorHtml.dart';
import '../provider/culture_heritage_detail_pro.dart';

class CultureDetailsScreen extends StatefulWidget {
  final String id;
  final String name;

  const CultureDetailsScreen({super.key, required this.id, required this.name});

  @override
  State<CultureDetailsScreen> createState() => _CultureDetailsScreenState();
}

class _CultureDetailsScreenState extends State<CultureDetailsScreen> {
  @override
  void initState() {
    super.initState();
    init();
  }

  init() {
    final pro =
        Provider.of<CultureHeritageDetailProvider>(context, listen: false);
    pro.cultureHeritageDetailApi(context: context, id: widget.id);
  }

  @override
  Widget build(BuildContext context) {
    final pro =
        Provider.of<CultureHeritageDetailProvider>(context, listen: false);
    return WillPopScope(
      onWillPop: () async {
        Provider.of<CultureHeritageDetailProvider>(context, listen: false)
            .clearData();
        return true; // allow back navigation
      },
      child: Scaffold(
        //  backgroundColor: Colors.orange.shade50,
        appBar: CommonAppBar(title: widget.name),
        body: Consumer<CultureHeritageDetailProvider>(
          builder: (context, pro, child) {
            if (pro.cultureHeritagDetailModel == null ||
                pro.cultureHeritagDetailModel!.data == null) {
              return SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: DetailPageShimmer(),
                ),
              );
            }

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  pro.cultureHeritagDetailModel?.data?.image == null
                      ?  CustomShimmerContainer(
                          height: 150.0,  width: MediaQuery.of(context).size.width,

                        )
                      : CarouselSlider(
                          options: CarouselOptions(
                            height: 150.0,
                            autoPlay: true,
                            enlargeCenterPage: true,
                            viewportFraction: 1.0,
                            aspectRatio: 16 / 9,
                            autoPlayInterval: const Duration(seconds: 3),
                          ),
                          items: pro.cultureHeritagDetailModel!.data!.image!
                              .map((imageUrl) {
                            return Builder(
                              builder: (BuildContext context) {
                                return Container(
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.orange.shade100,
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                      ApiConfig.imageBaseUrl + imageUrl,
                                      fit: BoxFit.fill,
                                      loadingBuilder: (context, child, loadingProgress) {
                                        if (loadingProgress == null) return child;

                                        return Shimmer.fromColors(
                                          baseColor: Colors.grey.shade300,
                                          highlightColor: Colors.grey.shade100,
                                          child: Container(
                                            height: 200, // apne hisab se fix height rakho
                                            width: double.infinity,
                                            color: Colors.white,
                                          ),
                                        );
                                      },
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return Image.asset(
                                            "assets/images/emptyImage.jpg");
                                      },
                                    ),
                                  ),
                                );
                              },
                            );
                          }).toList(),
                        ),
                  const SizedBox(height: 10),
                  TranslatedText(
                    pro.cultureHeritagDetailModel!.data!.name!,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepOrange,
                    ),
                  ),
                  const SizedBox(height: 5),
                  // TranslatedText(
                  //   pro.cultureHeritagDetailModel!.data!.description!,
                  //   style: const TextStyle(
                  //     fontSize: 15,
                  //     color: Colors.black87,
                  //   ),
                  // ),
                  TranslatedHtml(originalText: pro.cultureHeritagDetailModel!.data!.description!,),      //   style: const TextStyle(
            //     fontSize: 15,
            //     color: Colors.black87,
            //   ),)
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      const Icon(Icons.location_on, color: Colors.deepOrange),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          pro.cultureHeritagDetailModel!.data!.address!,
                          style: const TextStyle(fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
        floatingActionButton: buttonSection(
            color: Color(0xFFF47216),
            title: "Direction",
            onTap: () async {
               await _openGoogleMaps(context: context,
                  destinationLatitude:
                      pro.cultureHeritagDetailModel!.data!.lat!,
                  destinationLongitude:
                      pro.cultureHeritagDetailModel!.data!.log!);
            },
            // onTap: (){},
            // onTap: () {
            //   onTap: _openGoogleMaps;
            //   //google api key:AIzaSyAHPIRjWRQCrW60Gy6C8eSdGBXBYTv3UTA
            //   //latitude :26.765844
            //   //longitude :83.364944
            // },
            buttonColor: Color(0xFFF47216),
            textColor: Colors.white),
      ),
    );
  }

  Widget buttonSection(
      {required Color color,
      required Color buttonColor,
      required String title,
      required VoidCallback onTap,
      required Color textColor}) {
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
          style: TextStyle(fontWeight: FontWeight.w500, color: textColor),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  // void _openGoogleMaps(
  //     {required final destinationLatitude,
  //     required final destinationLongitude}) async {
  //   // const double destinationLatitude = 26.765844;
  //   // const double destinationLongitude = 83.364944;
  //
  //   final Uri googleMapsDirectionsUrl = Uri.parse(
  //     'https://www.google.com/maps/dir/?api=1&destination=$destinationLatitude,$destinationLongitude&travelmode=driving',
  //   );
  //
  //   if (await canLaunchUrl(googleMapsDirectionsUrl)) {
  //     await launchUrl(googleMapsDirectionsUrl,
  //         mode: LaunchMode.externalApplication);
  //   } else {
  //     debugPrint('Could not launch Google Maps');
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(content: Text('Could not open Google Maps.')),
  //     );
  //   }
  // }
  static Future<void> _openGoogleMaps({
    required BuildContext context,
    required var destinationLatitude,
    required var destinationLongitude,
  }) async {
   await HelperFunctions.launchExternalUrl('https://www.google.com/maps/dir/?api=1&destination=$destinationLatitude,$destinationLongitude&travelmode=driving');
  }

// void _openGoogleMaps() async {
//   const latitude = 26.765844;
//   const longitude = 83.364944;
//
//   final Uri googleMapsWebUrl = Uri.parse('https://www.google.com/maps/search/?api=1&query=$latitude,$longitude');
//
//   if (await canLaunchUrl(googleMapsWebUrl)) {
//     await launchUrl(googleMapsWebUrl, mode: LaunchMode.externalApplication);
//   } else {
//     debugPrint('Could not launch Google Maps');
//
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(content: Text('Could not open Google Maps.')),
//     );
//   }
// }
}
