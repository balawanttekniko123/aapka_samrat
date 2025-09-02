



import 'dart:io';

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:samrat_chaudhary/core/widgets/components/custom_appbar.dart';
import 'package:samrat_chaudhary/main.dart';
import 'package:samrat_chaudhary/presentation/letestDrawer.dart';
import 'package:samrat_chaudhary/presentation/publicEngagement_communication/provider/photoBoothProvider.dart';
import 'package:samrat_chaudhary/presentation/publicEngagement_communication/ui/PhotoBoothScreen.dart';
import 'package:samrat_chaudhary/presentation/publicEngagement_communication/ui/videoListScreen.dart';
import 'package:samrat_chaudhary/presentation/publicEngagement_communication/ui/videoPlayerScreen.dart';
import '../../../core/network/api-config.dart';
import '../../../core/utils/helper_functions.dart';
import '../../../core/widgets/components/shimmerEffect.dart';
import '../../../core/widgets/components/translatorWidget.dart';
import '../../../videoShowLetets.dart';
import '../../editProfile/provider/editProfileProvider.dart';
import '../../feedBack/ui/complaint.dart';
import '../../leadershipVision/provider/home_provider.dart';
import '../../leadershipVision/ui/storiesScreen.dart';
import '../../notification/notificationScreen.dart';
import '../../socialMedia/ui/youTubeScreen.dart';
import '../provider/PublicEngagementCommunicationProvider.dart';

import 'full_screen_gallery_screen.dart';
import 'newsAndMedia.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class PublicEngagementCommunicationScreen extends StatefulWidget {
  const PublicEngagementCommunicationScreen({super.key});

  @override
  State<PublicEngagementCommunicationScreen> createState() =>
      _PublicEngagementCommunicationScreenState();
}

class _PublicEngagementCommunicationScreenState
    extends State<PublicEngagementCommunicationScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      init();
    });
  }


  init() {
    final profileProvider = Provider.of<EditProfileProvider>(context, listen: false);
    profileProvider.getProfile(context: context);
    final pro = Provider.of<PublicEngagementCommunicationProvider>(context,
        listen: false);
    final pro2 = Provider.of<HomeProvider>(context, listen: false);
    final pro3 = Provider.of<PhotoBoothProvider>(context, listen: false);
    //pro3.getSocialMedia(context: context);
    pro3.getPhotoBooth(context: context, endDate: "", startDate: "");
    pro2.getLeadershipStory(context: context);
    pro.getPublicVideo(context: context);
    pro.getPublicBanner(context: context);
    pro.getPublicNews(context: context);
    pro.getPublicPhoto(context: context);

  }

  final controller = AnimatedTextController();

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return RefreshIndicator(
      onRefresh: () async {
        await init();
      },
      child: Consumer3<PublicEngagementCommunicationProvider, HomeProvider,
          PhotoBoothProvider>(
        builder: (context, provider, homePro, photoBoothPro, child) {
          final videos = provider.videoPlayerModel?.data ?? [];

          final leadershipStories = homePro.leadershipStoryModel?.data ?? [];
          print("Leadership story count: ${leadershipStories.length}");

          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              flexibleSpace: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFFFF5F00), // Bright Orange
                      Color(0xFFFFB300), // Warm Yellow
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
              leading: Consumer<EditProfileProvider>(
                builder: (context, provider, _) {
                  ImageProvider profileImage;

                  if (provider.profileImagePath != null && provider.profileImagePath!.isNotEmpty) {
                    profileImage = FileImage(File(provider.profileImagePath!));
                  } else if (provider.imagePath.isNotEmpty) {
                    profileImage = NetworkImage(ApiConfig.imageBaseUrl + provider.imagePath);
                  } else {
                    profileImage = const AssetImage("assets/images/emptyImage.jpg");
                  }

                  return GestureDetector(
                    onTap: () {
                      Scaffold.of(context).openDrawer();
                    },
                    child: Container(
                      // padding: const EdgeInsets.all(8),
                      margin: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: CircleAvatar(
                        radius: 14,
                        backgroundImage: profileImage,
                      ),
                    ),
                  );
                },
              ),
              title: AnimatedTextKit(
                animatedTexts: [
                  TyperAnimatedText(
                    'APKA SAMRAT',
                    textStyle: const TextStyle(
                      fontFamily: 'Nunito',
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    speed: const Duration(milliseconds: 200),
                  ),
                ],
                displayFullTextOnTap: true,
                stopPauseOnTap: true,

                //  isRepeatingCursor: false,
                totalRepeatCount: 4,
                controller: controller,
              ),
              actions: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NotificationScreen(),
                        ));
                  },
                  child: Padding(
                    padding: EdgeInsets.only(right: 12.0),
                    child: Icon(
                      Icons.notifications,
                      color: Colors.white,
                      size: 32,
                    ),
                  ),
                ),
              ],
            ),
          drawer: CustomDrawer2(),
          //  drawer: CustomDrawer(),
            body: SingleChildScrollView(
              padding: EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TranslatedText(
                    'Stories',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  (homePro.leadershipStoryModel?.data == null ||
                          homePro.leadershipStoryModel == null)
                      ? CustomShimmerContainer(
                          width: MediaQuery.of(context).size.width, height: 80)
                      : homePro.leadershipStoryModel!.data!.isNotEmpty
                          ? SizedBox(
                              height: 80.0,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount:
                                    homePro.leadershipStoryModel!.data!.length,
                                // Example number of stories
                                itemBuilder: (context, index) {
                                  final story =
                                      homePro.leadershipStoryModel!.data![index];
                                  return Padding(
                                    padding: const EdgeInsets.only(right: 16.0),
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => StoryScreen(
                                                imageList: story.image,
                                                title:story.title??"Stories" ,
                                                date: story.createdAt??'Not Available',
                                              ),
                                            ));
                                      },
                                      child: SizedBox(
                                        width: 80,
                                        height: 80,
                                        child: CustomPaint(
                                          painter: StoryBorderPainter(
                                              segments: story.image?.length ?? 1),
                                          child: Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: CircleAvatar(
                                              radius: 35.0,
                                              backgroundImage: NetworkImage(
                                                ApiConfig.imageBaseUrl +
                                                    story.image![0].toString(),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            )
                          : SizedBox(),
                  SizedBox(
                    height: 20,
                  ),
                  (provider.publicBannerModel==null||provider.publicBannerModel!.data==null)
                      ? CustomShimmerContainer(
                          width: MediaQuery.of(context).size.width, height: 150)
                      : provider.publicBannerModel!.data!.isEmpty?SizedBox():CarouselSlider(
                    options: CarouselOptions(
                      height: 170.0,
                      autoPlay: true,
                      enlargeCenterPage: true,
                      viewportFraction: 1.0,
                      aspectRatio: 16 / 9,
                      autoPlayInterval: Duration(seconds: 6),
                    ),
                    // items: imageList.map((imageUrl) {
                    items:
                    provider.publicBannerModel!.data!.map((imageUrl) {
                      print("MMMMXZCDSSSSSSSSSSLLL${ provider.publicBannerModel!.data!.length}");
                      return Builder(
                        builder: (BuildContext context) {
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              ApiConfig.imageBaseUrl + imageUrl.image![0],
                              fit: BoxFit.fill,
                              width: MediaQuery.of(context).size.width,
                              loadingBuilder:
                                  (context, child, loadingProgress) {
                                if (loadingProgress == null) return child;
                                return Stack(
                                  children: [
                                    Container(
                                      width:
                                      MediaQuery.of(context).size.width,
                                      height: 150,
                                      color: Colors
                                          .grey.shade50, // Light background
                                    ),
                                    Positioned.fill(
                                      child: Center(
                                        child: CustomShimmerContainer(
                                          width: MediaQuery.of(context)
                                              .size
                                              .width,
                                          height: 150,
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                              errorBuilder: (context, error, stackTrace) {
                                return Image.asset(
                                  "assets/images/emptyImage.jpg",
                                  fit: BoxFit.fill,
                                );
                              },
                            ),
                          );
                        },
                      );
                    }).toList(),
                  ),

                  SizedBox(
                    height: 20,
                  ),
                  (photoBoothPro.publicPhotoModel == null ||
                          photoBoothPro.publicPhotoModel?.data == null)
                      ? CustomShimmerContainer(height: 150, width: width)
                      : photoBoothPro.publicPhotoModel!.data!.isNotEmpty
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TranslatedText(
                                  'Photo Gallery',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              PhotoBoothScreen(),
                                        ));
                                  },
                                  child: TranslatedText(
                                    'See all',
                                  ),
                                ),
                              ],
                            )
                          : SizedBox(),
                  SizedBox(
                    height: 10,
                  ),
                  (photoBoothPro.publicPhotoModel == null ||
                          photoBoothPro.publicPhotoModel?.data == null)
                      ? CustomShimmerContainer(
                          width: MediaQuery.of(context).size.width, height: 80)
                      : photoBoothPro.publicPhotoModel!.data!.isNotEmpty
                          ? SizedBox(
                              height: 120.0,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount:
                                    photoBoothPro.publicPhotoModel!.data!.length,
                                // Example number of stories
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      // Navigator.push(
                                      //     context,
                                      //     MaterialPageRoute(
                                      //       builder: (context) =>
                                      //           PhotoBoothScreen(),
                                      //     ));
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => FullScreenGalleryScreen(
                                            imageUrls: provider.publicPhotoModel!
                                                .data![index].image!
                                                .map((img) =>
                                                    ApiConfig.imageBaseUrl + img)
                                                .toList(),
                                            initialIndex:
                                                0, // optional: index of the image clicked
                                          ),
                                        ),
                                      );
                                    },
                                    child: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 16.0),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(10),
                                          child: Image.network(
                                            ApiConfig.imageBaseUrl +
                                                photoBoothPro.publicPhotoModel!
                                                    .data![index].image!.first,
                                            height: 120,
                                            width: 120,
                                            fit: BoxFit.fill,
                                            errorBuilder:
                                                (context, error, stackTrace) {
                                              return Image.asset(
                                                "assets/images/emptyImage.jpg",
                                                height: 120,
                                                width: 120,
                                                fit: BoxFit.fill,
                                              );
                                            },
                                          ),
                                        )),
                                  );
                                },
                              ))
                          : SizedBox(),

                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TranslatedText(
                        "Videos",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                      TextButton(
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => TotalVideoListScreen(),));

                        },
                        child: const TranslatedText(
                          'See all',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                  // headingSection(onTap: () {}, title: "Videos"),
                 (provider.videoPlayerModel == null|| provider.videoPlayerModel!.data == null)
                      ? CustomShimmerContainer(
                          width: MediaQuery.of(context).size.width, height: 190)
                      : provider.videoPlayerModel!.data!.isEmpty?SizedBox():SizedBox(
                   height: 160,
                   child: ListView.separated(
                     scrollDirection: Axis.horizontal,
                     itemCount: videos.length,
                     separatorBuilder: (context, index) =>
                     const SizedBox(width: 8.0),
                     itemBuilder: (context, index) {
                       final video = videos[index];

                       '${ApiConfig.imageBaseUrl}${video.thumbImage}';
                       final videoUrl =
                           '${ApiConfig.imageBaseUrl}${video.video}';
                       return GestureDetector(
                         onTap: () {
                           // Navigator.push(context, MaterialPageRoute(builder: (context) => TotalVideoListScreen(),));


                           Navigator.push(
                             context,
                             MaterialPageRoute(
                               builder: (_) => ScrollableVideoScreen(
                                 videoUrls: videos
                                     .map((v) =>
                                 '${ApiConfig.imageBaseUrl}${v.video?.first}')
                                 // '${ApiConfig.imageBaseUrl}${v.video}')
                                     .toList(),
                                 titles: videos
                                     .map((v) => v.title ?? '')
                                     .toList(),
                                 initialIndex: index,
                               ),
                             ),
                           );
                         },
                         child: Container(
                           width: 150,
                           height: 200,
                           decoration: BoxDecoration(
                             borderRadius: BorderRadius.circular(12.0),
                             color: Colors.grey.shade200,
                           ),
                           child: Stack(
                             fit: StackFit.expand,
                             children: [
                               ClipRRect(
                                 borderRadius: BorderRadius.circular(12.0),
                                 child: Image.network(
                                   "${ApiConfig.imageBaseUrl}${video.thumbImage}",
                                   //   'http://167.71.232.245:8978/${video.thumbImage}',
                                   fit: BoxFit.fill,
                                   errorBuilder:
                                       (context, error, stackTrace) {
                                     return Image.asset(
                                       "assets/images/emptyImage.jpg",
                                       fit: BoxFit.fill,
                                     );
                                   },
                                 ),
                               ),
                               const Center(
                                 child: Icon(Icons.play_circle_fill,
                                     size: 40, color: Colors.white),
                               ),
                               Container(
                                 decoration: BoxDecoration(
                                     color: Colors.black.withOpacity(0.4),
                                     borderRadius:
                                     BorderRadius.circular(12)),
                                 child: Align(
                                   alignment: Alignment.bottomLeft,
                                   child: Padding(
                                     padding: const EdgeInsets.all(8.0),
                                     child: TranslatedText(
                                       video.title ?? '',
                                       style: const TextStyle(
                                         color: Colors.white,
                                         fontWeight: FontWeight.w500,
                                         fontSize: 12,
                                       ),
                                       maxLines: 3,
                                     ),
                                   ),
                                 ),
                               ),
                             ],
                           ),
                         ),
                       );
                     },
                   ),
                 ),
                  headingSection(title: 'News and Media', onTap: () {}),
                  provider.publicNewsModel?.data?[0].image == null
                      ? CustomShimmerContainer(
                          width: MediaQuery.of(context).size.width, height: 130)
                      : SizedBox(
                          height: 130,
                          child: LayoutBuilder(builder: (context, constraints) {
                            final itemWidth = constraints.maxWidth * 0.75;

                            return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: provider.publicNewsModel!.data!.length,
                              itemBuilder: (context, index) {
                                var data = provider.publicNewsModel!.data![index];
                                return GestureDetector(
                                  onTap: (){
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            NewsAndMedia(
                                              imageUrl:
                                              ApiConfig.imageBaseUrl +
                                                  data.image![0],
                                              title: 'News',
                                              summary: data.summary ?? '',
                                            ),
                                      ),
                                    );
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 12.0),
                                    child: Container(
                                      width: itemWidth,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12.0),
                                        color: Colors.grey.shade200,
                                      ),
                                      child: Stack(
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(12.0),
                                            child: Image.network(
                                              ApiConfig.imageBaseUrl +
                                                  data.image![0],
                                              fit: BoxFit.fill,
                                              width: itemWidth,
                                              height: double.infinity,
                                              errorBuilder:
                                                  (context, error, stackTrace) {
                                                return Image.asset(
                                                  "assets/images/emptyImage.jpg",
                                                  fit: BoxFit.cover,
                                                  width: itemWidth,
                                                  height: double.infinity,
                                                );
                                              },
                                            ),
                                          ),
                                          Positioned(
                                            bottom: 0,
                                            child: GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        NewsAndMedia(
                                                      imageUrl:
                                                          ApiConfig.imageBaseUrl +
                                                              data.image![0],
                                                      title: 'News',
                                                      summary: data.summary ?? '',
                                                    ),
                                                  ),
                                                );
                                              },
                                              child: Container(
                                                width: itemWidth,
                                                height: 50,
                                                decoration: BoxDecoration(
                                                  color:
                                                      Colors.black.withOpacity(0.5),
                                                  borderRadius:
                                                      const BorderRadius.only(
                                                    bottomLeft: Radius.circular(12),
                                                    bottomRight:
                                                        Radius.circular(12),
                                                  ),
                                                ),
                                                padding: const EdgeInsets.symmetric(
                                                    horizontal: 8),
                                                child: Align(
                                                  alignment: Alignment.centerLeft,
                                                  child: RichText(
                                                    overflow: TextOverflow.ellipsis,
                                                    maxLines: 2,
                                                    text: TextSpan(
                                                      children: [
                                                        TextSpan(
                                                          text: data.summary
                                                              .toString(),
                                                          style: const TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                        ),
                                                        const TextSpan(
                                                          text: ' Read more',
                                                          style: TextStyle(
                                                            color:
                                                                Color(0xFFF47216),
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          }),
                        ),

                  SizedBox(
                    height: 10,
                  ),

                  TranslatedText(
                    "Social Media",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  YouTubeScreen(),
               //   YouTubeWebViewScreen();
                 // SizedBox(height: 170, child: YouTubeVideoSection()),
                  // headingSection(title: 'Complaint', onTap: () {}),//todo
                ],
              ),
            ),
            floatingActionButton: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                socialSection(
                  image: "assets/icons/facebook.png",
                  onPressed: () => HelperFunctions.launchExternalUrl('https://www.facebook.com/samratchoudharyofficial'),
                ),
                const SizedBox(height: 10),
                socialSection(
                  image: "assets/icons/x-twitter.png",
                  onPressed: () => HelperFunctions.launchExternalUrl('https://x.com/'),
                ),
                const SizedBox(height: 10),
                socialSection(
                  image: "assets/icons/instagram.png",
                  onPressed: () => HelperFunctions.launchExternalUrl('https://www.instagram.com/samratchoudharybjp/'),
                ),
                // const SizedBox(height: 10),
                // socialSection(
                //   icon: Icon(Icons.feedback_outlined, size: 35, color: Colors.deepOrange),
                //   onPressed: () =>Navigator.push(context, MaterialPageRoute(builder: (context) => ComplaintScreen(),)),
                // ),
              ],
            ),
          );
        },
      ),
    );
  }

  // Widget socialSection({
  //   required String image,
  //   required VoidCallback onPressed
  // }){
  //   return GestureDetector(
  //       onTap: onPressed,
  //       child: Image.asset(image,height: 35,));
  // }
  Widget socialSection({
    String? image, // Make image optional
    Icon? icon,
    required VoidCallback onPressed,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: icon != null
          ? icon // Display the icon if it's provided
          : image != null
          ? Image.asset(image, height: 35) // Display the image if icon is not provided
          : SizedBox.shrink(), // Return an empty widget if neither is provided
    );
  }

  Widget headingSection({
    required String title,
    required VoidCallback onTap,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TranslatedText(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
        ),
        TextButton(
          onPressed: onTap,
          child: const TranslatedText(
            'See all',
            style: TextStyle(color: Colors.grey),
          ),
        ),
      ],
    );
  }
}

class StoryBorderPainter extends CustomPainter {
  final int segments;
  final Color color;
  final double strokeWidth;

  StoryBorderPainter({
    required this.segments,
    this.color = const Color(0xFFff8000),
    this.strokeWidth = 3.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (segments <= 0) return;

    final rect = Offset.zero & size;
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final double gap = 8; // degrees
    final double totalGap = segments * gap;
    final double segmentAngle = (360 - totalGap) / segments;
    final double startAngleOffset = -90; // Start from top

    for (int i = 0; i < segments; i++) {
      final double startAngle =
          (startAngleOffset + i * (segmentAngle + gap)) * (3.1416 / 180);
      final double sweepAngle = segmentAngle * (3.1416 / 180);
      canvas.drawArc(
        rect.deflate(strokeWidth / 2),
        startAngle,
        sweepAngle,
        false,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}


















//
// class PublicEngagementCommunicationScreen extends StatefulWidget {
//   const PublicEngagementCommunicationScreen({super.key});
//
//   @override
//   State<PublicEngagementCommunicationScreen> createState() =>
//       _PublicEngagementCommunicationScreenState();
// }
//
// class _PublicEngagementCommunicationScreenState
//     extends State<PublicEngagementCommunicationScreen> {
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//
//   @override
//   void initState() {
//     super.initState();
//     init();
//   }
//
//   init() {
//     final pro = Provider.of<PublicEngagementCommunicationProvider>(context,
//         listen: false);
//     final pro2 = Provider.of<HomeProvider>(context, listen: false);
//     final pro3 = Provider.of<PhotoBoothProvider>(context, listen: false);
//     //pro3.getSocialMedia(context: context);
//     pro3.getPhotoBooth(context: context, endDate: "", startDate: "");
//     pro2.getLeadershipStory(context: context);
//     pro.getPublicVideo(context: context);
//     pro.getPublicBanner(context: context);
//     pro.getPublicNews(context: context);
//     pro.getPublicPhoto(context: context);
//   }
//
//   final controller = AnimatedTextController();
//
//   @override
//   Widget build(BuildContext context) {
//     var width = MediaQuery.of(context).size.width;
//     var height = MediaQuery.of(context).size.height;
//     return RefreshIndicator(
//       onRefresh: () async {
//         await init();
//       },
//       child: Consumer3<PublicEngagementCommunicationProvider, HomeProvider,
//           PhotoBoothProvider>(
//         builder: (context, provider, homePro, photoBoothPro, child) {
//           final videos = provider.videoPlayerModel?.data ?? [];
//
//           final leadershipStories = homePro.leadershipStoryModel?.data ?? [];
//           print("Leadership story count: ${leadershipStories.length}");
//
//           return Scaffold(
//             backgroundColor: Colors.white,
//             appBar: AppBar(
//               flexibleSpace: Container(
//                 decoration: BoxDecoration(
//                   gradient: LinearGradient(
//                     colors: [
//                       Color(0xFFFF5F00), // Bright Orange
//                       Color(0xFFFFB300), // Warm Yellow
//                     ],
//                     begin: Alignment.topLeft,
//                     end: Alignment.bottomRight,
//                   ),
//                 ),
//               ),
//               leading: Builder(builder: (context) {
//                 return GestureDetector(
//                   onTap: () {
//                     print(">>>>>>>>>>>>>start");
//                     Scaffold.of(context).openDrawer();
//                     print(">>>>>>>>>>>>>end");
//                   },
//                   child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Image.asset("assets/images/menu_icon.png"),
//                   ),
//                 );
//               }),
//               title: AnimatedTextKit(
//                 animatedTexts: [
//                   TyperAnimatedText(
//                     'APKA SAMRAT',
//                     textStyle: const TextStyle(
//                       fontFamily: 'Nunito',
//                       fontSize: 20.0,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white,
//                     ),
//                     speed: const Duration(milliseconds: 200),
//                   ),
//                 ],
//                 displayFullTextOnTap: true,
//                 stopPauseOnTap: true,
//
//                 //  isRepeatingCursor: false,
//                 totalRepeatCount: 4,
//                 controller: controller,
//               ),
//               actions: [
//                 GestureDetector(
//                   onTap: () {
//                     Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => NotificationScreen(),
//                         ));
//                   },
//                   child: Padding(
//                     padding: EdgeInsets.only(right: 12.0),
//                     child: Icon(
//                       Icons.notifications,
//                       color: Colors.white,
//                       size: 32,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             drawer: CustomDrawer(),
//             body: SingleChildScrollView(
//               padding: EdgeInsets.all(14),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [
//                   TranslatedText(
//                     'Stories',
//                     style: TextStyle(
//                       fontSize: 16.0,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                   SizedBox(
//                     height: 10,
//                   ),
//                   (homePro.leadershipStoryModel?.data == null ||
//                       homePro.leadershipStoryModel == null)
//                       ? CustomShimmerContainer(
//                       width: MediaQuery.of(context).size.width, height: 80)
//                       : homePro.leadershipStoryModel!.data!.isNotEmpty
//                       ? SizedBox(
//                     height: 80.0,
//                     child: ListView.builder(
//                       scrollDirection: Axis.horizontal,
//                       itemCount:
//                       homePro.leadershipStoryModel!.data!.length,
//                       // Example number of stories
//                       itemBuilder: (context, index) {
//                         final story =
//                         homePro.leadershipStoryModel!.data![index];
//                         return Padding(
//                           padding: const EdgeInsets.only(right: 16.0),
//                           child: InkWell(
//                             onTap: () {
//                               Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                     builder: (context) => StoryScreen(
//                                       imageList: story.image,
//                                       title:story.title??"Test Title" ,
//                                       date: story.createdAt!,
//                                     ),
//                                   ));
//                             },
//                             child: SizedBox(
//                               width: 80,
//                               height: 80,
//                               child: CustomPaint(
//                                 painter: StoryBorderPainter(
//                                     segments: story.image?.length ?? 1),
//                                 child: Padding(
//                                   padding: const EdgeInsets.all(5.0),
//                                   child: CircleAvatar(
//                                     radius: 35.0,
//                                     backgroundImage: NetworkImage(
//                                       ApiConfig.imageBaseUrl +
//                                           story.image![0].toString(),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         );
//                       },
//                     ),
//                   )
//                       : SizedBox(),
//                   SizedBox(
//                     height: 20,
//                   ),
//                   (provider.publicBannerModel==null||provider.publicBannerModel!.data==null)
//                       ? CustomShimmerContainer(
//                       width: MediaQuery.of(context).size.width, height: 150)
//                       : provider.publicBannerModel!.data!.isEmpty?SizedBox():CarouselSlider(
//                     options: CarouselOptions(
//                       height: 170.0,
//                       autoPlay: true,
//                       enlargeCenterPage: true,
//                       viewportFraction: 1.0,
//                       aspectRatio: 16 / 9,
//                       autoPlayInterval: Duration(seconds: 6),
//                     ),
//                     // items: imageList.map((imageUrl) {
//                     items:
//                     provider.publicBannerModel!.data!.map((imageUrl) {
//                       print("MMMMXZCDSSSSSSSSSSLLL${ provider.publicBannerModel!.data!.length}");
//                       return Builder(
//                         builder: (BuildContext context) {
//                           return ClipRRect(
//                             borderRadius: BorderRadius.circular(10),
//                             child: Image.network(
//                               ApiConfig.imageBaseUrl + imageUrl.image![0],
//                               fit: BoxFit.fill,
//                               width: MediaQuery.of(context).size.width,
//                               loadingBuilder:
//                                   (context, child, loadingProgress) {
//                                 if (loadingProgress == null) return child;
//                                 return Stack(
//                                   children: [
//                                     Container(
//                                       width:
//                                       MediaQuery.of(context).size.width,
//                                       height: 150,
//                                       color: Colors
//                                           .grey.shade50, // Light background
//                                     ),
//                                     Positioned.fill(
//                                       child: Center(
//                                         child: CustomShimmerContainer(
//                                           width: MediaQuery.of(context)
//                                               .size
//                                               .width,
//                                           height: 150,
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 );
//                               },
//                               errorBuilder: (context, error, stackTrace) {
//                                 return Image.asset(
//                                   "assets/images/emptyImage.jpg",
//                                   fit: BoxFit.fill,
//                                 );
//                               },
//                             ),
//                           );
//                         },
//                       );
//                     }).toList(),
//                   ),
//
//                   SizedBox(
//                     height: 20,
//                   ),
//                   (photoBoothPro.publicPhotoModel == null ||
//                       photoBoothPro.publicPhotoModel?.data == null)
//                       ? CustomShimmerContainer(height: 150, width: width)
//                       : photoBoothPro.publicPhotoModel!.data!.isNotEmpty
//                       ? Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       TranslatedText(
//                         'Photo Gallery',
//                         style: TextStyle(
//                           fontSize: 16.0,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                       GestureDetector(
//                         onTap: () {
//                           Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) =>
//                                     PhotoBoothScreen(),
//                               ));
//                         },
//                         child: TranslatedText(
//                           'See all',
//                         ),
//                       ),
//                     ],
//                   )
//                       : SizedBox(),
//                   SizedBox(
//                     height: 10,
//                   ),
//                   (photoBoothPro.publicPhotoModel == null ||
//                       photoBoothPro.publicPhotoModel?.data == null)
//                       ? CustomShimmerContainer(
//                       width: MediaQuery.of(context).size.width, height: 80)
//                       : photoBoothPro.publicPhotoModel!.data!.isNotEmpty
//                       ? SizedBox(
//                       height: 120.0,
//                       child: ListView.builder(
//                         scrollDirection: Axis.horizontal,
//                         itemCount:
//                         photoBoothPro.publicPhotoModel!.data!.length,
//                         // Example number of stories
//                         itemBuilder: (context, index) {
//                           return GestureDetector(
//                             onTap: () {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (_) => FullScreenGalleryScreen(
//                                     imageUrls: provider.publicPhotoModel!
//                                         .data![index].image!
//                                         .map((img) =>
//                                     ApiConfig.imageBaseUrl + img)
//                                         .toList(),
//                                     initialIndex:
//                                     0, // optional: index of the image clicked
//                                   ),
//                                 ),
//                               );
//                             },
//                             child: Padding(
//                                 padding:
//                                 const EdgeInsets.only(right: 16.0),
//                                 child: ClipRRect(
//                                   borderRadius: BorderRadius.circular(10),
//                                   child: Image.network(
//                                     ApiConfig.imageBaseUrl +
//                                         photoBoothPro.publicPhotoModel!
//                                             .data![index].image!.first,
//                                     height: 120,
//                                     width: 120,
//                                     fit: BoxFit.fill,
//                                     errorBuilder:
//                                         (context, error, stackTrace) {
//                                       return Image.asset(
//                                         "assets/images/emptyImage.jpg",
//                                         height: 120,
//                                         width: 120,
//                                         fit: BoxFit.fill,
//                                       );
//                                     },
//                                   ),
//                                 )),
//                           );
//                         },
//                       ))
//                       : SizedBox(),
//
//                   SizedBox(
//                     height: 10,
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       TranslatedText(
//                         "Videos",
//                         style: TextStyle(
//                           fontWeight: FontWeight.w500,
//                           fontSize: 16,
//                         ),
//                       ),
//                       TextButton(
//                         onPressed: (){
//
//                         },
//                         child: const TranslatedText(
//                           'See all',
//                           style: TextStyle(color: Colors.grey),
//                         ),
//                       ),
//                     ],
//                   ),
//                   // headingSection(onTap: () {}, title: "Videos"),
//                   (provider.videoPlayerModel == null|| provider.videoPlayerModel!.data == null)
//                       ? CustomShimmerContainer(
//                       width: MediaQuery.of(context).size.width, height: 190)
//                       : provider.videoPlayerModel!.data!.isEmpty?SizedBox():SizedBox(
//                     height: 190,
//                     child: ListView.separated(
//                       scrollDirection: Axis.horizontal,
//                       itemCount: videos.length,
//                       separatorBuilder: (context, index) =>
//                       const SizedBox(width: 8.0),
//                       itemBuilder: (context, index) {
//                         final video = videos[index];
//
//                         '${ApiConfig.imageBaseUrl}${video.thumbImage}';
//                         final videoUrl =
//                             '${ApiConfig.imageBaseUrl}${video.video?.first}';
//                         return GestureDetector(
//                           onTap: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (_) => ScrollableVideoScreen(
//                                   videoUrls: videos
//                                       .map((v) =>
//                                   '${ApiConfig.imageBaseUrl}${v.video?.first}')
//                                       .toList(),
//                                   titles: videos
//                                       .map((v) => v.title ?? '')
//                                       .toList(),
//                                 ),
//                               ),
//                             );
//                           },
//                           child: Container(
//                             width: 150,
//                             height: 200,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(12.0),
//                               color: Colors.grey.shade200,
//                             ),
//                             child: Stack(
//                               fit: StackFit.expand,
//                               children: [
//                                 ClipRRect(
//                                   borderRadius: BorderRadius.circular(12.0),
//                                   child: Image.network(
//                                     "${ApiConfig.imageBaseUrl}${video.thumbImage}",
//                                     //   'http://167.71.232.245:8978/${video.thumbImage}',
//                                     fit: BoxFit.fill,
//                                     errorBuilder:
//                                         (context, error, stackTrace) {
//                                       return Image.asset(
//                                         "assets/images/emptyImage.jpg",
//                                         fit: BoxFit.fill,
//                                       );
//                                     },
//                                   ),
//                                 ),
//                                 const Center(
//                                   child: Icon(Icons.play_circle_fill,
//                                       size: 40, color: Colors.white),
//                                 ),
//                                 Container(
//                                   decoration: BoxDecoration(
//                                       color: Colors.black.withOpacity(0.4),
//                                       borderRadius:
//                                       BorderRadius.circular(12)),
//                                   child: Align(
//                                     alignment: Alignment.bottomLeft,
//                                     child: Padding(
//                                       padding: const EdgeInsets.all(8.0),
//                                       child: TranslatedText(
//                                         video.title ?? '',
//                                         style: const TextStyle(
//                                           color: Colors.white,
//                                           fontWeight: FontWeight.w500,
//                                           fontSize: 12,
//                                         ),
//                                         maxLines: 3,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//                   headingSection(title: 'News and Media', onTap: () {}),
//                   provider.publicNewsModel?.data?[0].image == null
//                       ? CustomShimmerContainer(
//                       width: MediaQuery.of(context).size.width, height: 130)
//                       : SizedBox(
//                     height: 130,
//                     child: LayoutBuilder(builder: (context, constraints) {
//                       final itemWidth = constraints.maxWidth * 0.75;
//
//                       return ListView.builder(
//                         scrollDirection: Axis.horizontal,
//                         itemCount: provider.publicNewsModel!.data!.length,
//                         itemBuilder: (context, index) {
//                           var data = provider.publicNewsModel!.data![index];
//                           return GestureDetector(
//                             onTap: (){
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) =>
//                                       NewsAndMedia(
//                                         imageUrl:
//                                         ApiConfig.imageBaseUrl +
//                                             data.image![0],
//                                         title: 'News',
//                                         summary: data.summary ?? '',
//                                       ),
//                                 ),
//                               );
//                             },
//                             child: Padding(
//                               padding: const EdgeInsets.only(right: 12.0),
//                               child: Container(
//                                 width: itemWidth,
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(12.0),
//                                   color: Colors.grey.shade200,
//                                 ),
//                                 child: Stack(
//                                   children: [
//                                     ClipRRect(
//                                       borderRadius:
//                                       BorderRadius.circular(12.0),
//                                       child: Image.network(
//                                         ApiConfig.imageBaseUrl +
//                                             data.image![0],
//                                         fit: BoxFit.fill,
//                                         width: itemWidth,
//                                         height: double.infinity,
//                                         errorBuilder:
//                                             (context, error, stackTrace) {
//                                           return Image.asset(
//                                             "assets/images/emptyImage.jpg",
//                                             fit: BoxFit.cover,
//                                             width: itemWidth,
//                                             height: double.infinity,
//                                           );
//                                         },
//                                       ),
//                                     ),
//                                     Positioned(
//                                       bottom: 0,
//                                       child: GestureDetector(
//                                         onTap: () {
//                                           Navigator.push(
//                                             context,
//                                             MaterialPageRoute(
//                                               builder: (context) =>
//                                                   NewsAndMedia(
//                                                     imageUrl:
//                                                     ApiConfig.imageBaseUrl +
//                                                         data.image![0],
//                                                     title: 'News',
//                                                     summary: data.summary ?? '',
//                                                   ),
//                                             ),
//                                           );
//                                         },
//                                         child: Container(
//                                           width: itemWidth,
//                                           height: 50,
//                                           decoration: BoxDecoration(
//                                             color:
//                                             Colors.black.withOpacity(0.5),
//                                             borderRadius:
//                                             const BorderRadius.only(
//                                               bottomLeft: Radius.circular(12),
//                                               bottomRight:
//                                               Radius.circular(12),
//                                             ),
//                                           ),
//                                           padding: const EdgeInsets.symmetric(
//                                               horizontal: 8),
//                                           child: Align(
//                                             alignment: Alignment.centerLeft,
//                                             child: RichText(
//                                               overflow: TextOverflow.ellipsis,
//                                               maxLines: 2,
//                                               text: TextSpan(
//                                                 children: [
//                                                   TextSpan(
//                                                     text: data.summary
//                                                         .toString(),
//                                                     style: const TextStyle(
//                                                       color: Colors.white,
//                                                       fontSize: 12,
//                                                       fontWeight:
//                                                       FontWeight.w500,
//                                                     ),
//                                                   ),
//                                                   const TextSpan(
//                                                     text: ' Read more',
//                                                     style: TextStyle(
//                                                       color:
//                                                       Color(0xFFF47216),
//                                                       fontSize: 12,
//                                                       fontWeight:
//                                                       FontWeight.w500,
//                                                     ),
//                                                   ),
//                                                 ],
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           );
//                         },
//                       );
//                     }),
//                   ),
//
//                   SizedBox(
//                     height: 10,
//                   ),
//
//                   TranslatedText(
//                     "Social Media",
//                     style: TextStyle(
//                       fontWeight: FontWeight.w500,
//                       fontSize: 16,
//                     ),
//                   ),
//                   SizedBox(
//                     height: 10,
//                   ),
//                   SizedBox(
//                     height: 400,
//                       child: YouTubeVideoSection()),
//                 ],
//               ),
//             ),
//             floatingActionButton: Column(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 socialSection(
//                   image: "assets/icons/facebook.png",
//                   onPressed: () => HelperFunctions.launchExternalUrl('https://www.facebook.com/samratchoudharyofficial'),
//                 ),
//                 const SizedBox(height: 10),
//                 socialSection(
//                   image: "assets/icons/x-twitter.png",
//                   onPressed: () => HelperFunctions.launchExternalUrl('https://x.com/'),
//                 ),
//                 const SizedBox(height: 10),
//                 socialSection(
//                   image: "assets/icons/instagram.png",
//                   onPressed: () => HelperFunctions.launchExternalUrl('https://www.instagram.com/samratchoudharybjp/'),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
//
//   Widget socialSection({
//     required String image,
//     required VoidCallback onPressed
//   }){
//     return GestureDetector(
//         onTap: onPressed,
//         child: Image.asset(image,height: 35,));
//   }
//
//   Widget headingSection({
//     required String title,
//     required VoidCallback onTap,
//   }) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         TranslatedText(
//           title,
//           style: TextStyle(
//             fontWeight: FontWeight.w500,
//             fontSize: 16,
//           ),
//         ),
//         TextButton(
//           onPressed: onTap,
//           child: const TranslatedText(
//             'See all',
//             style: TextStyle(color: Colors.grey),
//           ),
//         ),
//       ],
//     );
//   }
// }
//
// class StoryBorderPainter extends CustomPainter {
//   final int segments;
//   final Color color;
//   final double strokeWidth;
//
//   StoryBorderPainter({
//     required this.segments,
//     this.color = const Color(0xFFff8000),
//     this.strokeWidth = 3.0,
//   });
//
//   @override
//   void paint(Canvas canvas, Size size) {
//     if (segments <= 0) return;
//
//     final rect = Offset.zero & size;
//     final paint = Paint()
//       ..color = color
//       ..strokeWidth = strokeWidth
//       ..style = PaintingStyle.stroke
//       ..strokeCap = StrokeCap.round;
//
//     final double gap = 8; // degrees
//     final double totalGap = segments * gap;
//     final double segmentAngle = (360 - totalGap) / segments;
//     final double startAngleOffset = -90; // Start from top
//
//     for (int i = 0; i < segments; i++) {
//       final double startAngle =
//           (startAngleOffset + i * (segmentAngle + gap)) * (3.1416 / 180);
//       final double sweepAngle = segmentAngle * (3.1416 / 180);
//       canvas.drawArc(
//         rect.deflate(strokeWidth / 2),
//         startAngle,
//         sweepAngle,
//         false,
//         paint,
//       );
//     }
//   }
//
//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
// }



