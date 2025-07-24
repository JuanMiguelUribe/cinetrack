import 'package:flutter/material.dart';

class LocaleProvider {
  static String get currentLanguage {
    return WidgetsBinding.instance.platformDispatcher.locale.languageCode;
  }

  static String get movieDbLanguageCode {
    final lang = currentLanguage;
    if (lang == 'es') return 'es-ES';
    if (lang == 'en') return 'en-US';
    return 'es-ES'; // default
  }
}
