import 'dart:developer';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';
import 'package:samrat_chaudhary/core/network/api-config.dart';
import 'package:samrat_chaudhary/core/widgets/components/custom_appbar.dart';
import 'package:samrat_chaudhary/presentation/leadershipVision/ui/storiesScreen.dart';

import '../../../core/widgets/components/custom_drawer.dart';
import '../../../core/widgets/components/shimmerEffect.dart';
import '../../../core/widgets/components/translatorWidget.dart';
import '../../letestDrawer.dart';
import '../provider/home_provider.dart';
import '../provider/language_provider.dart';
import '../../../data/services/translation_service.dart';
import 'SamratChoudharyCarrerScreen.dart';
import 'mileStone.dart';

class LeadershipVisionScreen extends StatefulWidget {
  const LeadershipVisionScreen({super.key});

  @override
  State<LeadershipVisionScreen> createState() => _LeadershipVisionScreenState();
}

class _LeadershipVisionScreenState extends State<LeadershipVisionScreen> {
  ///

  final TranslationService _translationService = TranslationService();

  String? _translatedAboutText;
  String? _translatedTitleText;
  String? _translatedBenefitText;

  Future<void> _translatePageTexts() async {
    final provider = Provider.of<HomeProvider>(context, listen: false);
    await provider.getLeadershipDetail(context: context);

    final details = provider.leadershipDetailModel;
    final dataList = details?.data;

    if (dataList == null ||
        dataList.isEmpty ||
        dataList.first.summary == null) {
      log('No leadership detail data found or summary is null');
      return;
    }

    final lang = Provider.of<LanguageProvider>(context, listen: false)
        .currentLanguageCode;

    final summary = dataList.first.summary!;

    final translations = await _translationService.translateMultipleTexts(
      textsToTranslate: {
        'about': summary,
      },
      toLanguageCode: lang,
    );

    setState(() {
      _translatedAboutText = translations['about'];
    });
  }

  @override
  void initState() {

    super.initState();
    getDetailData();
    getDetailData().then((_) => _translatePageTexts());
  }


  getDetailData() async {
    try {
      final provider = Provider.of<HomeProvider>(context, listen: false);
      provider.getLeadershipBanner(context: context);
      provider.getLeadershipStory(context: context);
      provider.getLeadershipMilestone(context: context);
      provider.getroadMap(context: context);
    } catch (e) {
      log('Exception in getLeadershipBanner: $e');
    }
  }


  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final langProvider = Provider.of<LanguageProvider>(context);

    log('cehckkkkkk$_translatedAboutText');
    final String shortText =
        "Samrat Choudhary alias Rakesh Kumar is an Indian politician and Member of Bihar Legislative  from the Bharatiya Janata Party. He has been the party president dsfds nfdsvf hvdsvfvds bdf hgsdhg hgdgs... ";
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommonAppBar(title: "Leadership & Vision",leadingBackButton: false,),
      //drawer: CustomDrawer(),
      drawer: CustomDrawer2(),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(14.0),
        child: Consumer<HomeProvider>(
          builder: (context, provider, child) {
            if (provider.leadershipBannerModel == null ||
                provider.leadershipBannerModel!.data == null) {
              return CustomShimmerContainer(
                  width: MediaQuery.of(context).size.width, height: 150);
            }
            return provider.storyLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      TranslatedText(
                        'Samrat Choudhary\'s Political Career',
                        // 'Samrat Choudhary\'s Political Career',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      provider.leadershipDetailModel?.data?.isEmpty ?? true
                          ? SizedBox()
                          : provider.leadershipDetailModel?.data?.first.image ==
                                  null
                              ? CustomShimmerContainer(
                                  height: 180,
                                  width: MediaQuery.of(context).size.width)
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                    // 'https://c.files.bbci.co.uk/1B89/production/_129094070_39e9c994-0494-4767-85db-faadaedd2a3b.jpg',
                                    ApiConfig.imageBaseUrl +
                                        provider.leadershipDetailModel!.data!
                                            .first.image![0]
                                            .toString(),
                                    // Replace with your actual asset path
                                    width: double.infinity,
                                    fit: BoxFit.fill,
                                    height: 170,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Image.asset(
                                        "assets/images/emptyImage.jpg",
                                        width: double.infinity,
                                        fit: BoxFit.fill,
                                        height: 170,
                                      );
                                    },
                                  ),
                                ),
                      SizedBox(
                        height: 10,
                      ),
                      provider.leadershipDetailModel == null ||
                              provider.leadershipDetailModel!.data == null ||
                              _translatedAboutText == null
                          ? CustomShimmerContainer(height: 200, width: width)
                          :
                          // TruncatedRichText(
                          //   fullText: _translatedAboutText!,
                          //   onMoreTap: () {
                          //     Navigator.push(
                          //       context,
                          //       MaterialPageRoute(
                          //         builder: (_) => SamratChoudharyCarrerScreen(
                          //           text: provider.leadershipDetailModel!.data!.first.summary.toString(),
                          //           image: ApiConfig.imageBaseUrl +
                          //               provider.leadershipDetailModel!.data!.first.image![0].toString(),
                          //         ),
                          //       ),
                          //     );
                          //   },
                          // )
                      // GestureDetector(
                      //   onTap: (){
                      //     Navigator.push(
                      //       context,
                      //       MaterialPageRoute(
                      //         builder: (_) =>
                      //             SamratChoudharyCarrerScreen(
                      //               text: provider
                      //                   .leadershipDetailModel!
                      //                   .data!
                      //                   .first
                      //                   .summary
                      //                   .toString(),
                      //               image: ApiConfig.imageBaseUrl +
                      //                   provider
                      //                       .leadershipDetailModel!
                      //                       .data!
                      //                       .first
                      //                       .image![0]
                      //                       .toString(),
                      //             ),
                      //       ),
                      //     );
                      //   },
                      //     child: TranslatedText(provider.leadershipDetailModel!.data!.first.summary!,maxLines: 5, style: TextStyle(
                      //       color: Colors.black.withOpacity(0.7),
                      //       fontSize: 14,
                      //     ),)),
                      LayoutBuilder(
                        builder: (context, constraints) {
                          final fullText = _translatedAboutText ?? '';
                          final shortText = fullText.length > 200 ? fullText.substring(0, 200) + '...' : fullText;

                          return RichText(
                            text: TextSpan(
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black.withOpacity(0.7),
                              ),
                              children: [
                                TextSpan(text: shortText),
                                if (fullText.length > 200)
                                  TextSpan(
                                    text: ' Read More',
                                    style: TextStyle(
                                      color: Colors.orange,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) => SamratChoudharyCarrerScreen(
                                              text: provider.leadershipDetailModel!.data!.first.summary.toString(),
                                              image: ApiConfig.imageBaseUrl +
                                                  provider.leadershipDetailModel!.data!.first.image![0].toString(),
                                            ),
                                          ),
                                        );
                                      },
                                  ),
                              ],
                            ),
                          );
                        },
                      ),

                          // Text.rich(
                          //     TextSpan(
                          //       children: [
                          //
                          //         TextSpan(
                          //           text: _translatedAboutText,
                          //           style: TextStyle(
                          //             color: Colors.black.withOpacity(0.7),
                          //             fontSize: 14,
                          //           ),
                          //           recognizer: TapGestureRecognizer()
                          //             ..onTap = () {
                          //               Navigator.push(
                          //                 context,
                          //                 MaterialPageRoute(
                          //                   builder: (_) =>
                          //                       SamratChoudharyCarrerScreen(
                          //                     text: provider
                          //                         .leadershipDetailModel!
                          //                         .data!
                          //                         .first
                          //                         .summary
                          //                         .toString(),
                          //                     image: ApiConfig.imageBaseUrl +
                          //                         provider
                          //                             .leadershipDetailModel!
                          //                             .data!
                          //                             .first
                          //                             .image![0]
                          //                             .toString(),
                          //                   ),
                          //                 ),
                          //               );
                          //             },
                          //         ),
                          //       ],
                          //     ),
                          //     maxLines: 5,
                          //     overflow: TextOverflow.ellipsis,
                          //     textAlign: TextAlign.justify,
                          //   )


                      SizedBox(
                        height: 10,
                      ),
                      TranslatedText(
                        'Milestones',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 80,
                        width: width,
                        child: ListView.builder(
                          itemCount:
                              provider.leadershipMileStoneModel!.data!.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            final data =
                                provider.leadershipMileStoneModel!.data![index];
                            final isEven = index % 2 == 0;

                            final milestones =
                                provider.leadershipMileStoneModel!.data!;
                            double itemWidth =
                                MediaQuery.of(context).size.width * 0.28;
                            double circleSize =
                                MediaQuery.of(context).size.width * 0.04;

                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MilestonesScreen(
                                      mileStoneModel:
                                          provider.leadershipMileStoneModel!,
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                width: itemWidth,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 6),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if (!isEven)
                                      TranslatedText(
                                        data.year.toString(),
                                        style:  TextStyle(
                                          color: Colors.green.shade700,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    if (isEven)
                                      TranslatedText(
                                        data.title.toString(),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    Row(
                                      children: [
                                        Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            Container(
                                              width: circleSize + 6,
                                              height: circleSize + 6,
                                              decoration: BoxDecoration(
                                                color: Colors.orange,
                                                shape: BoxShape.circle,
                                                border: Border.all(
                                                    color: Colors.orange,
                                                    width: 2),
                                              ),
                                              child: Center(
                                                child: Container(
                                                  width: circleSize,
                                                  height: circleSize,
                                                  decoration: BoxDecoration(
                                                    color: Colors.orange,
                                                    shape: BoxShape.circle,
                                                    border: Border.all(
                                                        color: Colors.white,
                                                        width:
                                                            circleSize * 0.3),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(width: 4),
                                        Expanded(
                                          child: Container(
                                            height: 2,
                                            color: Colors.orange,
                                          ),
                                        ),
                                      ],
                                    ),
                                    if (isEven)
                                      TranslatedText(
                                        data.year.toString(),
                                        style:  TextStyle(
                                          color: Colors.green.shade700,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    if (!isEven)
                                      TranslatedText(
                                        data.title.toString(),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),

                      // SizedBox(
                      //   height: 10,
                      // ),
                      TranslatedText(
                        'Bihar Roadmap',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      (provider.roadMapModel == null ||
                              provider.roadMapModel!.data == null)
                          ? CustomShimmerContainer(height: 180, width: width)
                          : provider.roadMapModel!.data!.isEmpty?SizedBox():Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              ApiConfig.imageBaseUrl +
                                  provider.roadMapModel!.data!.first
                                      .thumbImage
                                      .toString(),
                              width: double.infinity,
                              height: 180,
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                          Text(provider
                              .roadMapModel!.data!.first.description!)
                        ],
                      ),
                    ],
                  );
          },
        ),
      ),
    );
  }
}

///

class MilestoneTimeline extends StatelessWidget {
  final List<Milestone> milestones;

  const MilestoneTimeline({super.key, required this.milestones});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
      child: Row(
        children: List.generate(milestones.length, (index) {
          final isEven = index % 2 == 0;
          final milestone = milestones[index];
          final isLast = index == milestones.length - 1;

          return Column(
            mainAxisSize: MainAxisSize.min,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (!isEven) ...[
                Text(
                  milestone.year,
                  style: const TextStyle(fontSize: 14),
                ),
                const SizedBox(height: 6),
              ],
              Row(
                children: [
                  // Indicator
                  Column(
                    children: [
                      Container(
                        width: 16,
                        height: 16,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.black, width: 1.5),
                        ),
                      ),
                      const SizedBox(height: 6),
                      if (isEven)
                        TranslatedText(
                          milestone.year,
                          style: const TextStyle(fontSize: 14),
                        ),
                      const SizedBox(height: 6),
                      TranslatedText(
                        milestone.label,
                        style: const TextStyle(
                            fontSize: 13, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),

                  // Line connecting indicators
                  if (!isLast)
                    Container(
                      width: 40,
                      height: 2,
                      color: Colors.grey,
                      margin: const EdgeInsets.only(left: 8, right: 8),
                    ),
                ],
              ),
              if (!isEven) const SizedBox(height: 6),
            ],
          );
        }),
      ),
    );
  }
}

class Milestone {
  final String label;
  final String year;

  Milestone({required this.label, required this.year});
}

class TruncatedRichText extends StatelessWidget {
  final String fullText;
  final VoidCallback onMoreTap;

  const TruncatedRichText({
    Key? key,
    required this.fullText,
    required this.onMoreTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
      fontSize: 14,
      color: Colors.black.withOpacity(0.7),
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        final span = TextSpan(text: fullText, style: textStyle);
        final tp = TextPainter(
          text: span,
          maxLines: 5,
          textDirection: TextDirection.ltr,
        )..layout(maxWidth: constraints.maxWidth);

        if (tp.didExceedMaxLines) {
          String truncated =
              _truncateToFit(fullText, textStyle, constraints.maxWidth);
          return Text.rich(
            TextSpan(
              children: [
                TextSpan(text: truncated, style: textStyle),
                TextSpan(
                  text: ' more',
                  style: TextStyle(
                    color: Colors.orange,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                  recognizer: TapGestureRecognizer()..onTap = onMoreTap,
                ),
              ],
            ),
            textAlign: TextAlign.justify,
          );
        } else {
          return Text(
            fullText,
            style: textStyle,
            textAlign: TextAlign.justify,
          );
        }
      },
    );
  }

  String _truncateToFit(String text, TextStyle style, double maxWidth) {
    const int maxLines = 5;
    final tp = TextPainter(
      textDirection: TextDirection.ltr,
      maxLines: maxLines,
    );

    for (int i = text.length; i > 0; i--) {
      final sub = text.substring(0, i) + '...';
      tp.text = TextSpan(text: sub, style: style);
      tp.layout(maxWidth: maxWidth);
      if (!tp.didExceedMaxLines) {
        return sub;
      }
    }
    return text;
  }
}
