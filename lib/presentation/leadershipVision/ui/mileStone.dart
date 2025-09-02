import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:samrat_chaudhary/core/widgets/components/translatorWidget.dart';
import 'package:samrat_chaudhary/presentation/leadershipVision/model/leader_milestone_model.dart';

import '../../../core/widgets/components/custom_appbar.dart';
import '../provider/language_provider.dart';
import '../../../data/services/translation_service.dart';

class MilestonesScreen extends StatefulWidget {
  final LeadershipMileStoneModel mileStoneModel;

  const MilestonesScreen({super.key, required this.mileStoneModel});

  @override
  State<MilestonesScreen> createState() => _MilestonesScreenState();
}

class _MilestonesScreenState extends State<MilestonesScreen> {
  final TranslationService _translationService = TranslationService();

  String? _translatedAboutText;
  String? _translatedTitleText;
  String? _translatedBenefitText;

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   _translatePageTexts(); // initial load
  // }

  Future<void> _translatePageTexts() async {
    final lang = Provider.of<LanguageProvider>(context, listen: false)
        .currentLanguageCode;

    log('sadadad$lang');
    final translations = await _translationService.translateMultipleTexts(
      textsToTranslate: {
        // 'about': widget.mileStoneModel.,
        'title': 'Samrat Choudhary\'s Political Career',
      },
      toLanguageCode: lang,
    );

    setState(() {
      _translatedAboutText = translations['about'];
      _translatedTitleText = translations['title'];
    });
  }

  @override
  void initState() {
    // _translatedAboutText = widget.text;
    _translatedTitleText = 'Milestones';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommonAppBar(
        title: 'Milestones',
        onTap: () async {
          // langProvider.toggleLanguage();
          await _translatePageTexts(); // refresh content
        },
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 16.0, top: 16),
        child: Column(
          children: <Widget>[
            ListView.builder(
              shrinkWrap: true,
              itemCount: widget.mileStoneModel.data!.length,
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.mileStoneModel.data![index].year.toString(),
                          style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.w500,
                              fontSize: 12),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        IntrinsicHeight(

                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Left side: Year + timeline indicator
                              Column(
                                children: [
                                  // Dot
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.orange,
                                      shape: BoxShape.circle,
                                      border: Border.all(width: 2, color: Colors.orange),
                                    ),
                                    child: Container(
                                      width: 20,
                                      height: 20,
                                      decoration: BoxDecoration(
                                        color: Colors.orange,
                                        shape: BoxShape.circle,
                                        border: Border.all(width: 5, color: Colors.white),
                                      ),
                                    ),
                                  ),
                                  // Line (height will match row content automatically)
                                  Expanded(
                                    child: Container(
                                      width: 3,
                                      color: Colors.orange,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(width: 10),
                              // Right side: milestone content
                              _MilestoneItem(
                                title: widget.mileStoneModel.data![index].title.toString(),
                                description: widget.mileStoneModel.data![index].summary.toString(),
                              ),
                            ],
                          ),
                        )

                      ],
                    ),

                  ],
                );
              },
            )
          ],
        ),
      ),
    );
  }
}

class _MilestoneItem extends StatelessWidget {
  const _MilestoneItem({
    required this.title,
    required this.description,
  });

  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.75,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          //const SizedBox(height: 6.0),
          TranslatedText(
            title,
            style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16.0),
          ),
          const SizedBox(height: 6.0), // Slightly reduced spacing
          if (description.trim().isNotEmpty) // Only show if there is content
            TranslatedText(
              description,
              textAlign: TextAlign.justify,
              style: const TextStyle(fontSize: 14.0, color: Colors.black87),
            ),
          const SizedBox(height: 10.0),
        ],
      ),
    );
  }
}

