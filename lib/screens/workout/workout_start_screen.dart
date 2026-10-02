import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../data/exercise_preferences.dart';
import '../../data/mock_data.dart';
import '../../data/user_preferences.dart';
import '../../l10n/l10n_ext.dart';
import '../../models/models.dart';
import '../../theme/app_colors.dart';
import '../../widgets/muscle_filter_card.dart';
import '../../widgets/pg_card.dart';
import '../../widgets/scroll_edge_hint.dart';
import '../../widgets/section_header.dart';
import '../../widgets/todays_workout_card.dart';

class WorkoutStartScreen extends StatefulWidget {
  const WorkoutStartScreen({super.key});

  @override
  State<WorkoutStartScreen> createState() => _WorkoutStartScreenState();
}

class _WorkoutStartScreenState extends State<WorkoutStartScreen> {
  String _muscle = 'All';

  Set<String> get _likedMuscles {
    final liked = <String>{};
    for (final id in ExercisePreferences.likedExerciseIds()) {
      final ex = MockData.exerciseById(id);
      if (ex != null) liked.add(ex.muscle.en);
    }
    return liked;
  }

  Set<String> get _dislikedMuscles {
    final disliked = <String>{};
    for (final id in ExercisePreferences.dislikedExerciseIds()) {
      final ex = MockData.exerciseById(id);
      if (ex != null) disliked.add(ex.muscle.en);
    }
    return disliked;
  }

  List<WorkoutPlan> get _alternatives {
    final envs = UserPreferences.instance.environments;
    final todayId = MockData.todaysWorkoutFor(envs).id;
    var list = MockData.workoutsForMuscle(_muscle, environments: envs)
        .where((w) => w.id != todayId)
        .toList();

    final liked = _likedMuscles;
    final disliked = _dislikedMuscles;

    list.sort((a, b) {
      int score(WorkoutPlan w) {
        var s = 0;
        for (final m in w.muscles) {
          if (liked.contains(m.en)) s += 10;
          if (disliked.contains(m.en)) s -= 5;
        }
        return s;
      }

      return score(b).compareTo(score(a));
    });
    return list;
  }

  bool _basedOnYou(WorkoutPlan w) {
    final liked = _likedMuscles;
    return w.muscles.any((m) => liked.contains(m.en));
  }

  void _toggleMuscle(String muscleEn) {
    setState(() {
      if (_muscle == muscleEn) {
        _muscle = 'All';
      } else {
        _muscle = muscleEn;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final l10n = context.l10n;
    final locale = Localizations.localeOf(context);
    final today = MockData.todaysWorkoutFor(
      UserPreferences.instance.environments,
    );
    final subtitle =
        '${l10n.workoutDurationLevel(today.durationMinutes, today.level.resolve(locale))} · ${l10n.exercisesCount(today.exercises.length)}';

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => context.pop(),
        ),
        title: Text(l10n.startWorkoutTitle),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
        children: [
          TodaysWorkoutCard(
            todayLabel: l10n.todaysSuggestion,
            title: today.title.resolve(locale),
            subtitle: subtitle,
            ctaLabel: l10n.startTodaysPlan,
            onTap: () => context.push('/workout/${today.id}'),
          ),
          const SizedBox(height: 32),
          SectionHeader(title: l10n.orTrainSomethingElse),
          const SizedBox(height: 12),
          SizedBox(
            height: 112,
            child: Stack(
              children: [
                ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.only(right: 40),
                  itemCount: MockData.muscleFilters.length,
                  separatorBuilder: (_, _) => const SizedBox(width: 10),
                  itemBuilder: (context, i) {
                    final muscle = MockData.muscleFilters[i];
                    final selected = _muscle == muscle.en;
                    return MuscleFilterCard(
                      key: ValueKey(muscle.en),
                      label: muscle.resolve(locale),
                      imageAsset: MockData.muscleImageAsset(muscle.en),
                      selected: selected,
                      onTap: () => _toggleMuscle(muscle.en),
                    );
                  },
                ),
                const Positioned(
                  right: 0,
                  top: 0,
                  bottom: 0,
                  child: ScrollEdgeHint(),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          if (_alternatives.isEmpty)
            PgCard(
              child: Text(
                l10n.noWorkoutsForFilter,
                style: textTheme.bodyMedium,
              ),
            )
          else
            for (final workout in _alternatives) ...[
              PgCard(
                onTap: () => context.push('/workout/${workout.id}'),
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: AppColors.accentSoft,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: const Icon(
                        Icons.fitness_center_rounded,
                        color: AppColors.accent,
                        size: 22,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  workout.title.resolve(locale),
                                  style: textTheme.titleMedium,
                                ),
                              ),
                              if (_basedOnYou(workout))
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.accentSoft,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    l10n.basedOnYou,
                                    style: textTheme.labelSmall?.copyWith(
                                      color: AppColors.accent,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            l10n.workoutDurationMuscles(
                              workout.durationMinutes,
                              workout.muscles
                                  .map((m) => m.resolve(locale))
                                  .join(' · '),
                            ),
                            style: textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                    const Icon(
                      Icons.chevron_right_rounded,
                      color: AppColors.textMuted,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
            ],
        ],
      ),
    );
  }
}
