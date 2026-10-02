import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../data/exercise_preferences.dart';
import '../../data/mock_data.dart';
import '../../l10n/l10n_ext.dart';
import '../../theme/app_colors.dart';
import '../../widgets/pg_button.dart';

class WorkoutCompleteScreen extends StatefulWidget {
  const WorkoutCompleteScreen({super.key, required this.workoutId});

  final String workoutId;

  @override
  State<WorkoutCompleteScreen> createState() => _WorkoutCompleteScreenState();
}

class _WorkoutCompleteScreenState extends State<WorkoutCompleteScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scale;
  late bool _collectingSkipReasons;
  final Map<String, SkipReason> _draftReasons = {};

  @override
  void initState() {
    super.initState();
    _collectingSkipReasons = ExercisePreferences.hasSessionSkips;
    for (final id in ExercisePreferences.sessionSkippedExerciseIds) {
      final existing = ExercisePreferences.skipReasonFor(id);
      if (existing != null) _draftReasons[id] = existing;
    }
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _scale = CurvedAnimation(parent: _controller, curve: Curves.elasticOut);
    if (!_collectingSkipReasons) {
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool get _allReasonsSelected {
    final skipped = ExercisePreferences.sessionSkippedExerciseIds;
    return skipped.isNotEmpty &&
        skipped.every((id) => _draftReasons.containsKey(id));
  }

  void _finishSkipFeedback() {
    for (final entry in _draftReasons.entries) {
      ExercisePreferences.setSkipReason(entry.key, entry.value);
    }
    ExercisePreferences.clearSessionSkips();
    setState(() => _collectingSkipReasons = false);
    _controller.forward(from: 0);
  }

  void _goHome() {
    ExercisePreferences.clearSessionSkips();
    context.go('/home');
  }

  String _reasonLabel(AppLocalizations l10n, SkipReason reason) {
    return switch (reason) {
      SkipReason.tooHard => l10n.skipReasonTooHard,
      SkipReason.noEquipment => l10n.skipReasonNoEquipment,
      SkipReason.injured => l10n.skipReasonInjured,
      SkipReason.didntLike => l10n.skipReasonDidntLike,
      SkipReason.other => l10n.skipReasonOther,
    };
  }

  @override
  Widget build(BuildContext context) {
    if (_collectingSkipReasons) {
      return _buildSkipReasons(context);
    }
    return _buildCelebration(context);
  }

  Widget _buildSkipReasons(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final l10n = context.l10n;
    final locale = Localizations.localeOf(context);
    final skippedIds = ExercisePreferences.sessionSkippedExerciseIds;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.whyDidYouSkip,
                style: textTheme.headlineMedium,
              ),
              const SizedBox(height: 24),
              Expanded(
                child: ListView.separated(
                  itemCount: skippedIds.length,
                  separatorBuilder: (_, _) => const SizedBox(height: 16),
                  itemBuilder: (context, index) {
                    final id = skippedIds[index];
                    final exercise = MockData.exerciseById(id);
                    final name = exercise?.name.resolve(locale) ?? id;
                    final selected = _draftReasons[id];

                    return Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(name, style: textTheme.titleMedium),
                          const SizedBox(height: 12),
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: [
                              for (final reason in SkipReason.values)
                                _ReasonChip(
                                  label: _reasonLabel(l10n, reason),
                                  selected: selected == reason,
                                  onTap: () => setState(() {
                                    _draftReasons[id] = reason;
                                  }),
                                ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
              PgButton(
                label: l10n.onboardingContinue,
                onPressed: _allReasonsSelected ? _finishSkipFeedback : null,
              ),
              const SizedBox(height: 12),
              PgButton(
                label: l10n.skipFeedback,
                variant: PgButtonVariant.secondary,
                onPressed: _finishSkipFeedback,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCelebration(BuildContext context) {
    final workout =
        MockData.workoutById(widget.workoutId) ?? MockData.todaysWorkout;
    final textTheme = Theme.of(context).textTheme;
    final l10n = context.l10n;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
          child: Column(
            children: [
              const Spacer(),
              ScaleTransition(
                scale: _scale,
                child: Container(
                  width: 96,
                  height: 96,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.accentSoft,
                    border: Border.all(color: AppColors.accentMuted, width: 2),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.accent.withValues(alpha: 0.35),
                        blurRadius: 40,
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.celebration_rounded,
                    color: AppColors.accent,
                    size: 40,
                  ),
                ),
              ),
              const SizedBox(height: 28),
              Text(
                l10n.workoutComplete,
                textAlign: TextAlign.center,
                style: textTheme.headlineMedium,
              ),
              const SizedBox(height: 20),
              Text(
                l10n.minutesCount(workout.durationMinutes + 9),
                style: textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              Text(
                l10n.exercisesAndSets(workout.exercises.length, 23),
                style: textTheme.bodyLarge,
              ),
              const SizedBox(height: 28),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.border),
                ),
                child: Column(
                  children: [
                    Text(
                      l10n.xpGain(180),
                      style: textTheme.headlineSmall?.copyWith(
                        color: AppColors.accent,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      l10n.streakMaintained(MockData.streakDays),
                      style: textTheme.bodyMedium,
                    ),
                    if (ExercisePreferences.hasAnyFeedback) ...[
                      const SizedBox(height: 10),
                      Text(
                        l10n.personalizationUpdatedDemo,
                        textAlign: TextAlign.center,
                        style: textTheme.bodySmall?.copyWith(
                          color: AppColors.accent,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              const Spacer(),
              PgButton(
                label: l10n.share,
                variant: PgButtonVariant.secondary,
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(l10n.sharedToCommunityDemo)),
                  );
                },
              ),
              const SizedBox(height: 12),
              PgButton(
                label: l10n.done,
                onPressed: _goHome,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ReasonChip extends StatelessWidget {
  const _ReasonChip({
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
      color: selected ? AppColors.accentSoft : AppColors.surfaceElevated,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: selected ? AppColors.accent : AppColors.border,
              width: selected ? 1.5 : 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (selected) ...[
                const Icon(
                  Icons.check_rounded,
                  size: 16,
                  color: AppColors.accent,
                ),
                const SizedBox(width: 6),
              ],
              Text(
                label,
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color:
                          selected ? AppColors.accent : AppColors.textSecondary,
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
