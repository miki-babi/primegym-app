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

enum FitnessGoal {
  strength,
  weightLoss,
  muscleGain;

  static FitnessGoal? tryParse(String? raw) {
    if (raw == null || raw.isEmpty) return null;
    for (final value in FitnessGoal.values) {
      if (value.name == raw) return value;
    }
    return null;
  }
}

enum TrainingFrequency {
  once,
  twice,
  three,
  four,
  five,
  six,
  everyday;

  static TrainingFrequency? tryParse(String? raw) {
    if (raw == null || raw.isEmpty) return null;
    for (final value in TrainingFrequency.values) {
      if (value.name == raw) return value;
    }
    return null;
  }
}

enum ExperienceLevel {
  beginner,
  intermediate,
  advanced;

  static ExperienceLevel? tryParse(String? raw) {
    if (raw == null || raw.isEmpty) return null;
    for (final value in ExperienceLevel.values) {
      if (value.name == raw) return value;
    }
    return null;
  }
}

enum TrainingLocation {
  home,
  gym,
  outdoor;

  static TrainingLocation? tryParse(String? raw) {
    if (raw == null || raw.isEmpty) return null;
    for (final value in TrainingLocation.values) {
      if (value.name == raw) return value;
    }
    return null;
  }

  TrainingEnvironment get asEnvironment => switch (this) {
    TrainingLocation.home => TrainingEnvironment.home,
    TrainingLocation.gym => TrainingEnvironment.gym,
    TrainingLocation.outdoor => TrainingEnvironment.noEquipment,
  };
}

enum AvailableEquipment {
  // Free weights & resistance
  bodyweight,
  dumbbells,
  barbell,
  kettlebells,
  bands,
  ezCurlBar,
  // Gym structures & benches
  weightBench,
  squatRack,
  pullUpBar,
  machines,
  cable,
  smithMachine,
  // Functional & bodyweight tools
  trx,
  gymnasticRings,
  weightVest,
  plyoBox,
  medicineBall,
  sandbag,
  // Cardio
  treadmill,
  bike,
  rowingMachine,
  skiErg,
  stairmaster,
  jumpRope,
  // Core & recovery
  abWheel,
  foamRoller,
  yogaMat;

  static AvailableEquipment? tryParse(String? raw) {
    if (raw == null || raw.isEmpty) return null;
    // Legacy aliases from earlier onboarding sets.
    if (raw == 'resistanceBands') return AvailableEquipment.bands;
    if (raw == 'cableMachine') return AvailableEquipment.cable;
    for (final value in AvailableEquipment.values) {
      if (value.name == raw) return value;
    }
    return null;
  }
}

class UserPreferences extends ChangeNotifier {
  UserPreferences._();
  static final UserPreferences instance = UserPreferences._();

  static const _envsKey = 'primegym_training_environments';
  static const _legacyEnvKey = 'primegym_training_environment';
  static const _nameKey = 'primegym_display_name';
  static const _goalKey = 'primegym_fitness_goal';
  static const _goalsKey = 'primegym_fitness_goals';
  static const _frequencyKey = 'primegym_training_frequency';
  static const _experienceKey = 'primegym_experience_level';
  static const _locationKey = 'primegym_training_location';
  static const _equipmentKey = 'primegym_available_equipment';

  Set<TrainingEnvironment> _environments = {TrainingEnvironment.gym};
  String _displayName = '';
  Set<FitnessGoal> _fitnessGoals = {};
  TrainingFrequency? _trainingFrequency;
  ExperienceLevel? _experienceLevel;
  TrainingLocation? _trainingLocation;
  Set<AvailableEquipment> _equipment = {};

  Set<TrainingEnvironment> get environments => Set.unmodifiable(_environments);

  String get displayName => _displayName;

  /// Name for greetings/UI; falls back when onboarding name is empty.
  String get resolvedDisplayName =>
      _displayName.trim().isEmpty ? 'Athlete' : _displayName.trim();

  Set<FitnessGoal> get fitnessGoals => Set.unmodifiable(_fitnessGoals);

  /// First selected goal, for callers that only need a primary.
  FitnessGoal? get fitnessGoal =>
      _fitnessGoals.isEmpty ? null : _fitnessGoals.first;

  TrainingFrequency? get trainingFrequency => _trainingFrequency;
  ExperienceLevel? get experienceLevel => _experienceLevel;
  TrainingLocation? get trainingLocation => _trainingLocation;
  Set<AvailableEquipment> get equipment => Set.unmodifiable(_equipment);

  /// Primary environment for ranking "today" workouts.
  TrainingEnvironment get primaryEnvironment {
    if (_trainingLocation != null) {
      return _trainingLocation!.asEnvironment;
    }
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
    final stored = prefs.getStringList(_envsKey);
    if (stored != null && stored.isNotEmpty) {
      final parsed = <TrainingEnvironment>{};
      for (final raw in stored) {
        final env = TrainingEnvironment.tryParse(raw);
        if (env != null) parsed.add(env);
      }
      if (parsed.isNotEmpty) {
        instance._environments = parsed;
      }
    } else {
      final legacy = TrainingEnvironment.tryParse(prefs.getString(_legacyEnvKey));
      if (legacy != null) {
        instance._environments = {legacy};
        await prefs.setStringList(_envsKey, [legacy.name]);
        await prefs.remove(_legacyEnvKey);
      }
    }

    instance._displayName = prefs.getString(_nameKey) ?? '';

    final goalsRaw = prefs.getStringList(_goalsKey);
    if (goalsRaw != null && goalsRaw.isNotEmpty) {
      final parsed = <FitnessGoal>{};
      for (final raw in goalsRaw) {
        final goal = FitnessGoal.tryParse(raw);
        if (goal != null) parsed.add(goal);
      }
      instance._fitnessGoals = parsed;
    } else {
      final legacy = FitnessGoal.tryParse(prefs.getString(_goalKey));
      if (legacy != null) {
        instance._fitnessGoals = {legacy};
        await prefs.setStringList(_goalsKey, [legacy.name]);
        await prefs.remove(_goalKey);
      }
    }

    instance._trainingFrequency =
        TrainingFrequency.tryParse(prefs.getString(_frequencyKey));
    instance._experienceLevel =
        ExperienceLevel.tryParse(prefs.getString(_experienceKey));
    instance._trainingLocation =
        TrainingLocation.tryParse(prefs.getString(_locationKey));

    final equipmentRaw = prefs.getStringList(_equipmentKey);
    if (equipmentRaw != null && equipmentRaw.isNotEmpty) {
      final parsed = <AvailableEquipment>{};
      for (final raw in equipmentRaw) {
        final item = AvailableEquipment.tryParse(raw);
        if (item != null) parsed.add(item);
      }
      instance._equipment = parsed;
    }
  }

  Future<void> setDisplayName(String name) async {
    final next = name.trim();
    if (_displayName == next) return;
    _displayName = next;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_nameKey, next);
  }

  Future<void> setFitnessGoals(Set<FitnessGoal> goals) async {
    final next = Set.of(goals);
    if (setEquals(_fitnessGoals, next)) return;
    _fitnessGoals = next;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(
      _goalsKey,
      next.map((e) => e.name).toList(growable: false),
    );
    await prefs.remove(_goalKey);
  }

  Future<void> setFitnessGoal(FitnessGoal goal) async {
    await setFitnessGoals({goal});
  }

  Future<void> setTrainingFrequency(TrainingFrequency frequency) async {
    if (_trainingFrequency == frequency) return;
    _trainingFrequency = frequency;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_frequencyKey, frequency.name);
  }

  Future<void> setExperienceLevel(ExperienceLevel level) async {
    if (_experienceLevel == level) return;
    _experienceLevel = level;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_experienceKey, level.name);
  }

  Future<void> setTrainingLocation(TrainingLocation location) async {
    if (_trainingLocation == location) return;
    _trainingLocation = location;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_locationKey, location.name);
    await setEnvironments({location.asEnvironment});
  }

  Future<void> setEquipment(Set<AvailableEquipment> items) async {
    final next = Set.of(items);
    if (setEquals(_equipment, next)) return;
    _equipment = next;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(
      _equipmentKey,
      next.map((e) => e.name).toList(growable: false),
    );
  }

  Future<void> setEnvironments(Set<TrainingEnvironment> envs) async {
    final next = envs.isEmpty ? {TrainingEnvironment.gym} : Set.of(envs);
    if (setEquals(_environments, next)) return;
    _environments = next;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(
      _envsKey,
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
