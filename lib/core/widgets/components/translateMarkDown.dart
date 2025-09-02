import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:provider/provider.dart';
import 'package:samrat_chaudhary/core/widgets/components/shimmerEffect.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../presentation/leadershipVision/provider/language_provider.dart';
import '../../../data/services/translation_service.dart';
class TranslatedMarkdown extends StatefulWidget {
  final String originalText;

  const TranslatedMarkdown({super.key, required this.originalText});

  @override
  State<TranslatedMarkdown> createState() => _TranslatedMarkdownState();
}

class _TranslatedMarkdownState extends State<TranslatedMarkdown> {
  String? translatedText;
  String? currentLang;
  final TranslationService _translationService = TranslationService();

  @override
  void initState() {
    super.initState();
    currentLang = Provider.of<LanguageProvider>(context, listen: false).currentLanguageCode;
    _translate(widget.originalText, currentLang!);
  }

  Future<void> _translate(String text, String lang) async {
    final result = await _translationService.translateText(
      text: text,
      toLanguageCode: lang,
    );
    if (mounted) {
      setState(() {
        translatedText = result;
        currentLang = lang;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<LanguageProvider>(context).currentLanguageCode;

    // Re-translate on language change
    if (lang != currentLang) {
      _translate(widget.originalText, lang);
    }

    return translatedText == null
        ?  CustomShimmerContainer(height: 200, width: double.infinity)
        : MarkdownBody(
      data: translatedText!,



        styleSheet: MarkdownStyleSheet(
          p: TextStyle(

            fontSize: 14,
            color: Colors.black.withOpacity(0.7),
            fontFamily: 'Roboto',
          ),
          h1: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: 'Roboto',
          ),
          h2: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            fontFamily: 'Roboto',
          ),
          h3: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            fontFamily: 'Roboto',
          ),
          strong: const TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: 'Roboto',
          ),
          blockquote: TextStyle(
            color: Colors.grey.shade600,
            fontStyle: FontStyle.italic,
            fontFamily: 'Roboto',

          ),


        a: const TextStyle(
          color: Colors.blue,
          decoration: TextDecoration.underline,
        ),
      ),
      onTapLink: (text, href, title) {
        if (href != null) {
          launchUrl(Uri.parse(href));
        }
      },
    );
  }
}
