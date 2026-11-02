import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// Floating circular icon button for share-card chrome (outside capture).
class WorkoutShareIconButton extends StatelessWidget {
  const WorkoutShareIconButton({
    super.key,
    required this.icon,
    required this.tooltip,
    required this.onPressed,
    this.emphasized = false,
  });

  final IconData icon;
  final String tooltip;
  final VoidCallback? onPressed;
  final bool emphasized;

  @override
  Widget build(BuildContext context) {
    final enabled = onPressed != null;
    return Tooltip(
      message: tooltip,
      child: Material(
        color: emphasized
            ? AppColors.accent.withValues(alpha: enabled ? 1 : 0.4)
            : Colors.black.withValues(alpha: enabled ? 0.45 : 0.25),
        shape: const CircleBorder(),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onPressed,
          customBorder: const CircleBorder(),
          child: Ink(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: emphasized
                    ? Colors.black.withValues(alpha: 0.2)
                    : Colors.white.withValues(alpha: 0.22),
              ),
            ),
            child: Icon(
              icon,
              size: 24,
              color: emphasized
                  ? Colors.black.withValues(alpha: enabled ? 1 : 0.5)
                  : Colors.white.withValues(alpha: enabled ? 1 : 0.5),
            ),
          ),
        ),
      ),
    );
  }
}
