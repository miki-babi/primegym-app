import 'package:flutter/material.dart';

abstract final class AppColors {
  /// Black — primary background (app, nav, workout screens).
  static const Color background = Color(0xFF000000);

  /// Black 88% — surface (cards, sheets, inputs, secondary sections).
  static const Color surface = Color(0xFF1F1F1F);
  static const Color surfaceElevated = Color(0xFF1F1F1F);
  static const Color border = Color(0xFF2E2E2E);

  /// Fit Green — primary accent (buttons, selected, active nav, CTAs).
  static const Color accent = Color(0xFFAFFA01);
  static const Color accentSoft = Color(0x1AAFFA01);
  static const Color accentMuted = Color(0x33AFFA01);
  static const Color onAccent = Color(0xFF000000);

  /// Supporting accent (progress, stats, badges, highlights).
  static const Color accentSupport = Color(0xFFD7F457);

  /// Alias used by existing gradients / highlight call sites.
  static const Color accentLight = Color(0xFFC5FF4D);

  /// White — text and contrast on dark backgrounds.
  static const Color textPrimary = Color(0xFFF5F5F5);
  static const Color textSecondary = Color(0xCCF5F5F5);
  static const Color textTertiary = Color(0x99F5F5F5);
  static const Color textMuted = Color(0x66F5F5F5);

  static const Color success = Color(0xFFAFFA01);
  static const Color successSoft = Color(0x1AAFFA01);
  static const Color danger = Color(0xFFFF6B6B);
  static const Color online = Color(0xFFAFFA01);

  static const Color progressTrack = Color(0xFF2E2E2E);
  static const Color progressFill = accentSupport;
}
