import '../l10n/localized_string.dart';
import '../models/models.dart';
import 'user_preferences.dart';

LocalizedString _t(String en, String am, String om) =>
    LocalizedString(en: en, am: am, om: om);

bool exerciseMatchesEnvironment(
  ExerciseItem exercise,
  TrainingEnvironment environment,
) {
  final equipment = exercise.equipment.en;
  return switch (environment) {
    TrainingEnvironment.noEquipment => equipment == 'Bodyweight',
    TrainingEnvironment.home =>
      equipment == 'Bodyweight' || equipment == 'Dumbbells',
    TrainingEnvironment.gym => true,
  };
}

bool exerciseMatchesEnvironments(
  ExerciseItem exercise,
  Set<TrainingEnvironment> environments,
) {
  if (environments.isEmpty) return true;
  return environments.any(
    (env) => exerciseMatchesEnvironment(exercise, env),
  );
}

bool workoutMatchesEnvironments(
  WorkoutPlan workout,
  Set<TrainingEnvironment> environments,
) {
  if (workout.exercises.isEmpty) return false;
  return workout.exercises.every(
    (we) => exerciseMatchesEnvironments(we.exercise, environments),
  );
}

/// Builds workout plans from the synced exercise catalog.
abstract final class WorkoutCatalog {
  static List<WorkoutPlan> plansFrom(List<ExerciseItem> catalog) {
    List<WorkoutExercise> pick(
      bool Function(ExerciseItem) matches,
      int max,
    ) {
      return [
        for (final e in catalog)
          if (matches(e)) _setsFor(e),
      ].take(max).toList();
    }

    List<WorkoutExercise> pickVaried(
      bool Function(ExerciseItem) matches,
      int max,
    ) {
      final counts = <String, int>{};
      final result = <WorkoutExercise>[];
      for (final e in catalog) {
        if (result.length >= max) break;
        if (!matches(e)) continue;
        final group =
            e.bodyPartSlugs.isNotEmpty ? e.bodyPartSlugs.first : 'other';
        final count = counts[group] ?? 0;
        if (count >= 2) continue;
        counts[group] = count + 1;
        result.add(_setsFor(e));
      }
      return result;
    }

    final intermediate = _t('Intermediate', 'መካከለኛ', 'Giddugaleessa');
    final beginner = _t('Beginner', 'ጀማሪ', 'Jalqabaa');

    final plans = <_PlanSpec>[
      _PlanSpec(
        id: 'w1',
        title: _t('Chest + Triceps', 'ደረት + ትራይሴፕስ', 'Qoma + Tiraayseepsii'),
        durationMinutes: 45,
        level: intermediate,
        muscles: [
          _t('Chest', 'ደረት', 'Qoma'),
          _t('Shoulders', 'ትከሻዎች', 'Gurruu'),
          _t('Triceps', 'ትራይሴፕስ', 'Tiraayseepsii'),
        ],
        owner: 'Miki',
        tag: _t('Today', 'ዛሬ', 'Har\'a'),
        exercises: pick(
          (e) =>
              e.bodyPartSlugs.contains('chest') ||
              e.primaryMuscleSlug == 'triceps',
          7,
        ),
      ),
      _PlanSpec(
        id: 'w2',
        title: _t('Push Day', 'ፑሽ ቀን', 'Guyyaa Pushii'),
        durationMinutes: 45,
        level: intermediate,
        muscles: [
          _t('Chest', 'ደረት', 'Qoma'),
          _t('Shoulders', 'ትከሻዎች', 'Gurruu'),
          _t('Triceps', 'ትራይሴፕስ', 'Tiraayseepsii'),
        ],
        owner: 'Abel',
        tag: _t('Popular', 'ታዋቂ', 'Beekamaa'),
        exercises: pick(
          (e) =>
              e.bodyPartSlugs.contains('chest') ||
              e.bodyPartSlugs.contains('shoulders') ||
              e.primaryMuscleSlug == 'triceps',
          6,
        ),
      ),
      _PlanSpec(
        id: 'w5',
        title: _t('Back + Biceps', 'ጀርባ + ባይሴፕስ', 'Dugda + Baayseepsii'),
        durationMinutes: 50,
        level: intermediate,
        muscles: [
          _t('Back', 'ጀርባ', 'Dugda'),
          _t('Arms', 'እጆች', 'Harka'),
        ],
        owner: 'Hana',
        tag: _t('Pull', 'ፑል', 'Pulii'),
        exercises: pick(
          (e) =>
              e.bodyPartSlugs.contains('back') ||
              e.primaryMuscleSlug == 'biceps',
          6,
        ),
      ),
      _PlanSpec(
        id: 'w6',
        title: _t('Legs Day', 'የእግር ቀን', 'Guyyaa Miilaa'),
        durationMinutes: 55,
        level: intermediate,
        muscles: [_t('Legs', 'እግሮች', 'Miila')],
        owner: 'Dawit',
        tag: _t('Lower', 'ታችኛ', 'Gadii'),
        exercises: pick(
          (e) =>
              e.bodyPartSlugs.contains('upper-legs') ||
              e.bodyPartSlugs.contains('lower-legs'),
          6,
        ),
      ),
      _PlanSpec(
        id: 'w7',
        title: _t('Shoulders Focus', 'ትኩረት ትከሻ', 'Xiyyeeffannoo Gurruu'),
        durationMinutes: 35,
        level: intermediate,
        muscles: [_t('Shoulders', 'ትከሻዎች', 'Gurruu')],
        owner: 'Sara',
        tag: _t('Focus', 'ትኩረት', 'Xiyyeeffannoo'),
        exercises: pick(
          (e) =>
              e.bodyPartSlugs.contains('shoulders') ||
              e.primaryMuscleSlug == 'delts',
          5,
        ),
      ),
      _PlanSpec(
        id: 'w3',
        title: _t('Home Full Body', 'በቤት ሙሉ አካል', 'Manaa Qaama Guutuu'),
        durationMinutes: 30,
        level: beginner,
        muscles: [_t('Full body', 'ሙሉ አካል', 'Qaama guutuu')],
        owner: 'Miki',
        tag: _t('Home', 'ቤት', 'Mana'),
        exercises: pickVaried(
          (e) =>
              e.equipment.en == 'Bodyweight' || e.equipment.en == 'Dumbbells',
          5,
        ),
      ),
      _PlanSpec(
        id: 'w4',
        title: _t('15-Min Burn', '15 ደቂቃ ማቃጠል', 'Gubuu Daqiiqaa 15'),
        durationMinutes: 15,
        level: beginner,
        muscles: [
          _t('Full body', 'ሙሉ አካል', 'Qaama guutuu'),
          _t('Cardio', 'ካርዲዮ', 'Kaardiyoo'),
        ],
        owner: 'Abel',
        tag: _t('Quick', 'ፈጣን', 'Saffisaa'),
        exercises: pick((e) => e.equipment.en == 'Bodyweight', 4),
      ),
    ];

    return [
      for (final spec in plans)
        if (spec.exercises.isNotEmpty) spec.toPlan(),
    ];
  }

  /// Default sets/reps/weight for an exercise, matched to its equipment.
  static WorkoutExercise defaultExercisePrescription(ExerciseItem exercise) =>
      _setsFor(exercise);

  static WorkoutExercise _setsFor(ExerciseItem exercise) {
    final (sets, reps, weight) = switch (exercise.equipment.en) {
      'Bodyweight' => (3, 15, 0.0),
      'Dumbbells' => (3, 12, 10.0),
      'Barbell' => (4, 8, 40.0),
      'Cable' => (3, 12, 20.0),
      _ => (3, 10, 30.0),
    };
    return WorkoutExercise(
      exercise: exercise,
      sets: sets,
      reps: reps,
      weightKg: weight,
    );
  }
}

class _PlanSpec {
  const _PlanSpec({
    required this.id,
    required this.title,
    required this.durationMinutes,
    required this.level,
    required this.muscles,
    required this.exercises,
    required this.owner,
    this.tag,
  });

  final String id;
  final LocalizedString title;
  final int durationMinutes;
  final LocalizedString level;
  final List<LocalizedString> muscles;
  final List<WorkoutExercise> exercises;
  final String owner;
  final LocalizedString? tag;

  WorkoutPlan toPlan() => WorkoutPlan(
        id: id,
        title: title,
        durationMinutes: durationMinutes,
        level: level,
        muscles: muscles,
        exercises: exercises,
        owner: owner,
        tag: tag,
      );
}
