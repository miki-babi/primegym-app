import 'package:flutter_test/flutter_test.dart';
import 'package:primegym/data/workout_catalog.dart';
import 'package:primegym/l10n/localized_string.dart';
import 'package:primegym/models/models.dart';

ExerciseItem exercise(
  String id, {
  List<String> bodyParts = const [],
  String? primaryMuscle,
  String equipmentEn = 'Bodyweight',
  String? equipmentSlug,
}) {
  final label = LocalizedString(en: equipmentEn, am: equipmentEn, om: equipmentEn);
  return ExerciseItem(
    id: id,
    name: LocalizedString(en: id, am: id, om: id),
    muscle: const LocalizedString(en: 'X', am: 'X', om: 'X'),
    type: const LocalizedString(en: 'Compound', am: 'C', om: 'C'),
    difficulty: const LocalizedString(en: 'Beginner', am: 'B', om: 'B'),
    equipment: label,
    instructions: const LocalizedString(en: '', am: '', om: ''),
    commonMistakes: const LocalizedString(en: '', am: '', om: ''),
    imageAsset: 'x.png',
    youtubeVideoId: '',
    bodyPartSlugs: bodyParts,
    primaryMuscleSlug: primaryMuscle,
    equipmentSlug: equipmentSlug,
  );
}

void main() {
  test('builds plans with expected ids and preserves catalog order', () {
    final catalog = [
      exercise('a', bodyParts: ['chest'], equipmentEn: 'Barbell'),
      exercise('b', bodyParts: ['back'], equipmentEn: 'Cable'),
      exercise('c', bodyParts: ['upper-legs'], equipmentEn: 'Bodyweight'),
      exercise('d', primaryMuscle: 'triceps', equipmentEn: 'Dumbbells'),
    ];

    final plans = WorkoutCatalog.plansFrom(catalog);
    final ids = plans.map((p) => p.id).toList();

    expect(ids, ['w1', 'w2', 'w5', 'w6', 'w3', 'w4']);
    expect(plans.firstWhere((p) => p.id == 'w7', orElse: () => plans.first).id,
        isNot('w7'));
    // w7 has no matching exercises and is omitted.
    expect(ids.contains('w7'), isFalse);

    final w1 = plans.firstWhere((p) => p.id == 'w1');
    expect(w1.exercises.map((e) => e.exercise.id), ['a', 'd']);
    // Barbell exercise -> 4x8 @ 40kg.
    expect(w1.exercises.first.sets, 4);
    expect(w1.exercises.first.reps, 8);
    expect(w1.exercises.first.weightKg, 40.0);

    final w4 = plans.firstWhere((p) => p.id == 'w4');
    expect(w4.exercises.map((e) => e.exercise.id), ['c']);
  });

  test('respects plan exercise limits', () {
    final catalog = [
      for (var i = 0; i < 10; i++)
        exercise('c$i', bodyParts: ['chest'], equipmentEn: 'Barbell'),
    ];
    final w1 =
        WorkoutCatalog.plansFrom(catalog).firstWhere((p) => p.id == 'w1');
    expect(w1.exercises.length, 7);
    final w2 =
        WorkoutCatalog.plansFrom(catalog).firstWhere((p) => p.id == 'w2');
    expect(w2.exercises.length, 6);
  });

  test('empty catalog yields no plans', () {
    expect(WorkoutCatalog.plansFrom(const []), isEmpty);
  });
}
