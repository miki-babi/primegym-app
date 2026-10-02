import 'package:flutter/material.dart';

import 'app.dart';
import 'data/app_store.dart';
import 'data/order_store.dart';
import 'data/user_preferences.dart';
import 'l10n/locale_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocaleController.load();
  await UserPreferences.load();
  await OrderStore.load();
  await AppStore.load();
  runApp(PrimeGymApp());
}
