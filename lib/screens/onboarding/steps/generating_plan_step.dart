import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../l10n/l10n_ext.dart';
import '../../../theme/app_colors.dart';

class GeneratingPlanStep extends StatefulWidget {
  const GeneratingPlanStep({
    super.key,
    required this.onComplete,
  });

  final VoidCallback onComplete;

  @override
  State<GeneratingPlanStep> createState() => _GeneratingPlanStepState();
}

class _GeneratingPlanStepState extends State<GeneratingPlanStep>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ring;
  int _visibleSteps = 0;
  Timer? _stepTimer;
  bool _finished = false;

  static const _stepCount = 4;
  static const _stepInterval = Duration(milliseconds: 550);
  static const _finishDelay = Duration(milliseconds: 700);

  @override
  void initState() {
    super.initState();
    _ring = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2400),
    )..forward();
    _scheduleSteps();
  }

  void _scheduleSteps() {
    _stepTimer = Timer.periodic(_stepInterval, (timer) {
      if (!mounted) return;
      if (_visibleSteps < _stepCount) {
        setState(() => _visibleSteps++);
        HapticFeedback.selectionClick();
      }
      if (_visibleSteps >= _stepCount) {
        timer.cancel();
        Future<void>.delayed(_finishDelay, () {
          if (!mounted || _finished) return;
          _finished = true;
          HapticFeedback.mediumImpact();
          widget.onComplete();
        });
      }
    });
  }

  @override
  void dispose() {
    _stepTimer?.cancel();
    _ring.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final l10n = context.l10n;
    final steps = [
      l10n.onboardingGeneratingStepGoal,
      l10n.onboardingGeneratingStepSchedule,
      l10n.onboardingGeneratingStepEquipment,
      l10n.onboardingGeneratingStepReady,
    ];

    return Column(
      children: [
        const Spacer(flex: 2),
        AnimatedBuilder(
          animation: _ring,
          builder: (context, child) {
            return SizedBox(
              width: 96,
              height: 96,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 96,
                    height: 96,
                    child: CircularProgressIndicator(
                      value: _ring.value,
                      strokeWidth: 4,
                      backgroundColor: Colors.white.withValues(alpha: 0.12),
                      color: AppColors.accent,
                    ),
                  ),
                  Container(
                    width: 72,
                    height: 72,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.accentSoft,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.accent.withValues(alpha: 0.28),
                          blurRadius: 24,
                        ),
                      ],
                    ),
                    child: Icon(
                      _visibleSteps >= _stepCount
                          ? Icons.check_rounded
                          : Icons.fitness_center_rounded,
                      color: AppColors.accent,
                      size: 32,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        const SizedBox(height: 32),
        Text(
          l10n.onboardingGeneratingTitle,
          textAlign: TextAlign.center,
          style: textTheme.headlineSmall?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            height: 1.2,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          l10n.onboardingGeneratingSubtitle,
          textAlign: TextAlign.center,
          style: textTheme.bodyMedium?.copyWith(
            color: Colors.white.withValues(alpha: 0.72),
            height: 1.35,
          ),
        ),
        const SizedBox(height: 36),
        for (var i = 0; i < steps.length; i++) ...[
          if (i > 0) const SizedBox(height: 12),
          AnimatedOpacity(
            duration: const Duration(milliseconds: 280),
            opacity: i < _visibleSteps ? 1 : 0.28,
            child: Row(
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 280),
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: i < _visibleSteps
                        ? AppColors.accent
                        : Colors.white.withValues(alpha: 0.08),
                    border: Border.all(
                      color: i < _visibleSteps
                          ? AppColors.accent
                          : Colors.white.withValues(alpha: 0.2),
                    ),
                  ),
                  child: i < _visibleSteps
                      ? const Icon(
                          Icons.check_rounded,
                          size: 16,
                          color: AppColors.onAccent,
                        )
                      : null,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    steps[i],
                    style: textTheme.bodyMedium?.copyWith(
                      color: i < _visibleSteps
                          ? Colors.white
                          : Colors.white.withValues(alpha: 0.45),
                      fontWeight: i < _visibleSteps
                          ? FontWeight.w600
                          : FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
        const Spacer(flex: 3),
      ],
    );
  }
}
