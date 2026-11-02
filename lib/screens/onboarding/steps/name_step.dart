import 'package:flutter/material.dart';

import '../../../l10n/l10n_ext.dart';
import '../../../theme/app_colors.dart';

class NameStep extends StatelessWidget {
  const NameStep({
    super.key,
    required this.controller,
    required this.onChanged,
  });

  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final l10n = context.l10n;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        Text(
          l10n.onboardingNameTitle,
          style: textTheme.headlineSmall?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            height: 1.2,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          l10n.onboardingNameSubtitle,
          style: textTheme.bodyMedium?.copyWith(
            color: Colors.white.withValues(alpha: 0.72),
            height: 1.35,
          ),
        ),
        const SizedBox(height: 32),
        TextField(
          controller: controller,
          onChanged: onChanged,
          autofocus: true,
          textCapitalization: TextCapitalization.words,
          textInputAction: TextInputAction.done,
          style: textTheme.titleLarge?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
          cursorColor: AppColors.accent,
          decoration: InputDecoration(
            hintText: l10n.onboardingNameHint,
            hintStyle: textTheme.titleLarge?.copyWith(
              color: Colors.white.withValues(alpha: 0.35),
              fontWeight: FontWeight.w500,
            ),
            filled: true,
            fillColor: Colors.white.withValues(alpha: 0.08),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 18,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(
                color: Colors.white.withValues(alpha: 0.14),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(
                color: AppColors.accent,
                width: 1.5,
              ),
            ),
          ),
        ),
        const Spacer(),
      ],
    );
  }
}
