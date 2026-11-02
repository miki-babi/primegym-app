import 'package:flutter/material.dart';

/// Apple-style control chrome: continuous corners + device hairline strokes.
abstract final class AppBorders {
  /// Visual match for iOS large control radius (~14pt continuous).
  static const double controlRadius = 14;

  /// Continuous corner radius (reads softer / more iOS than circular).
  static const double continuousControlRadius = 28;

  /// Warm olive separator / outline.
  static const Color separator = Color(0xFF7B7457);

  /// Soft rim used on filled controls.
  static Color get filledRim =>
      const Color(0xFF854627).withValues(alpha: 0.12);

  static double hairlineWidth(BuildContext context) {
    final dpr = MediaQuery.devicePixelRatioOf(context);
    return (1 / dpr).clamp(0.33, 0.67);
  }

  static BorderSide hairline(
    BuildContext context, {
    Color? color,
  }) {
    return BorderSide(
      color: color ?? separator,
      width: hairlineWidth(context),
    );
  }

  static Border hairlineBorder(
    BuildContext context, {
    Color? color,
  }) {
    return Border.fromBorderSide(hairline(context, color: color));
  }

  static ShapeBorder continuous({
    required BuildContext context,
    Color? borderColor,
    double radius = continuousControlRadius,
    bool bordered = true,
  }) {
    return ContinuousRectangleBorder(
      borderRadius: BorderRadius.circular(radius),
      side: bordered
          ? hairline(context, color: borderColor)
          : BorderSide.none,
    );
  }
}
