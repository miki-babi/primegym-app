import 'dart:ui';

import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class ScrollEdgeHint extends StatelessWidget {
  const ScrollEdgeHint({super.key});

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 24,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.background.withValues(alpha: 0),
                  AppColors.background.withValues(alpha: 0.72),
                ],
              ),
            ),
          ),
          const Center(child: GlassyChevron()),
        ],
      ),
    );
  }
}

class GlassyChevron extends StatelessWidget {
  const GlassyChevron({super.key});

  @override
  Widget build(BuildContext context) {
    return const GlassyCircleButton(
      icon: Icons.chevron_right_rounded,
      size: 32,
      iconSize: 18,
    );
  }
}

class GlassyCircleButton extends StatelessWidget {
  const GlassyCircleButton({
    super.key,
    required this.icon,
    this.onTap,
    this.size = 36,
    this.iconSize = 20,
  });

  final IconData icon;
  final VoidCallback? onTap;
  final double size;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    final button = ClipOval(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
        child: DecoratedBox(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white.withValues(alpha: 0.1),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.16),
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.background.withValues(alpha: 0.35),
                blurRadius: 10,
              ),
            ],
          ),
          child: SizedBox(
            width: size,
            height: size,
            child: Icon(
              icon,
              size: iconSize,
              color: AppColors.textSecondary,
            ),
          ),
        ),
      ),
    );

    if (onTap == null) return button;

    return Material(
      color: Colors.transparent,
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: button,
      ),
    );
  }
}
