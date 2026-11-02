import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../data/active_workout_controller.dart';
import '../../data/app_store.dart';
import '../../data/mock_data.dart';
import '../../l10n/l10n_ext.dart';
import '../../theme/app_colors.dart';
import '../../widgets/workout_share_actions.dart';
import '../../widgets/workout_share_card.dart';
import '../../widgets/workout_share_exporter.dart';
import '../../widgets/workout_share_stats.dart';

class WorkoutShareScreen extends StatefulWidget {
  const WorkoutShareScreen({super.key, required this.workoutId});

  final String workoutId;

  @override
  State<WorkoutShareScreen> createState() => _WorkoutShareScreenState();
}

class _WorkoutShareScreenState extends State<WorkoutShareScreen> {
  final GlobalKey _cardKey = GlobalKey();
  File? _backgroundFile;
  bool _sharing = false;

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

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final locale = Localizations.localeOf(context);
    final workout =
        AppStore.instance.workoutPlanById(widget.workoutId) ??
            MockData.todaysWorkout;
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
                      icon: Icons.arrow_back_rounded,
                      tooltip: MaterialLocalizations.of(context).backButtonTooltip,
                      onPressed: _sharing ? null : () => Navigator.of(context).maybePop(),
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
