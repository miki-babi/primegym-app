import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import '../../data/active_workout_controller.dart';
import '../../data/app_store.dart';
import '../../data/exercise_preferences.dart';
import '../../data/exercise_repository.dart';
import '../../data/mock_data.dart';
import '../../l10n/l10n_ext.dart';
import '../../theme/app_colors.dart';
import '../../widgets/pg_button.dart';
import '../../widgets/workout_share_actions.dart';
import '../../widgets/workout_share_card.dart';
import '../../widgets/workout_share_exporter.dart';
import '../../widgets/workout_share_stats.dart';

class WorkoutCompleteScreen extends StatefulWidget {
  const WorkoutCompleteScreen({super.key, required this.workoutId});

  final String workoutId;

  @override
  State<WorkoutCompleteScreen> createState() => _WorkoutCompleteScreenState();
}

class _WorkoutCompleteScreenState extends State<WorkoutCompleteScreen> {
  late bool _collectingSkipReasons;
  final Map<String, SkipReason> _draftReasons = {};
  final GlobalKey _cardKey = GlobalKey();
  File? _backgroundFile;
  bool _sharing = false;

  @override
  void initState() {
    super.initState();
    _collectingSkipReasons = ExercisePreferences.hasSessionSkips;
    for (final id in ExercisePreferences.sessionSkippedExerciseIds) {
      final existing = ExercisePreferences.skipReasonFor(id);
      if (existing != null) _draftReasons[id] = existing;
    }
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
  }

  void _goHome() {
    ExercisePreferences.clearSessionSkips();
    context.go('/home');
  }

  Future<void> _pickBackground() async {
    final picked = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 92,
    );
    if (picked == null || !mounted) return;
    setState(() => _backgroundFile = File(picked.path));
  }

  Future<void> _shareCard(String workoutTitle) async {
    if (_sharing) return;
    setState(() => _sharing = true);
    try {
      await exportAndShareWorkoutCard(
        boundaryKey: _cardKey,
        workoutTitle: workoutTitle,
      );
    } finally {
      if (mounted) setState(() => _sharing = false);
    }
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
                    final exercise = ExerciseRepository.instance.exerciseById(id);
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
        AppStore.instance.workoutPlanById(widget.workoutId) ??
            MockData.todaysWorkout;
    final l10n = context.l10n;
    final locale = Localizations.localeOf(context);
    final title = workout.title.resolve(locale);
    final stats = buildWorkoutShareStats(
      workout: workout,
      l10n: l10n,
      sessionWeightSum:
          ActiveWorkoutController.instance.lastCompletedWeightSum,
    );

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        fit: StackFit.expand,
        children: [
          WorkoutShareCard(
            boundaryKey: _cardKey,
            workoutTitle: title,
            stats: stats,
            backgroundFile: _backgroundFile,
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: WorkoutShareIconButton(
                      icon: Icons.close_rounded,
                      tooltip: l10n.done,
                      onPressed: _sharing ? null : _goHome,
                    ),
                  ),
                  const Spacer(),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        WorkoutShareIconButton(
                          icon: Icons.image_outlined,
                          tooltip: l10n.changeBackground,
                          onPressed: _sharing ? null : _pickBackground,
                        ),
                        const SizedBox(width: 12),
                        WorkoutShareIconButton(
                          icon: Icons.ios_share_rounded,
                          tooltip: l10n.share,
                          emphasized: true,
                          onPressed:
                              _sharing ? null : () => _shareCard(title),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
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
