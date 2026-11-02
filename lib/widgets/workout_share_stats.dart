import '../l10n/app_localizations.dart';
import '../models/models.dart';
import 'workout_share_card.dart';

/// Demo duration offset already used on the complete screen.
const kWorkoutShareDurationBoost = 9;

List<WorkoutShareStat> buildWorkoutShareStats({
  required WorkoutPlan workout,
  required AppLocalizations l10n,
  double? sessionWeightSum,
}) {
  final durationMinutes = workout.durationMinutes + kWorkoutShareDurationBoost;
  final sets = workout.exercises.fold<int>(0, (sum, e) => sum + e.sets);
  final planWeightSum = workout.exercises.fold<double>(
    0,
    (sum, e) => sum + e.weightKg,
  );
  final volume = sessionWeightSum != null && sessionWeightSum > 0
      ? sessionWeightSum
      : planWeightSum;
  final volumeDisplay = volume % 1 == 0
      ? volume.toInt().toString()
      : volume.toStringAsFixed(0);

  return [
    WorkoutShareStat(
      label: l10n.shareStatDuration,
      value: l10n.shareStatDurationValue(durationMinutes),
    ),
    WorkoutShareStat(
      label: l10n.shareStatExercises,
      value: '${workout.exercises.length}',
    ),
    WorkoutShareStat(
      label: l10n.shareStatSets,
      value: '$sets',
    ),
    WorkoutShareStat(
      label: l10n.shareStatVolume,
      value: l10n.shareStatVolumeValue(volumeDisplay),
    ),
  ];
}
