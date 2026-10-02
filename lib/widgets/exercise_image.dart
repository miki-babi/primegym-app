import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class ExerciseImage extends StatelessWidget {
  const ExerciseImage({
    super.key,
    required this.assetPath,
    this.borderRadius = 14,
    this.fit = BoxFit.cover,
    this.width,
    this.height,
  });

  final String assetPath;
  final double borderRadius;
  final BoxFit fit;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: SizedBox(
        width: width,
        height: height,
        child: Image.asset(
          assetPath,
          fit: fit,
          width: width,
          height: height,
          errorBuilder: (context, error, stackTrace) => Container(
            width: width,
            height: height,
            color: AppColors.accentSoft,
            alignment: Alignment.center,
            child: const Icon(
              Icons.fitness_center_rounded,
              color: AppColors.accent,
            ),
          ),
        ),
      ),
    );
  }
}
