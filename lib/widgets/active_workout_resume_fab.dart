import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

import '../data/active_workout_controller.dart';
import '../l10n/l10n_ext.dart';
import '../theme/app_colors.dart';

/// Root overlay FAB that reopens a minimized active workout.
class ActiveWorkoutResumeFab extends StatelessWidget {
  const ActiveWorkoutResumeFab({super.key, required this.router});

  final GoRouter router;

  bool _shouldShow(String path) {
    final session = ActiveWorkoutController.instance;
    if (!session.isActive) return false;
    if (path.startsWith('/onboarding')) return false;
    if (path.endsWith('/active')) return false;
    if (path.endsWith('/complete')) return false;
    return true;
  }

  String _currentPath() {
    try {
      return router.state.uri.path;
    } catch (_) {
      return router.routeInformationProvider.value.uri.path;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: Listenable.merge([
        ActiveWorkoutController.instance,
        router.routerDelegate,
      ]),
      builder: (context, _) {
        final path = _currentPath();
        if (!_shouldShow(path)) {
          return const SizedBox.shrink();
        }

        final location = ActiveWorkoutController.instance.resumeLocation;
        if (location == null) return const SizedBox.shrink();

        final l10n = context.l10n;
        final bottomInset = MediaQuery.paddingOf(context).bottom;

        return Positioned(
          right: 20,
          bottom: bottomInset + 88,
          child: FloatingActionButton.extended(
            heroTag: 'active-workout-resume-fab',
            backgroundColor: AppColors.accent,
            foregroundColor: AppColors.onAccent,
            elevation: 6,
            onPressed: () {
              HapticFeedback.selectionClick();
              router.push(location);
            },
            icon: const Icon(Icons.fitness_center_rounded),
            label: Text(
              l10n.resumeWorkout,
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
          ),
        );
      },
    );
  }
}
