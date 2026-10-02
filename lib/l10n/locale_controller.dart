import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleController extends ChangeNotifier {
  LocaleController._();
  static final LocaleController instance = LocaleController._();

  static const _prefsKey = 'primegym_locale';

  Locale _locale = const Locale('en');

  Locale get locale => _locale;
  String get languageCode => _locale.languageCode;

  static Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    final code = prefs.getString(_prefsKey);
    if (code == null || code.isEmpty) return;
    instance._locale = Locale(code);
  }

  Future<void> setLocale(Locale newLocale) async {
    if (_locale == newLocale) return;
    _locale = newLocale;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_prefsKey, newLocale.languageCode);
  }

  void setByLanguageName(String name) {
    final normalized = name.trim().toLowerCase();
    if (normalized == 'am' ||
        normalized == 'amharic' ||
        normalized == 'አማርኛ' ||
        normalized.contains('amharic') ||
        normalized.contains('አማርኛ')) {
      setLocale(const Locale('am'));
      return;
    }
    if (normalized == 'om' ||
        normalized == 'oromo' ||
        normalized == 'afaan oromoo' ||
        normalized.contains('oromo') ||
        normalized.contains('afaan')) {
      setLocale(const Locale('om'));
      return;
    }
    setLocale(const Locale('en'));
  }

  String get currentLanguageDisplayName {
    switch (_locale.languageCode) {
      case 'am':
        return 'አማርኛ (Amharic)';
      case 'om':
        return 'Afaan Oromoo';
      case 'en':
      default:
        return 'English';
    }
  }
}
