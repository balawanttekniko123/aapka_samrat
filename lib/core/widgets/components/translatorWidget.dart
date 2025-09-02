import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../presentation/leadershipVision/provider/language_provider.dart';
import '../../../data/services/translation_service.dart';

class TranslatedText extends StatefulWidget {
  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;

  const TranslatedText(
      this.text, {
        super.key,
        this.style,
        this.textAlign,
        this.maxLines,
        this.overflow,
      });

  @override
  State<TranslatedText> createState() => _TranslatedTextState();
}

class _TranslatedTextState extends State<TranslatedText> {
  String? translatedText;
  String? currentLang;
  final TranslationService _translationService = TranslationService();

  @override
  void initState() {
    super.initState();
    currentLang = Provider.of<LanguageProvider>(context, listen: false).currentLanguageCode;
    _translateText(currentLang!);
  }

  Future<void> _translateText(String lang) async {
    final translation = await _translationService.translateText(
      text: widget.text,
      toLanguageCode: lang,
    );
    if (mounted) {
      setState(() {
        translatedText = translation;
        currentLang = lang;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<LanguageProvider>(context).currentLanguageCode;

    // If language changed, re-translate
    if (lang != currentLang) {
      _translateText(lang);
    }

    return Text(
      translatedText ?? widget.text,
      style: widget.style,
      textAlign: widget.textAlign,
      maxLines: widget.maxLines,
      overflow: widget.overflow,
    );
  }
}
class TranslatedText2 extends StatefulWidget {
  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;

  const TranslatedText2(
      this.text, {
        super.key,
        this.style,
        this.textAlign,
        this.maxLines,
        this.overflow,
      });

  @override
  State<TranslatedText2> createState() => _TranslatedText2State();
}

class _TranslatedText2State extends State<TranslatedText2> {
  String? translatedText;
  String? currentLang;
  final TranslationService2 _translationService = TranslationService2();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final lang = Provider.of<LanguageProvider2>(context).currentLanguageCode;
    if (lang != currentLang) {
      currentLang = lang;
      _translateText(lang);
    }
  }

  Future<void> _translateText(String lang) async {
    final translation = await _translationService.translateText2(
      text: widget.text,
      toLanguageCode: lang,
    );
    if (mounted) {
      setState(() {
        translatedText = translation;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      translatedText ?? widget.text,
      style: widget.style,
      textAlign: widget.textAlign,
      maxLines: widget.maxLines,
      overflow: widget.overflow,
    );
  }
}
