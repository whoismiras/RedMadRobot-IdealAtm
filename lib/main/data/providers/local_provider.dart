import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ideal_atm/core/l10n/l10n.dart';

import 'package:ideal_atm/main/data/shared_oreferences/app_shared_preferences.dart';

class LocaleProvider with ChangeNotifier {
  LocaleProvider(String? locale)
      : _locale = Locale.fromSubtags(
            languageCode: locale ?? Platform.localeName.substring(0, 2));
  Locale? _locale;

  Locale? get locale => _locale;

  Future<void> setLocale(Locale locale) async {
    if (L10n.support.contains(locale)) {
      _locale = locale;
      await AppSharedPreferences.saveLocale(locale.languageCode);
      notifyListeners();
    }
  }
}
