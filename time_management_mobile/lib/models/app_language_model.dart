import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Модель, отвечающая за возможность смены языка
class AppLanguageModel extends ChangeNotifier {
  static const _defaultLocale = 'en';
  Locale _appLocale = Locale(_defaultLocale);

  Locale get appLocal => _appLocale ?? Locale(_defaultLocale);

  /// Подгрузка выбранного языка из SharedPreferences
  Future fetchLocale() async {
    var prefs = await SharedPreferences.getInstance();
    if (prefs.getString('language_code') == null) {
      _appLocale = Locale(_defaultLocale);
      return;
    }
    _appLocale = Locale(prefs.getString('language_code'));
  }

  /// Смена языка
  void changeLanguage(Locale type) async {
    var prefs = await SharedPreferences.getInstance();
    if (_appLocale == type) {
      return;
    }
    if (type == Locale("ru")) {
      _appLocale = Locale("ru");
      await prefs.setString('language_code', 'ru');
      await prefs.setString('countryCode', 'RU');
    } else {
      _appLocale = Locale("en");
      await prefs.setString('language_code', 'en');
      await prefs.setString('countryCode', 'US');
    }
    notifyListeners();
  }
}
