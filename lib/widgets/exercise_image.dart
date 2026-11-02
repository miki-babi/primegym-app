import 'dart:io';

import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class ExerciseImage extends StatelessWidget {
  const ExerciseImage({
    super.key,
    required this.assetPath,
    this.isFile = false,
    this.borderRadius = 14,
    this.fit = BoxFit.cover,
    this.width,
    this.height,
  });

  final String assetPath;
  final bool isFile;
  final double borderRadius;
  final BoxFit fit;
  final double? width;
  final double? height;

  bool get _useFile {
    if (isFile) return true;
    if (assetPath.startsWith('assets/')) return false;
    if (assetPath.startsWith('http://') || assetPath.startsWith('https://')) {
      return false;
    }
    return assetPath.contains('/') || assetPath.contains('\\');
  }

  @override
  Widget build(BuildContext context) {
    final Widget image;
    if (_useFile) {
      image = Image.file(
        File(assetPath),
        fit: fit,
        width: width,
        height: height,
        errorBuilder: _error,
      );
    } else if (assetPath.startsWith('http://') ||
        assetPath.startsWith('https://')) {
      image = Image.network(
        assetPath,
        fit: fit,
        width: width,
        height: height,
        errorBuilder: _error,
      );
    } else {
      image = Image.asset(
        assetPath,
        fit: fit,
        width: width,
        height: height,
        errorBuilder: _error,
      );
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: SizedBox(width: width, height: height, child: image),
    );
  }

  Widget _error(BuildContext context, Object error, StackTrace? stackTrace) {
    return Container(
      width: width,
      height: height,
      color: AppColors.accentSoft,
      alignment: Alignment.center,
      child: const Icon(
        Icons.fitness_center_rounded,
        color: AppColors.accent,
      ),
    );
  }
}
