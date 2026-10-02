import 'package:flutter/material.dart';

class LocalizedString {
  const LocalizedString({required this.en, required this.am, required this.om});
  final String en;
  final String am;
  final String om;

  String resolve(Locale locale) {
    switch (locale.languageCode) {
      case 'am':
        return am;
      case 'om':
        return om;
      case 'en':
      default:
        return en;
    }
  }

  String resolveCode(String languageCode) {
    switch (languageCode) {
      case 'am':
        return am;
      case 'om':
        return om;
      case 'en':
      default:
        return en;
    }
  }
}

extension LocalizedStringListX on List<LocalizedString> {
  List<String> resolveAll(Locale locale) =>
      map((s) => s.resolve(locale)).toList();
}

extension LocalizedStringContextX on BuildContext {
  String l10nStr(LocalizedString s) =>
      s.resolve(Localizations.localeOf(this));
}
