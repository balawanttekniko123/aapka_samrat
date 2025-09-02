import 'package:flutter/material.dart';

class LanguageProvider extends ChangeNotifier {
  String _currentLanguageCode = 'en';

  String get currentLanguageCode => _currentLanguageCode;

  void toggleLanguage() {
    _currentLanguageCode = _currentLanguageCode == 'en' ? 'hi' : 'en';
    notifyListeners();
  }

  void setLanguage(String code) {
    _currentLanguageCode = code;
    notifyListeners();
  }
}

class LanguageProvider2 extends ChangeNotifier {
  String _currentLanguageCode = 'hi';

  String get currentLanguageCode => _currentLanguageCode;

  void toggleLanguage() {
    _currentLanguageCode = _currentLanguageCode == 'hi' ? 'en' : 'hi';
    notifyListeners();
  }

  void setLanguage(String code) {
    _currentLanguageCode = code;
    notifyListeners();
  }
}
