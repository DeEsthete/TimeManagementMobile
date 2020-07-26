import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Класс предназначенный для перевода текста
class Translator {
  final Locale locale;

  Translator(this.locale);

  static Translator of(BuildContext context) {
    return Localizations.of<Translator>(context, Translator);
  }

  static const LocalizationsDelegate<Translator> delegate =
      _TranslatorDelegate();

  Map<String, String> _localizedStrings;

  /// Подгразка необходимой локализации
  Future load() async {
    // Английский язык используем как исходник
    if (locale.languageCode == "en") {
      _localizedStrings = new Map();
      return;
    }

    String jsonString = await rootBundle
        .loadString('assets/localization/${locale.languageCode}.json');
    Map<String, dynamic> jsonMap = json.decode(jsonString);

    _localizedStrings = jsonMap.map((key, value) {
      return MapEntry(key.toLowerCase(), value.toString());
    });
  }

  String translate(String word) {
    var key = word.toLowerCase();
    if (_localizedStrings.containsKey(key)) {
      return _localizedStrings[key];
    }
    return word;
  }
}

/// Класс предназначенный для интегрирования Translator'а в MaterialApp
class _TranslatorDelegate extends LocalizationsDelegate<Translator> {
  const _TranslatorDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'ru'].contains(locale.languageCode);
  }

  @override
  Future<Translator> load(Locale locale) async {
    Translator localizations = new Translator(locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(_TranslatorDelegate old) => false;
}
