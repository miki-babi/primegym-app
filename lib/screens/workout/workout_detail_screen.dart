import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../data/app_store.dart';
import '../../data/mock_data.dart';
import '../../l10n/l10n_ext.dart';
import '../../theme/app_colors.dart';
import '../../widgets/exercise_image.dart';
import '../../widgets/muscle_filter_card.dart';
import '../../widgets/pg_button.dart';
import '../../widgets/scroll_edge_hint.dart';

class WorkoutDetailScreen extends StatelessWidget {
  const WorkoutDetailScreen({super.key, required this.workoutId});

  final String workoutId;

  Future<void> _toggleSave(BuildContext context) async {
    final l10n = context.l10n;
    final added =
        await AppStore.instance.toggleSavedWorkoutPlan(workoutId);
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          added ? l10n.savedForLaterSnack : l10n.removedFromSavedSnack,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final workout = MockData.workoutById(workoutId) ?? MockData.todaysWorkout;
    final textTheme = Theme.of(context).textTheme;
    final l10n = context.l10n;
    final locale = Localizations.localeOf(context);
    final showMuscleScrollHint = workout.muscles.length > 3;

    return ListenableBuilder(
      listenable: AppStore.instance,
      builder: (context, _) {
        final saved = AppStore.instance.isWorkoutPlanSaved(workout.id);

        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_rounded),
              onPressed: () => context.pop(),
            ),
            title: Text(l10n.workoutTitle),
            actions: [
              IconButton(
                tooltip: saved ? l10n.unsaveWorkout : l10n.saveWorkout,
                onPressed: () => _toggleSave(context),
                icon: Icon(
                  saved
                      ? Icons.bookmark_rounded
                      : Icons.bookmark_border_rounded,
                  color: saved ? AppColors.accent : AppColors.textSecondary,
                ),
              ),
            ],
          ),
          body: Column(
            children: [
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
                  children: [
                    Text(
                      workout.title.resolve(locale),
                      style: textTheme.headlineMedium,
                    ),
                    if (workout.muscles.isNotEmpty) ...[
                      const SizedBox(height: 20),
                      Text(
                        l10n.filterTargetMuscle,
                        style: textTheme.labelMedium?.copyWith(
                          color: AppColors.textTertiary,
                          letterSpacing: 0.6,
                        ),
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        height: 112,
                        child: Stack(
                          children: [
                            ListView.separated(
                              scrollDirection: Axis.horizontal,
                              padding: EdgeInsets.only(
                                right: showMuscleScrollHint ? 40 : 0,
                              ),
                              itemCount: workout.muscles.length,
                              separatorBuilder: (_, _) =>
                                  const SizedBox(width: 10),
                              itemBuilder: (context, i) {
                                final muscle = workout.muscles[i];
                                return MuscleFilterCard(
                                  key: ValueKey(muscle.en),
                                  label: muscle.resolve(locale),
                                  imageAsset:
                                      MockData.muscleImageAsset(muscle.en),
                                  selected: true,
                                );
                              },
                            ),
                            if (showMuscleScrollHint)
                              const Positioned(
                                right: 0,
                                top: 0,
                                bottom: 0,
                                child: ScrollEdgeHint(),
                              ),
                          ],
                        ),
                      ),
                    ],
                    const SizedBox(height: 20),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        _Chip(
                          icon: Icons.schedule_rounded,
                          label: l10n.durationMinutes(workout.durationMinutes),
                        ),
                        _Chip(
                          icon: Icons.signal_cellular_alt_rounded,
                          label: workout.level.resolve(locale),
                        ),
                        if (saved)
                          _Chip(
                            icon: Icons.bookmark_rounded,
                            label: l10n.savedForLater,
                            accent: true,
                          ),
                      ],
                    ),
                    const SizedBox(height: 28),
                    Text(
                      l10n.exercisesCountCapitalized(workout.exercises.length),
                      style: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 12),
                    for (var i = 0; i < workout.exercises.length; i++) ...[
                      if (i > 0) const SizedBox(height: 12),
                      Material(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(16),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(16),
                          onTap: () => context.push(
                            '/exercise/${workout.exercises[i].exercise.id}',
                          ),
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: AppColors.border),
                            ),
                            child: Row(
                              children: [
                                ExerciseImage(
                                  assetPath:
                                      workout.exercises[i].exercise.imageAsset,
                                  width: 56,
                                  height: 56,
                                  borderRadius: 12,
                                ),
                                const SizedBox(width: 14),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        workout.exercises[i].exercise.name
                                            .resolve(locale),
                                        style: textTheme.titleMedium,
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        workout.exercises[i].weightKg > 0
                                            ? l10n.setsTimesRepsWithWeight(
                                                workout.exercises[i].sets,
                                                '${workout.exercises[i].reps}',
                                                l10n.weightKg(
                                                  workout.exercises[i].weightKg
                                                      .toInt(),
                                                ),
                                              )
                                            : l10n.setsTimesReps(
                                                workout.exercises[i].sets,
                                                '${workout.exercises[i].reps}',
                                              ),
                                        style: textTheme.bodySmall,
                                      ),
                                    ],
                                  ),
                                ),
                                const GlassyChevron(),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
                child: Row(
                  children: [
                    Expanded(
                      flex: 5,
                      child: PgButton(
                        label: saved ? l10n.unsaveWorkout : l10n.saveWorkout,
                        variant: PgButtonVariant.secondary,
                        icon: Icon(
                          saved
                              ? Icons.bookmark_remove_rounded
                              : Icons.bookmark_add_rounded,
                          size: 18,
                          color: AppColors.accent,
                        ),
                        onPressed: () => _toggleSave(context),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      flex: 6,
                      child: PgButton(
                        label: l10n.startWorkout,
                        icon: const Icon(
                          Icons.play_arrow_rounded,
                          size: 18,
                          color: Color(0xFF1A1200),
                        ),
                        onPressed: () =>
                            context.push('/workout/${workout.id}/active'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip({
    required this.label,
    this.icon,
    this.accent = false,
  });

  final String label;
  final IconData? icon;
  final bool accent;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: accent ? AppColors.accentSoft : AppColors.surfaceElevated,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: accent ? AppColors.accent.withValues(alpha: 0.35) : AppColors.border,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(
              icon,
              size: 16,
              color: accent ? AppColors.accent : AppColors.textTertiary,
            ),
            const SizedBox(width: 6),
          ],
          Text(
            label,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: accent ? AppColors.accent : AppColors.textSecondary,
                  fontWeight: FontWeight.w600,
                ),
          ),
        ],
      ),
    );
  }
}
