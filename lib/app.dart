import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'data/active_workout_controller.dart';
import 'data/app_store.dart';
import 'data/exercise_repository.dart';
import 'data/order_store.dart';
import 'data/user_preferences.dart';
import 'l10n/app_localizations.dart';
import 'l10n/locale_controller.dart';
import 'navigation/app_router.dart';
import 'theme/app_theme.dart';
import 'widgets/active_workout_resume_fab.dart';

class PrimeGymApp extends StatelessWidget {
  PrimeGymApp({super.key});

  final _router = createRouter();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);

    return ListenableBuilder(
      listenable: Listenable.merge([
        LocaleController.instance,
        AppStore.instance,
        UserPreferences.instance,
        OrderStore.instance,
        ExerciseRepository.instance,
        ActiveWorkoutController.instance,
      ]),
      builder: (context, _) {
        final locale = LocaleController.instance.locale;
        return MaterialApp.router(
          title: 'PrimeGym',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.light(locale: locale),
          locale: locale,
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          routerConfig: _router,
          builder: (context, child) {
            return Stack(
              fit: StackFit.expand,
              children: [
                child ?? const SizedBox.shrink(),
                ActiveWorkoutResumeFab(router: _router),
              ],
            );
          },
        );
      },
    );
  }
}
