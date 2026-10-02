import 'package:flutter/material.dart';

import '../theme/app_borders.dart';
import '../theme/app_colors.dart';

enum PgButtonVariant { primary, secondary, ghost }

class PgButton extends StatelessWidget {
  const PgButton({
    super.key,
    required this.label,
    this.onPressed,
    this.variant = PgButtonVariant.primary,
    this.icon,
    this.expand = true,
    this.height = 56,
  });

  final String label;
  final VoidCallback? onPressed;
  final PgButtonVariant variant;
  final Widget? icon;
  final bool expand;
  final double height;

  @override
  Widget build(BuildContext context) {
    final labelWidget = label.isEmpty
        ? null
        : Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: _foreground,
                  fontWeight: FontWeight.w700,
                ),
          );

    final child = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: expand ? MainAxisSize.max : MainAxisSize.min,
      children: [
        if (icon != null) icon!,
        if (icon != null && labelWidget != null) const SizedBox(width: 8),
        if (labelWidget != null)
          expand ? Flexible(child: labelWidget) : labelWidget,
      ],
    );

    final enabled = onPressed != null;
    final shape = AppBorders.continuous(
      context: context,
      borderColor: switch (variant) {
        PgButtonVariant.primary => AppBorders.filledRim,
        PgButtonVariant.secondary => AppColors.accent.withValues(alpha: 0.35),
        PgButtonVariant.ghost => null,
      },
      bordered: variant != PgButtonVariant.ghost,
    );

    final contentPadding = EdgeInsets.symmetric(
      horizontal: expand ? 16 : 24,
    );

    final button = switch (variant) {
      PgButtonVariant.primary => Opacity(
          opacity: enabled ? 1 : 0.5,
          child: DecoratedBox(
            decoration: ShapeDecoration(
              shape: shape,
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFFF7B84A), AppColors.accent],
              ),
              shadows: enabled
                  ? [
                      BoxShadow(
                        color: AppColors.accent.withValues(alpha: 0.28),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ]
                  : const [],
            ),
            child: Material(
              color: Colors.transparent,
              shape: shape,
              clipBehavior: Clip.antiAlias,
              child: InkWell(
                onTap: onPressed,
                customBorder: shape,
                child: SizedBox(
                  height: height,
                  child: Padding(
                    padding: contentPadding,
                    child: child,
                  ),
                ),
              ),
            ),
          ),
        ),
      PgButtonVariant.secondary => Opacity(
          opacity: enabled ? 1 : 0.5,
          child: Material(
            color: AppColors.accentSoft,
            shape: shape,
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              onTap: onPressed,
              customBorder: shape,
              child: SizedBox(
                height: height,
                child: Padding(
                  padding: contentPadding,
                  child: child,
                ),
              ),
            ),
          ),
        ),
      PgButtonVariant.ghost => TextButton(
          onPressed: onPressed,
          style: TextButton.styleFrom(
            minimumSize: Size(expand ? double.infinity : 0, height),
            foregroundColor: AppColors.textSecondary,
            shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.circular(
                AppBorders.continuousControlRadius,
              ),
            ),
          ),
          child: child,
        ),
    };

    if (!expand) return button;
    return SizedBox(width: double.infinity, child: button);
  }

  Color get _foreground => switch (variant) {
        PgButtonVariant.primary => const Color(0xFF1A1200),
        PgButtonVariant.secondary => AppColors.accent,
        PgButtonVariant.ghost => AppColors.textSecondary,
      };
}
