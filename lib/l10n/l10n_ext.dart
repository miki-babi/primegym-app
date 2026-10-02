import 'package:flutter/widgets.dart';
import 'package:primegym/l10n/app_localizations.dart';

export 'package:primegym/l10n/app_localizations.dart';

extension AppLocalizationsX on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this)!;
}
