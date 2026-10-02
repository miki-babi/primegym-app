import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../data/app_store.dart';
import '../../data/mock_data.dart';
import '../../l10n/l10n_ext.dart';
import '../../l10n/localized_string.dart';
import '../../models/models.dart';
import '../../theme/app_colors.dart';
import '../../widgets/exercise_image.dart';
import '../../widgets/muscle_filter_card.dart';
import '../../widgets/pg_card.dart';
import '../../widgets/scroll_edge_hint.dart';
import '../../widgets/user_avatar.dart';

class ExploreWorkoutsScreen extends StatefulWidget {
  const ExploreWorkoutsScreen({super.key});

  @override
  State<ExploreWorkoutsScreen> createState() => _ExploreWorkoutsScreenState();
}

class _ExploreWorkoutsScreenState extends State<ExploreWorkoutsScreen> {
  final Set<String> _muscleEn = {};
  final Set<String> _equipmentEn = {};
  final ScrollController _muscleScrollController = ScrollController();

  static const _fullBodyKey = 'Full body';

  Set<String> get _allMuscleKeys => {
    for (final muscle in MockData.muscleFilters) muscle.en,
  };

  Set<String> get _partMuscleKeys =>
      _allMuscleKeys.where((key) => key != _fullBodyKey).toSet();

  List<LocalizedString> get _orderedMuscleFilters {
    final selected = <LocalizedString>[];
    final unselected = <LocalizedString>[];
    for (final muscle in MockData.muscleFilters) {
      if (_muscleEn.contains(muscle.en)) {
        selected.add(muscle);
      } else {
        unselected.add(muscle);
      }
    }
    return [...selected, ...unselected];
  }

  List<WorkoutPlan> get _filtered => MockData.workoutsForFilters(
    muscleEn: _muscleEn,
    equipmentEn: _equipmentEn,
  );

  List<WorkoutPlan> get _savedWorkouts {
    final savedIds = AppStore.instance.savedWorkoutPlanIds;
    return _filtered.where((w) => savedIds.contains(w.id)).toList();
  }

  List<WorkoutPlan> get _popularWorkouts {
    final savedIds = AppStore.instance.savedWorkoutPlanIds;
    return _filtered.where((w) => !savedIds.contains(w.id)).toList();
  }

  @override
  void dispose() {
    _muscleScrollController.dispose();
    super.dispose();
  }

  void _scrollMusclesToFront() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_muscleScrollController.hasClients) return;
      _muscleScrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOutCubic,
      );
    });
  }

  void _toggleMuscle(String muscleEn) {
    setState(() {
      if (muscleEn == _fullBodyKey) {
        if (_muscleEn.contains(_fullBodyKey) &&
            _partMuscleKeys.every(_muscleEn.contains)) {
          _muscleEn.clear();
        } else {
          _muscleEn
            ..clear()
            ..addAll(_allMuscleKeys);
        }
      } else if (_muscleEn.contains(muscleEn)) {
        _muscleEn.remove(muscleEn);
        _muscleEn.remove(_fullBodyKey);
      } else {
        _muscleEn.add(muscleEn);
        if (_partMuscleKeys.every(_muscleEn.contains)) {
          _muscleEn.add(_fullBodyKey);
        }
      }
    });
    _scrollMusclesToFront();
  }

  String _equipmentLabel(AppLocalizations l10n, String key) {
    return switch (key) {
      'Bodyweight' => l10n.equipmentBodyweight,
      'Dumbbells' => l10n.equipmentDumbbells,
      'Barbell' => l10n.equipmentBarbell,
      'Cable' => l10n.equipmentCable,
      _ => key,
    };
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: AppStore.instance,
      builder: (context, _) {
        final textTheme = Theme.of(context).textTheme;
        final l10n = context.l10n;
        final locale = Localizations.localeOf(context);
        final saved = _savedWorkouts;
        final popular = _popularWorkouts;
        final noneMatch = saved.isEmpty && popular.isEmpty;

        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_rounded),
              onPressed: () => context.pop(),
            ),
            title: Text(l10n.exploreWorkouts),
          ),
          body: ListView(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
            children: [
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
                  controller: _muscleScrollController,
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.only(right: 40),
                  itemCount: _orderedMuscleFilters.length,
                  separatorBuilder: (_, _) => const SizedBox(width: 10),
                  itemBuilder: (context, i) {
                    final muscle = _orderedMuscleFilters[i];
                    final selected = _muscleEn.contains(muscle.en);
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
          const SizedBox(height: 20),
          Text(
            l10n.filterAvailableEquipment,
            style: textTheme.labelMedium?.copyWith(
              color: AppColors.textTertiary,
              letterSpacing: 0.6,
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 40,
            child: Stack(
              children: [
                ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.only(right: 40),
                  itemCount: MockData.equipmentFilters.length,
                  separatorBuilder: (_, _) => const SizedBox(width: 8),
                  itemBuilder: (context, i) {
                    final equipment = MockData.equipmentFilters[i];
                    final selected = _equipmentEn.contains(equipment.en);
                    return _FilterChip(
                      label: _equipmentLabel(l10n, equipment.en),
                      selected: selected,
                      onTap: () {
                        setState(() {
                          if (!selected) {
                            _equipmentEn.add(equipment.en);
                          } else {
                            _equipmentEn.remove(equipment.en);
                          }
                        });
                      },
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
          const SizedBox(height: 28),
          if (noneMatch)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 48),
              child: Center(
                child: Text(
                  l10n.noWorkoutsMatchFilters,
                  textAlign: TextAlign.center,
                  style: textTheme.bodyMedium?.copyWith(
                    color: AppColors.textTertiary,
                  ),
                ),
              ),
            )
          else ...[
            if (saved.isNotEmpty) ...[
              Text(
                l10n.savedWorkouts,
                style: textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12),
              for (var i = 0; i < saved.length; i++) ...[
                if (i > 0) const SizedBox(height: 12),
                _WorkoutResultCard(workout: saved[i]),
              ],
            ],
            if (saved.isNotEmpty && popular.isNotEmpty)
              const SizedBox(height: 28),
            if (popular.isNotEmpty) ...[
              Text(
                l10n.popularWorkouts,
                style: textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12),
              for (var i = 0; i < popular.length; i++) ...[
                if (i > 0) const SizedBox(height: 12),
                _WorkoutResultCard(workout: popular[i]),
              ],
            ],
          ],
        ],
      ),
    );
      },
    );
  }
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: selected ? AppColors.accentSoft : AppColors.surface,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeOutCubic,
          padding: EdgeInsets.fromLTRB(selected ? 10 : 14, 10, 14, 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: selected ? AppColors.accent : AppColors.border,
              width: selected ? 1.5 : 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedSize(
                duration: const Duration(milliseconds: 180),
                curve: Curves.easeOutCubic,
                child: selected
                    ? const Padding(
                        padding: EdgeInsets.only(right: 6),
                        child: Icon(
                          Icons.check_rounded,
                          size: 16,
                          color: AppColors.accent,
                        ),
                      )
                    : const SizedBox.shrink(),
              ),
              Text(
                label,
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: selected ? AppColors.accent : AppColors.textSecondary,
                  fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _WorkoutResultCard extends StatelessWidget {
  const _WorkoutResultCard({required this.workout});

  final WorkoutPlan workout;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final l10n = context.l10n;
    final locale = Localizations.localeOf(context);
    final title = workout.title.resolve(locale);
    final thumbnail = workout.exercises.isEmpty
        ? null
        : workout.exercises.first.exercise.imageAsset;

    return PgCard(
      onTap: () => context.push('/workout/${workout.id}'),
      padding: const EdgeInsets.all(12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (thumbnail != null)
            ExerciseImage(
              assetPath: thumbnail,
              width: 72,
              height: 72,
              borderRadius: 12,
              fit: BoxFit.cover,
            )
          else
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                color: AppColors.accentSoft,
                borderRadius: BorderRadius.circular(12),
              ),
              alignment: Alignment.center,
              child: const Icon(
                Icons.fitness_center_rounded,
                color: AppColors.accent,
              ),
            ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  l10n.workoutDurationExercises(
                    workout.durationMinutes,
                    l10n.exercisesCount(workout.exercises.length),
                  ),
                  style: textTheme.bodySmall?.copyWith(
                    color: AppColors.textTertiary,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    UserAvatar(name: workout.owner, size: 20),
                    const SizedBox(width: 6),
                    Flexible(
                      child: Text(
                        workout.owner,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: textTheme.bodySmall?.copyWith(
                          color: AppColors.textTertiary,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          IconButton(
            tooltip: AppStore.instance.isWorkoutPlanSaved(workout.id)
                ? l10n.unsaveWorkout
                : l10n.saveWorkout,
            onPressed: () async {
              final added = await AppStore.instance
                  .toggleSavedWorkoutPlan(workout.id);
              if (!context.mounted) return;
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    added
                        ? l10n.savedForLaterSnack
                        : l10n.removedFromSavedSnack,
                  ),
                ),
              );
            },
            icon: Icon(
              AppStore.instance.isWorkoutPlanSaved(workout.id)
                  ? Icons.bookmark_rounded
                  : Icons.bookmark_border_rounded,
              color: AppStore.instance.isWorkoutPlanSaved(workout.id)
                  ? AppColors.accent
                  : AppColors.textMuted,
            ),
          ),
        ],
      ),
    );
  }
}
