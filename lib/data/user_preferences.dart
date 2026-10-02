import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum TrainingEnvironment {
  noEquipment,
  home,
  gym;

  static TrainingEnvironment? tryParse(String? raw) {
    if (raw == null || raw.isEmpty) return null;
    for (final value in TrainingEnvironment.values) {
      if (value.name == raw) return value;
    }
    return null;
  }
}

class UserPreferences extends ChangeNotifier {
  UserPreferences._();
  static final UserPreferences instance = UserPreferences._();

  static const _prefsKey = 'primegym_training_environments';
  static const _legacyPrefsKey = 'primegym_training_environment';

  Set<TrainingEnvironment> _environments = {TrainingEnvironment.gym};

  Set<TrainingEnvironment> get environments => Set.unmodifiable(_environments);

  /// Primary environment for ranking "today" workouts.
  TrainingEnvironment get primaryEnvironment {
    if (_environments.contains(TrainingEnvironment.gym)) {
      return TrainingEnvironment.gym;
    }
    if (_environments.contains(TrainingEnvironment.home)) {
      return TrainingEnvironment.home;
    }
    if (_environments.contains(TrainingEnvironment.noEquipment)) {
      return TrainingEnvironment.noEquipment;
    }
    return TrainingEnvironment.gym;
  }

  static Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    final stored = prefs.getStringList(_prefsKey);
    if (stored != null && stored.isNotEmpty) {
      final parsed = <TrainingEnvironment>{};
      for (final raw in stored) {
        final env = TrainingEnvironment.tryParse(raw);
        if (env != null) parsed.add(env);
      }
      if (parsed.isNotEmpty) {
        instance._environments = parsed;
        return;
      }
    }

    final legacy = TrainingEnvironment.tryParse(prefs.getString(_legacyPrefsKey));
    if (legacy != null) {
      instance._environments = {legacy};
      await prefs.setStringList(_prefsKey, [legacy.name]);
      await prefs.remove(_legacyPrefsKey);
    }
  }

  Future<void> setEnvironments(Set<TrainingEnvironment> envs) async {
    final next = envs.isEmpty ? {TrainingEnvironment.gym} : Set.of(envs);
    if (setEquals(_environments, next)) return;
    _environments = next;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(
      _prefsKey,
      next.map((e) => e.name).toList(growable: false),
    );
  }

  Future<void> toggleEnvironment(TrainingEnvironment env) async {
    final next = Set.of(_environments);
    if (!next.add(env)) {
      if (next.length == 1) return;
      next.remove(env);
    }
    await setEnvironments(next);
  }
}
