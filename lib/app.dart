import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'data/app_store.dart';
import 'data/order_store.dart';
import 'data/user_preferences.dart';
import 'l10n/app_localizations.dart';
import 'l10n/locale_controller.dart';
import 'navigation/app_router.dart';
import 'theme/app_theme.dart';

class PrimeGymApp extends StatelessWidget {
  PrimeGymApp({super.key});

  final _router = createRouter();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    return ListenableBuilder(
      listenable: Listenable.merge([
        LocaleController.instance,
        AppStore.instance,
        UserPreferences.instance,
        OrderStore.instance,
      ]),
      builder: (context, _) {
        final locale = LocaleController.instance.locale;
        return MaterialApp.router(
          title: 'PrimeGym',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.dark(locale: locale),
          locale: locale,
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          routerConfig: _router,
        );
      },
    );
  }
}
