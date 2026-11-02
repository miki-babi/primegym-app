import 'dart:io';

import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class WorkoutShareStat {
  const WorkoutShareStat({required this.label, required this.value});

  final String label;
  final String value;
}

/// Full-bleed Strava-style share card for a completed workout.
class WorkoutShareCard extends StatelessWidget {
  const WorkoutShareCard({
    super.key,
    required this.boundaryKey,
    required this.workoutTitle,
    required this.stats,
    this.backgroundFile,
    this.brandLabel = 'PRIMEGYM',
    this.appLabel = 'PrimeGym',
  });

  static const defaultBackgroundAsset = 'assets/images/share/image.png';

  final GlobalKey boundaryKey;
  final String workoutTitle;
  final List<WorkoutShareStat> stats;
  final File? backgroundFile;
  final String brandLabel;
  final String appLabel;

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      key: boundaryKey,
      child: SizedBox.expand(
        child: Stack(
          fit: StackFit.expand,
          children: [
            _Background(file: backgroundFile),
            const DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0x66000000),
                    Color(0x99000000),
                    Color(0xCC000000),
                  ],
                  stops: [0.0, 0.4, 1.0],
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: SafeArea(
                    bottom: false,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(24, 64, 24, 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            appLabel.toUpperCase(),
                            style: const TextStyle(
                              color: AppColors.accent,
                              fontWeight: FontWeight.w700,
                              fontSize: 12,
                              letterSpacing: 1.4,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            workoutTitle,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w800,
                              fontSize: 32,
                              height: 1.15,
                              letterSpacing: -0.4,
                            ),
                          ),
                          const SizedBox(height: 28),
                          Expanded(
                            child: SingleChildScrollView(
                              physics: const NeverScrollableScrollPhysics(),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  for (var i = 0; i < stats.length; i++) ...[
                                    if (i > 0) const SizedBox(height: 20),
                                    Text(
                                      stats[i].label,
                                      style: TextStyle(
                                        color: Colors.white.withValues(
                                          alpha: 0.78,
                                        ),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 13,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      stats[i].value,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w800,
                                        fontSize: 36,
                                        height: 1.05,
                                        letterSpacing: -0.6,
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                _BrandFooter(label: brandLabel),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _Background extends StatelessWidget {
  const _Background({this.file});

  final File? file;

  @override
  Widget build(BuildContext context) {
    if (file != null) {
      return Image.file(
        file!,
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
      );
    }
    return Image.asset(
      WorkoutShareCard.defaultBackgroundAsset,
      fit: BoxFit.cover,
      width: double.infinity,
      height: double.infinity,
    );
  }
}

class _BrandFooter extends StatelessWidget {
  const _BrandFooter({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.accent,
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 14),
          child: Text(
            '$label  ·  $label  ·  $label',
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.clip,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w800,
              fontSize: 13,
              letterSpacing: 1.6,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
      ),
    );
  }
}
