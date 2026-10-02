import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class PgProgressBar extends StatelessWidget {
  const PgProgressBar({
    super.key,
    required this.value,
    this.height = 8,
  });

  final double value;
  final double height;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(height),
      child: LinearProgressIndicator(
        value: value.clamp(0.0, 1.0),
        minHeight: height,
        backgroundColor: AppColors.progressTrack,
        color: AppColors.accent,
      ),
    );
  }
}
