import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

import '../../data/active_workout_controller.dart';
import '../../data/app_store.dart';
import '../../data/exercise_illustrations.dart';
import '../../data/exercise_preferences.dart';
import '../../data/exercise_repository.dart';
import '../../data/mock_data.dart';
import '../../l10n/l10n_ext.dart';
import '../../l10n/localized_string.dart';
import '../../models/models.dart';
import '../../theme/app_colors.dart';
import '../../widgets/exercise_fullscreen_viewer.dart';
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
      AppStore.instance.workoutPlanById(widget.workoutId) ??
          MockData.todaysWorkout;
  int exerciseIndex = 0;
  int setIndex = 0;
  late double weight;
  late int reps;
  bool setJustCompleted = false;

  ActiveWorkoutController get _session => ActiveWorkoutController.instance;

  List<WorkoutExercise> get _sessionExercises {
    final base = workout.exercises;
    final seen = {for (final e in base) e.exercise.id};
    final extras = <WorkoutExercise>[];
    for (final id in _session.queuedExerciseIds) {
      if (seen.contains(id)) continue;
      final item = ExerciseRepository.instance.exerciseById(id);
      if (item == null) continue;
      extras.add(
        WorkoutExercise(
          exercise: item,
          sets: 3,
          reps: 10,
          weightKg: 20,
        ),
      );
      seen.add(id);
    }
    return [...base, ...extras];
  }

  @override
  void initState() {
    super.initState();
    final exercises = _sessionExercises;
    if (exercises.isEmpty) {
      weight = 0;
      reps = 0;
      return;
    }
    final first = exercises.first;
    if (_session.isSessionFor(workout.id)) {
      exerciseIndex = _session.exerciseIndex.clamp(0, exercises.length - 1);
      final current = exercises[exerciseIndex];
      setIndex = _session.setIndex.clamp(0, current.sets - 1);
      weight = _session.weight;
      reps = _session.reps;
    } else {
      ExercisePreferences.clearSessionSkips();
      weight = first.weightKg;
      reps = first.reps;
      _session.start(
        workoutId: workout.id,
        weight: weight,
        reps: reps,
      );
    }
  }

  void _syncSession() {
    _session.sync(
      exerciseIndex: exerciseIndex,
      setIndex: setIndex,
      weight: weight,
      reps: reps,
    );
  }

  void _finishWorkout() {
    _session.clear();
    context.go('/workout/${workout.id}/complete');
  }

  String get _currentExerciseId =>
      _sessionExercises[exerciseIndex].exercise.id;

  void _loadExercise(int index) {
    final exercise = _sessionExercises[index];
    exerciseIndex = index;
    setIndex = 0;
    weight = exercise.weightKg;
    reps = exercise.reps;
    setJustCompleted = false;
    _syncSession();
  }

  void _advanceExercise() {
    if (exerciseIndex + 1 < _sessionExercises.length) {
      setState(() => _loadExercise(exerciseIndex + 1));
      return;
    }
    _finishWorkout();
  }

  void _skipExercise() {
    HapticFeedback.lightImpact();
    ExercisePreferences.recordSessionSkip(_currentExerciseId);
    _advanceExercise();
  }

  void _completeSet() {
    HapticFeedback.mediumImpact();
    _session.recordCompletedSetWeight(weight);
    setState(() => setJustCompleted = true);

    Future<void>.delayed(const Duration(milliseconds: 450), () {
      if (!mounted) return;
      setState(() => setJustCompleted = false);

      final current = _sessionExercises[exerciseIndex];
      if (setIndex + 1 < current.sets) {
        setState(() {
          setIndex++;
          _syncSession();
        });
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
    setState(() {
      weight = next.clamp(0.5, 500);
      _syncSession();
    });
  }

  Future<void> _editReps() async {
    final l10n = context.l10n;
    final next = await _promptNumber(
      title: l10n.labelReps,
      initial: '$reps',
      decimal: false,
    );
    if (next == null || !mounted) return;
    setState(() {
      reps = next.round().clamp(1, 100);
      _syncSession();
    });
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
    return ListenableBuilder(
      listenable: _session,
      builder: (context, _) {
        final exercises = _sessionExercises;
        if (exercises.isEmpty) {
          return Scaffold(
            appBar: AppBar(),
            body: const Center(child: Text('No exercises in this workout')),
          );
        }
        final safeIndex = exerciseIndex.clamp(0, exercises.length - 1);
        if (safeIndex != exerciseIndex) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (!mounted) return;
            setState(() => _loadExercise(safeIndex));
          });
        }
        final current = exercises[safeIndex];
        final textTheme = Theme.of(context).textTheme;
        final l10n = context.l10n;
        final previousWeight =
            (current.weightKg - 5).clamp(0, current.weightKg).toDouble();
        final previousReps = (current.reps - 1).clamp(1, current.reps);

        return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.keyboard_arrow_down_rounded),
          onPressed: () {
            _syncSession();
            context.pop();
          },
        ),
        title: Text(
          l10n.exerciseProgress(safeIndex + 1, exercises.length),
          style: textTheme.titleMedium,
        ),
        actions: [
          TextButton(
            onPressed: _finishWorkout,
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
                      Stack(
                        children: [
                          ExerciseIllustrationVideo(
                            assetPath: current.exercise.animationPath ??
                                ExerciseIllustrations.forExercise(
                                  current.exercise.id,
                                  current.exercise.muscle.en,
                                ),
                            isFile: current.exercise.animationIsFile,
                            fallbackImageAsset: current.exercise.imageAsset,
                            fallbackIsFile: current.exercise.imageIsFile,
                            width: 200,
                            height: 148,
                            borderRadius: 20,
                            onTap: () => _showHowTo(current.exercise),
                          ),
                          Positioned(
                            right: 6,
                            bottom: 6,
                            child: GestureDetector(
                              onTap: () => ExerciseFullscreenViewer.show(
                                context,
                                path: current.exercise.animationPath ??
                                    current.exercise.imageAsset,
                                isFile:
                                    current.exercise.animationPath != null
                                        ? current.exercise.animationIsFile
                                        : current.exercise.imageIsFile,
                              ),
                              child: Container(
                                width: 32,
                                height: 32,
                                decoration: BoxDecoration(
                                  color: Colors.black.withValues(alpha: 0.45),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.fullscreen_rounded,
                                  size: 18,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
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
                                      weight = (weight - 2.5).clamp(0.5, 500);
                                      _syncSession();
                                    }),
                                    onIncrement: () => setState(() {
                                      weight = (weight + 2.5).clamp(0.5, 500);
                                      _syncSession();
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
                                      _syncSession();
                                    }),
                                    onIncrement: () => setState(() {
                                      reps = (reps + 1).clamp(1, 100);
                                      _syncSession();
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
      },
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
              child: GestureDetector(
                onTap: () => ExerciseFullscreenViewer.show(
                  context,
                  path: exercise.animationPath ?? exercise.imageAsset,
                  isFile: exercise.animationPath != null
                      ? exercise.animationIsFile
                      : exercise.imageIsFile,
                ),
                child: ExerciseImage(
                  assetPath: exercise.imageAsset,
                  isFile: exercise.imageIsFile,
                  width: double.infinity,
                  height: double.infinity,
                  borderRadius: 0,
                ),
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
          if (context.l10nStr(exercise.commonMistakes).isNotEmpty) ...[
            Text(l10n.commonMistakesTitle, style: textTheme.titleMedium),
            const SizedBox(height: 8),
            Text(
              context.l10nStr(exercise.commonMistakes),
              style: textTheme.bodyMedium,
            ),
          ],
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
