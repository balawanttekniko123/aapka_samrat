


import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';
import 'package:samrat_chaudhary/core/widgets/components/shimmerEffect.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:html/parser.dart' as html_parser;
import 'package:html/dom.dart' as dom;
import '../../../presentation/leadershipVision/provider/language_provider.dart';
import '../../../data/services/translation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:html/parser.dart' as html_parser;
import 'package:html/dom.dart' as dom;
import '../../../presentation/leadershipVision/provider/language_provider.dart';
import '../../../data/services/translation_service.dart';

/// 🔹 Simple in-memory cache [Map: "lang+text" -> "translatedText"]
class TranslationCache {
  static final Map<String, String> _cache = {};

  static String? get(String key) => _cache[key];
  static void set(String key, String value) => _cache[key] = value;
}

class TranslatedHtml extends StatefulWidget {
  final String originalText;

  const TranslatedHtml({super.key, required this.originalText});

  @override
  State<TranslatedHtml> createState() => _TranslatedHtmlState();
}

class _TranslatedHtmlState extends State<TranslatedHtml> {
  String? translatedHtml;
  String? currentLang;
  final TranslationService _translationService = TranslationService();

  @override
  void initState() {
    super.initState();
    currentLang = Provider.of<LanguageProvider>(context, listen: false).currentLanguageCode;
    _translateHtml(widget.originalText, currentLang!);
  }

  Future<void> _translateHtml(String htmlText, String lang) async {
    final cacheKey = "$lang-${htmlText.hashCode}";
    final cached = TranslationCache.get(cacheKey);

    if (cached != null) {
      // ✅ Use cached version
      setState(() {
        translatedHtml = cached;
      });
      return;
    }

    final document = html_parser.parse(htmlText);

    // Collect all text nodes
    final buffer = <dom.Node>[];
    void collectNodes(dom.Node node) {
      for (var child in node.nodes) {
        if (child.nodeType == dom.Node.TEXT_NODE && child.text!.trim().isNotEmpty) {
          buffer.add(child);
        } else {
          collectNodes(child);
        }
      }
    }

    collectNodes(document.body!);

    if (buffer.isEmpty) {
      setState(() {
        translatedHtml = htmlText;
      });
      return;
    }

    // Join all text nodes with separator
    final combinedText = buffer.map((e) => e.text!).join(" ||| ");

    try {
      // 🔹 Translate in one API call
      final translatedCombined = await _translationService.translateText(
        text: combinedText,
        toLanguageCode: lang,
      );

      // Split translated text back
      final translatedParts = translatedCombined.split(" ||| ");
      for (int i = 0; i < buffer.length; i++) {
        buffer[i].text = translatedParts[i];
      }

      final finalHtml = document.body!.innerHtml;

      // ✅ Save to cache
      TranslationCache.set(cacheKey, finalHtml);

      if (mounted) {
        setState(() {
          translatedHtml = finalHtml;
        });
      }
    } catch (e) {
      debugPrint("Translation error: $e");
      setState(() {
        translatedHtml = htmlText; // fallback original text
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<LanguageProvider>(context).currentLanguageCode;

    // Language change → re-translate
    if (lang != currentLang) {
      _translateHtml(widget.originalText, lang);
      currentLang = lang;
    }

    return translatedHtml == null
        ? SizedBox(
      height: MediaQuery.of(context).size.height * 0.65,
      width: double.infinity,
      child: const Center(child: DetailPageShimmer()),
    )
        : Html(
      data: translatedHtml!,
      onLinkTap: (url, attributes, element) async {
        if (url != null) {
          await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
        }
      },
    );
  }
}



class TranslatedHtml2 extends StatefulWidget {
  final String originalText;
  final String? cacheKey; // optional unique cache key

  const TranslatedHtml2({
    super.key,
    required this.originalText,
    this.cacheKey,
  });

  @override
  State<TranslatedHtml2> createState() => _TranslatedHtml2State();
}

class _TranslatedHtml2State extends State<TranslatedHtml2> {
  String? translatedHtml;
  String? currentLang;
  final TranslationService _translationService = TranslationService();

  @override
  void initState() {
    super.initState();
    currentLang =
        Provider.of<LanguageProvider>(context, listen: false).currentLanguageCode;
    _loadOrTranslate(widget.originalText, currentLang!);
  }

  /// Cache check -> translate -> save
  Future<void> _loadOrTranslate(String htmlText, String lang) async {
    final prefs = await SharedPreferences.getInstance();
    final cacheKey = "${widget.cacheKey ?? htmlText.hashCode}_$lang";

    // 🔹 Check cache first
    if (prefs.containsKey(cacheKey)) {
      setState(() {
        translatedHtml = prefs.getString(cacheKey);
      });
      return;
    }

    final document = html_parser.parse(htmlText);

    // Collect all text nodes
    final nodes = <dom.Node>[];
    void collect(dom.Node node) {
      for (var child in node.nodes) {
        if (child.nodeType == dom.Node.TEXT_NODE &&
            child.text!.trim().isNotEmpty) {
          nodes.add(child);
        } else {
          collect(child);
        }
      }
    }

    collect(document.body!);

    if (nodes.isEmpty) {
      setState(() {
        translatedHtml = htmlText; // nothing to translate
      });
      return;
    }

    // 🔹 Join all text into one string (single API call)
    final combined = nodes.map((e) => e.text!).join(" ||| ");

    final translatedCombined = await _translationService.translateText(
      text: combined,
      toLanguageCode: lang,
    );

    // 🔹 Split back
    final parts = translatedCombined.split(" ||| ");
    for (int i = 0; i < nodes.length && i < parts.length; i++) {
      nodes[i].text = parts[i];
    }

    final result = document.body!.innerHtml;

    if (mounted) {
      setState(() {
        translatedHtml = result;
      });
    }

    // Save to cache
    await prefs.setString(cacheKey, result);
  }

  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<LanguageProvider>(context).currentLanguageCode;

    // language change detected
    if (lang != currentLang) {
      _loadOrTranslate(widget.originalText, lang);
      currentLang = lang;
    }

    return translatedHtml == null
        ? Container(
      height: MediaQuery.of(context).size.height * 0.5,
      //height: MediaQuery.of(context).size.height ,
      width: double.infinity,
      alignment: Alignment.center,
      child: DetailPageShimmer(),
    )
        : Html(
      data: translatedHtml!,
      onLinkTap: (url, attributes, element) async {
        if (url != null) {
          await launchUrl(Uri.parse(url));
        }
      },
    );
  }
}

//
// import 'package:flutter/material.dart';
// import 'package:flutter_html/flutter_html.dart';
// import 'package:flutter_html_table/flutter_html_table.dart';
// import 'package:provider/provider.dart';
// import 'package:samrat_chaudhary/core/widgets/components/shimmerEffect.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:html/parser.dart' as html_parser;
// import 'package:html/dom.dart' as dom;
// import '../../../presentation/leadershipVision/provider/language_provider.dart';
// import '../../../data/services/translation_service.dart';
//
// class TranslatedHtml extends StatefulWidget {
//   final String originalText;
//
//   const TranslatedHtml({super.key, required this.originalText});
//
//   @override
//   State<TranslatedHtml> createState() => _TranslatedHtmlState();
// }
//
// class _TranslatedHtmlState extends State<TranslatedHtml> {
//   String? translatedHtml;
//   String? currentLang;
//   final TranslationService _translationService = TranslationService();
//
//   @override
//   void initState() {
//     super.initState();
//     currentLang = Provider.of<LanguageProvider>(context, listen: false).currentLanguageCode;
//     _translatePreservingHtml(widget.originalText, currentLang!);
//   }
//
//   Future<void> _translatePreservingHtml(String htmlText, String lang) async {
//     final document = html_parser.parse(htmlText);
//
//     Future<void> translateNodes(dom.Node node) async {
//       for (var child in node.nodes) {
//         if (child.nodeType == dom.Node.TEXT_NODE && child.text!.trim().isNotEmpty) {
//           final translated = await _translationService.translateText(
//             text: child.text!,
//             toLanguageCode: lang,
//           );
//           child.text = translated;
//         } else {
//           await translateNodes(child);
//         }
//       }
//     }
//
//     await translateNodes(document.body!);
//     if (mounted) {
//       setState(() {
//         translatedHtml = document.body!.innerHtml;
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final lang = Provider.of<LanguageProvider>(context).currentLanguageCode;
//
//     if (lang != currentLang) {
//       _translatePreservingHtml(widget.originalText, lang);
//       currentLang = lang;
//     }
//
//     return translatedHtml == null
//         ? Container(
//       height: MediaQuery.of(context).size.height,
//       width: double.infinity,
//       child: const Center(child: CircularProgressIndicator()),
//     )
//         : SingleChildScrollView(
//       padding: const EdgeInsets.all(16),
//       child: Html(
//         data: translatedHtml!,
//         onLinkTap: (url, attributes, element) async {
//           if (url != null) {
//             await launchUrl(Uri.parse(url));
//           }
//         },
//         extensions: [
//           const TableHtmlExtension(), // 🟢 Enables <table> rendering
//         ],
//         customRender: {
//           "figure": (context, child) {
//             return child; // ✅ Render inner content of <figure>
//           },
//         },
//       ),
//     );
//   }
// }
