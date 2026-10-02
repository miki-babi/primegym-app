import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

abstract final class AppTypography {
  /// Latin primary face with Ethiopic fallback for Amharic (and any Ge'ez text).
  /// Afaan Oromoo uses Latin Qubee and renders with Plus Jakarta Sans.
  static TextTheme textTheme() {
    final ethiopicFamily = GoogleFonts.notoSansEthiopic().fontFamily;
    final base = GoogleFonts.plusJakartaSansTextTheme();
    final fallback = <String>[
      ?ethiopicFamily,
    ];

    TextStyle? withFallback(TextStyle? style) =>
        style?.copyWith(fontFamilyFallback: fallback);

    return base.copyWith(
      displayLarge: withFallback(
        base.displayLarge?.copyWith(
          color: AppColors.textPrimary,
          fontWeight: FontWeight.w700,
          letterSpacing: -0.5,
        ),
      ),
      displayMedium: withFallback(
        base.displayMedium?.copyWith(
          color: AppColors.textPrimary,
          fontWeight: FontWeight.w700,
          letterSpacing: -0.5,
        ),
      ),
      headlineLarge: withFallback(
        base.headlineLarge?.copyWith(
          color: AppColors.textPrimary,
          fontWeight: FontWeight.w700,
          fontSize: 28,
          letterSpacing: -0.4,
        ),
      ),
      headlineMedium: withFallback(
        base.headlineMedium?.copyWith(
          color: AppColors.textPrimary,
          fontWeight: FontWeight.w700,
          fontSize: 22,
          letterSpacing: -0.3,
        ),
      ),
      headlineSmall: withFallback(
        base.headlineSmall?.copyWith(
          color: AppColors.textPrimary,
          fontWeight: FontWeight.w600,
          fontSize: 18,
        ),
      ),
      titleLarge: withFallback(
        base.titleLarge?.copyWith(
          color: AppColors.textPrimary,
          fontWeight: FontWeight.w600,
          fontSize: 18,
        ),
      ),
      titleMedium: withFallback(
        base.titleMedium?.copyWith(
          color: AppColors.textPrimary,
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
      ),
      titleSmall: withFallback(
        base.titleSmall?.copyWith(
          color: AppColors.textSecondary,
          fontWeight: FontWeight.w500,
          fontSize: 14,
        ),
      ),
      bodyLarge: withFallback(
        base.bodyLarge?.copyWith(
          color: AppColors.textSecondary,
          fontWeight: FontWeight.w400,
          fontSize: 16,
          height: 1.45,
        ),
      ),
      bodyMedium: withFallback(
        base.bodyMedium?.copyWith(
          color: AppColors.textSecondary,
          fontWeight: FontWeight.w400,
          fontSize: 14,
          height: 1.4,
        ),
      ),
      bodySmall: withFallback(
        base.bodySmall?.copyWith(
          color: AppColors.textTertiary,
          fontWeight: FontWeight.w400,
          fontSize: 12,
          height: 1.35,
        ),
      ),
      labelLarge: withFallback(
        base.labelLarge?.copyWith(
          color: AppColors.textPrimary,
          fontWeight: FontWeight.w600,
          fontSize: 14,
          letterSpacing: 0.2,
        ),
      ),
      labelMedium: withFallback(
        base.labelMedium?.copyWith(
          color: AppColors.textTertiary,
          fontWeight: FontWeight.w600,
          fontSize: 12,
          letterSpacing: 0.6,
        ),
      ),
      labelSmall: withFallback(
        base.labelSmall?.copyWith(
          color: AppColors.textMuted,
          fontWeight: FontWeight.w500,
          fontSize: 11,
          letterSpacing: 0.8,
        ),
      ),
    );
  }
}
