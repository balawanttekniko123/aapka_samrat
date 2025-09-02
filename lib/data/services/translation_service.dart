import 'package:translator/translator.dart';

class TranslationService {
  final GoogleTranslator _translator = GoogleTranslator();

  /// Translate a single text
  Future<String> translateText({
    required String text,
    required String toLanguageCode,
    String fromLanguageCode = 'en',
  }) async {
    final translation = await _translator.translate(text, from: fromLanguageCode, to: toLanguageCode);
    return translation.text;
  }

  /// Translate multiple texts at once
  Future<Map<String, String>> translateMultipleTexts({
    required Map<String, String> textsToTranslate,
    required String toLanguageCode,
    String fromLanguageCode = 'en',
  }) async {
    Map<String, String> result = {};

    for (final entry in textsToTranslate.entries) {
      final translated = await translateText(
        text: entry.value,
        toLanguageCode: toLanguageCode,
        fromLanguageCode: fromLanguageCode,
      );
      result[entry.key] = translated;
    }

    return result;
  }
}


class TranslationService2 {
  final GoogleTranslator _translator = GoogleTranslator();

  /// Translate a single text
  Future<String> translateText2({
    required String text,
    required String toLanguageCode,
    String fromLanguageCode = 'hi',
  }) async {
    final translation = await _translator.translate(text, from: fromLanguageCode, to: toLanguageCode);
    return translation.text;
  }

  /// Translate multiple texts at once
  Future<Map<String, String>> translateMultipleTexts({
    required Map<String, String> textsToTranslate,
    required String toLanguageCode,
    String fromLanguageCode = 'hi',
  }) async {
    Map<String, String> result = {};

    for (final entry in textsToTranslate.entries) {
      final translated = await translateText2(
        text: entry.value,
        toLanguageCode: toLanguageCode,
        fromLanguageCode: fromLanguageCode,
      );
      result[entry.key] = translated;
    }

    return result;
  }
}
