import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

import '../../data/exercise_illustrations.dart';
import '../../data/exercise_preferences.dart';
import '../../data/mock_data.dart';
import '../../l10n/l10n_ext.dart';
import '../../l10n/localized_string.dart';
import '../../models/models.dart';
import '../../theme/app_colors.dart';
import '../../widgets/exercise_image.dart';
import '../../widgets/exercise_illustration_video.dart';
import '../../widgets/exercise_youtube_player.dart';
import '../../widgets/pg_button.dart';
import '../../widgets/scroll_edge_hint.dart';

class ActiveWorkoutScreen extends StatefulWidget {
  const ActiveWorkoutScreen({super.key, required this.workoutId});

  final String workoutId;

  @override
  State<ActiveWorkoutScreen> createState() => _ActiveWorkoutScreenState();
}

class _ActiveWorkoutScreenState extends State<ActiveWorkoutScreen> {
  late final workout =
      MockData.workoutById(widget.workoutId) ?? MockData.todaysWorkout;
  int exerciseIndex = 0;
  int setIndex = 0;
  late double weight;
  late int reps;
  bool setJustCompleted = false;

  @override
  void initState() {
    super.initState();
    ExercisePreferences.clearSessionSkips();
    final first = workout.exercises.first;
    weight = first.weightKg;
    reps = first.reps;
  }

  String get _currentExerciseId =>
      workout.exercises[exerciseIndex].exercise.id;

  void _loadExercise(int index) {
    final exercise = workout.exercises[index];
    exerciseIndex = index;
    setIndex = 0;
    weight = exercise.weightKg;
    reps = exercise.reps;
    setJustCompleted = false;
  }

  void _advanceExercise() {
    if (exerciseIndex + 1 < workout.exercises.length) {
      setState(() => _loadExercise(exerciseIndex + 1));
      return;
    }
    context.go('/workout/${workout.id}/complete');
  }

  void _skipExercise() {
    HapticFeedback.lightImpact();
    ExercisePreferences.recordSessionSkip(_currentExerciseId);
    _advanceExercise();
  }

  void _completeSet() {
    HapticFeedback.mediumImpact();
    setState(() => setJustCompleted = true);

    Future<void>.delayed(const Duration(milliseconds: 450), () {
      if (!mounted) return;
      setState(() => setJustCompleted = false);

      final current = workout.exercises[exerciseIndex];
      if (setIndex + 1 < current.sets) {
        setState(() => setIndex++);
        return;
      }
      _advanceExercise();
    });
  }

  void _showHowTo(ExerciseItem exercise) {
    HapticFeedback.selectionClick();
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => _ExerciseHowToSheet(exercise: exercise),
    );
  }

  String _formatWeight(double value) {
    return value.toStringAsFixed(value % 1 == 0 ? 0 : 1);
  }

  Future<void> _editWeight() async {
    final l10n = context.l10n;
    final next = await _promptNumber(
      title: l10n.labelWeight,
      initial: _formatWeight(weight),
      decimal: true,
    );
    if (next == null || !mounted) return;
    setState(() => weight = next.clamp(0, 500));
  }

  Future<void> _editReps() async {
    final l10n = context.l10n;
    final next = await _promptNumber(
      title: l10n.labelReps,
      initial: '$reps',
      decimal: false,
    );
    if (next == null || !mounted) return;
    setState(() => reps = next.round().clamp(1, 100));
  }

  Future<double?> _promptNumber({
    required String title,
    required String initial,
    required bool decimal,
  }) {
    return showDialog<double>(
      context: context,
      builder: (context) => _NumberEditDialog(
        title: title,
        initial: initial,
        decimal: decimal,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final current = workout.exercises[exerciseIndex];
    final textTheme = Theme.of(context).textTheme;
    final l10n = context.l10n;
    final previousWeight =
        (current.weightKg - 5).clamp(0, current.weightKg).toDouble();
    final previousReps = (current.reps - 1).clamp(1, current.reps);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close_rounded),
          onPressed: () => context.pop(),
        ),
        title: Text(
          l10n.exerciseProgress(exerciseIndex + 1, workout.exercises.length),
          style: textTheme.titleMedium,
        ),
        actions: [
          TextButton(
            onPressed: () => context.go('/workout/${workout.id}/complete'),
            child: Text(l10n.finish),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 8, 24, 16),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 8),
                      ExerciseIllustrationVideo(
                        assetPath: ExerciseIllustrations.forExercise(
                          current.exercise.id,
                          current.exercise.muscle.en,
                        ),
                        fallbackImageAsset: current.exercise.imageAsset,
                        width: 200,
                        height: 148,
                        borderRadius: 20,
                        onTap: () => _showHowTo(current.exercise),
                      ),
                      const SizedBox(height: 8),
                      TextButton.icon(
                        onPressed: () => _showHowTo(current.exercise),
                        icon: const Icon(
                          Icons.play_circle_outline_rounded,
                          size: 20,
                          color: AppColors.accent,
                        ),
                        label: Text(
                          l10n.howToDoThis,
                          style: textTheme.labelLarge?.copyWith(
                            color: AppColors.accent,
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      AnimatedScale(
                        scale: setJustCompleted ? 1.04 : 1,
                        duration: const Duration(milliseconds: 250),
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () => _showHowTo(current.exercise),
                              child: Text(
                                context.l10nStr(current.exercise.name),
                                textAlign: TextAlign.center,
                                style: textTheme.headlineMedium,
                              ),
                            ),
                            const SizedBox(height: 20),
                            Text(
                              l10n.setProgress(setIndex + 1, current.sets),
                              style: textTheme.titleLarge?.copyWith(
                                color: AppColors.textTertiary,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              l10n.previousSet(
                                l10n.weightKg(previousWeight.toInt()),
                                '$previousReps',
                              ),
                              style: textTheme.bodyMedium,
                            ),
                            const SizedBox(height: 24),
                            Row(
                              children: [
                                Expanded(
                                  child: _MetricStepper(
                                    label: l10n.labelWeight,
                                    value: l10n.weightKg(
                                      num.parse(_formatWeight(weight)),
                                    ),
                                    chevronSide: _ChevronSide.left,
                                    onDecrement: () => setState(() {
                                      weight = (weight - 2.5).clamp(0, 500);
                                    }),
                                    onIncrement: () => setState(() {
                                      weight = (weight + 2.5).clamp(0, 500);
                                    }),
                                    onEdit: _editWeight,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 20),
                                  child: Text(
                                    '×',
                                    style: textTheme.headlineMedium?.copyWith(
                                      color: AppColors.textMuted,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: _MetricStepper(
                                    label: l10n.labelReps,
                                    value: '$reps',
                                    chevronSide: _ChevronSide.right,
                                    onDecrement: () => setState(() {
                                      reps = (reps - 1).clamp(1, 100);
                                    }),
                                    onIncrement: () => setState(() {
                                      reps = (reps + 1).clamp(1, 100);
                                    }),
                                    onEdit: _editReps,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: PgButton(
                      label: l10n.skipExercise,
                      variant: PgButtonVariant.secondary,
                      height: 64,
                      onPressed: setJustCompleted ? null : _skipExercise,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    flex: 2,
                    child: PgButton(
                      label: setJustCompleted ? l10n.nice : l10n.completeSet,
                      height: 64,
                      onPressed: setJustCompleted ? null : _completeSet,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

enum _ChevronSide { left, right }

class _MetricStepper extends StatelessWidget {
  const _MetricStepper({
    required this.label,
    required this.value,
    required this.chevronSide,
    required this.onDecrement,
    required this.onIncrement,
    required this.onEdit,
  });

  final String label;
  final String value;
  final _ChevronSide chevronSide;
  final VoidCallback onDecrement;
  final VoidCallback onIncrement;
  final VoidCallback onEdit;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    final chevrons = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GlassyCircleButton(
          icon: Icons.keyboard_arrow_up_rounded,
          onTap: onIncrement,
        ),
        const SizedBox(height: 8),
        GlassyCircleButton(
          icon: Icons.keyboard_arrow_down_rounded,
          onTap: onDecrement,
        ),
      ],
    );

    final valueField = Expanded(
      child: Material(
        color: AppColors.surfaceElevated,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          onTap: onEdit,
          borderRadius: BorderRadius.circular(16),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 28),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.border),
            ),
            child: Text(
              value,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w700,
                fontFeatures: const [FontFeature.tabularFigures()],
              ),
            ),
          ),
        ),
      ),
    );

    return Column(
      children: [
        Text(
          label,
          style: textTheme.labelMedium?.copyWith(
            color: AppColors.textTertiary,
            letterSpacing: 0.4,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            if (chevronSide == _ChevronSide.left) ...[
              chevrons,
              const SizedBox(width: 4),
            ],
            valueField,
            if (chevronSide == _ChevronSide.right) ...[
              const SizedBox(width: 4),
              chevrons,
            ],
          ],
        ),
      ],
    );
  }
}

class _NumberEditDialog extends StatefulWidget {
  const _NumberEditDialog({
    required this.title,
    required this.initial,
    required this.decimal,
  });

  final String title;
  final String initial;
  final bool decimal;

  @override
  State<_NumberEditDialog> createState() => _NumberEditDialogState();
}

class _NumberEditDialogState extends State<_NumberEditDialog> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initial);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _submit() {
    final parsed = double.tryParse(_controller.text.trim());
    if (parsed == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.l10n.enterValidWeightKg)),
      );
      return;
    }
    Navigator.of(context).pop(parsed);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return AlertDialog(
      backgroundColor: AppColors.surface,
      title: Text(widget.title),
      content: TextField(
        controller: _controller,
        autofocus: true,
        keyboardType: TextInputType.numberWithOptions(decimal: widget.decimal),
        inputFormatters: [
          if (widget.decimal)
            FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))
          else
            FilteringTextInputFormatter.digitsOnly,
        ],
        style: Theme.of(context).textTheme.headlineSmall,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          hintText: widget.initial,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onSubmitted: (_) => _submit(),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(l10n.cancel),
        ),
        TextButton(
          onPressed: _submit,
          child: Text(l10n.done),
        ),
      ],
    );
  }
}

class _ExerciseHowToSheet extends StatelessWidget {
  const _ExerciseHowToSheet({required this.exercise});

  final ExerciseItem exercise;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final textTheme = Theme.of(context).textTheme;
    final height = MediaQuery.sizeOf(context).height * 0.85;

    return SizedBox(
      height: height,
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.border,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            context.l10nStr(exercise.name),
            style: textTheme.headlineSmall,
          ),
          const SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(18),
            child: AspectRatio(
              aspectRatio: 16 / 10,
              child: ExerciseImage(
                assetPath: exercise.imageAsset,
                width: double.infinity,
                height: double.infinity,
                borderRadius: 0,
              ),
            ),
          ),
          const SizedBox(height: 16),
          if (exercise.youtubeVideoId.isNotEmpty)
            ExerciseYoutubePlayer(videoId: exercise.youtubeVideoId),
          const SizedBox(height: 24),
          Text(l10n.formTipsTitle, style: textTheme.titleMedium),
          const SizedBox(height: 8),
          Text(
            context.l10nStr(exercise.instructions),
            style: textTheme.bodyLarge,
          ),
          const SizedBox(height: 20),
          Text(l10n.commonMistakesTitle, style: textTheme.titleMedium),
          const SizedBox(height: 8),
          Text(
            context.l10nStr(exercise.commonMistakes),
            style: textTheme.bodyMedium,
          ),
          const SizedBox(height: 24),
          PgButton(
            label: l10n.viewDetails,
            variant: PgButtonVariant.secondary,
            onPressed: () {
              Navigator.of(context).pop();
              context.push('/exercise/${exercise.id}');
            },
          ),
        ],
      ),
    );
  }
}
