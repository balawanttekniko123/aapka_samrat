import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:provider/provider.dart';
import 'package:samrat_chaudhary/core/widgets/components/translatorWidget.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/widgets/components/custom_appbar.dart';
import '../../../core/widgets/components/translateMarkDown.dart';
import '../provider/home_provider.dart';
import '../provider/language_provider.dart';
import '../../../data/services/translation_service.dart';

//my name bala
class SamratChoudharyCarrerScreen extends StatefulWidget {
  final String text;
  final String image;
  const SamratChoudharyCarrerScreen({super.key, required this.text, required this.image});

  @override
  State<SamratChoudharyCarrerScreen> createState() => _SamratChoudharyCarrerScreenState();
}

class _SamratChoudharyCarrerScreenState extends State<SamratChoudharyCarrerScreen> {






  @override
  Widget build(BuildContext context) {
    final langProvider = Provider.of<LanguageProvider>(context);
    return  Scaffold(backgroundColor: Colors.white,

      appBar: CommonAppBar(title: 'Samrat Choudhary\'s Political Career',),

      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            GestureDetector(
              onTap: (){
                // Navigator.push(context, MaterialPageRoute(builder: (context) => MilestonesScreen(),));
                // Handle 'more' tap

              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    widget.image,
                    fit: BoxFit.fill,
                    height: 180,
                    width: double.infinity,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset(
                        "assets/images/emptyImage.jpg",
                        width: double.infinity,
                        fit: BoxFit.fill,
                        height: 180,
                      );
                    },
                  ),
                ),
              ),
            ),
            SizedBox(height: 10,),
            _buildContentSection(context),
            // GestureDetector(
            //   onTap: (){
            //     // Navigator.push(context, MaterialPageRoute(builder: (context) => PublicEngagementCommunicationScreen(),));
            //     // Handle 'more' tap
            //   },
            //
            //   //
            //   child: TranslatedText(
            //     widget.text,
            //    style: TextStyle(fontSize: 14.0),
            //     textAlign: TextAlign.justify,
            //   ),
            // ),
          ],
        ),
      ),

    );
  }
  Widget _buildContentSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        const SizedBox(height: 10),
        TranslatedMarkdown(
          originalText: widget.text,
        ),
        // MarkdownBody(
        //   data: widget.text,
        //   styleSheet: MarkdownStyleSheet(
        //     p: TextStyle(fontSize: 14, color: Colors.black.withOpacity(0.7)),
        //     h1: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        //     h2: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        //     h3: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        //     strong: const TextStyle(fontWeight: FontWeight.bold),
        //     blockquote: TextStyle(
        //       color: Colors.grey.shade600,
        //       fontStyle: FontStyle.italic,
        //     ),
        //     a: const TextStyle(
        //       color: Colors.blue,
        //       decoration: TextDecoration.underline,
        //     ),
        //   ),
        //   onTapLink: (text, href, title) {
        //     if (href != null) {
        //       launchUrl(Uri.parse(href));
        //     }
        //   },
        // ),
        // TranslatedText(
        //   summary,
        //   textAlign: TextAlign.justify,
        //   style: TextStyle(fontSize: 14,color: Colors.black.withOpacity(0.6)),
        // ),
      ],
    );
  }
}