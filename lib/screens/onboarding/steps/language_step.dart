import 'package:flutter/material.dart';

import '../../../l10n/l10n_ext.dart';
import '../../../theme/app_colors.dart';

class LanguageOption {
  const LanguageOption({
    required this.code,
    required this.nativeName,
    required this.englishName,
    required this.badge,
  });

  final String code;
  final String nativeName;
  final String englishName;
  final String badge;
}

class LanguageStep extends StatelessWidget {
  const LanguageStep({
    super.key,
    required this.selectedCode,
    required this.onSelect,
  });

  final String? selectedCode;
  final ValueChanged<String> onSelect;

  static const options = [
    LanguageOption(
      code: 'en',
      nativeName: 'English',
      englishName: 'English',
      badge: 'EN',
    ),
    LanguageOption(
      code: 'am',
      nativeName: 'አማርኛ',
      englishName: 'Amharic',
      badge: 'አማ',
    ),
    LanguageOption(
      code: 'om',
      nativeName: 'Afaan Oromoo',
      englishName: 'Oromo',
      badge: 'OM',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final l10n = context.l10n;
    final titleStyle = textTheme.headlineSmall?.copyWith(
      color: Colors.white,
      fontWeight: FontWeight.w700,
      height: 1.2,
    );
    final subtitleStyle = textTheme.bodyMedium?.copyWith(
      color: Colors.white.withValues(alpha: 0.7),
      height: 1.35,
    );
    final titleLineHeight =
        (titleStyle?.fontSize ?? 24) * (titleStyle?.height ?? 1.2);
    final subtitleLineHeight =
        (subtitleStyle?.fontSize ?? 14) * (subtitleStyle?.height ?? 1.35);
    final headerHeight = titleLineHeight + 8 + (subtitleLineHeight * 2);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        SizedBox(
          height: headerHeight,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.onboardingChooseLanguageTitle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: titleStyle,
              ),
              const SizedBox(height: 8),
              Text(
                l10n.onboardingChooseLanguageSubtitle,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: subtitleStyle,
              ),
            ],
          ),
        ),
        const SizedBox(height: 28),
        for (var i = 0; i < options.length; i++) ...[
          if (i > 0) const SizedBox(height: 12),
          _LanguageTile(
            option: options[i],
            selected: selectedCode == options[i].code,
            onTap: () => onSelect(options[i].code),
          ),
        ],
        const Spacer(),
      ],
    );
  }
}

class _LanguageTile extends StatelessWidget {
  const _LanguageTile({
    required this.option,
    required this.selected,
    required this.onTap,
  });

  final LanguageOption option;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final showEnglishSubtitle = option.nativeName != option.englishName;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOutCubic,
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
          decoration: BoxDecoration(
            color: selected
                ? AppColors.accent.withValues(alpha: 0.22)
                : Colors.white.withValues(alpha: 0.07),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: selected
                  ? AppColors.accent
                  : Colors.white.withValues(alpha: 0.12),
              width: selected ? 1.5 : 1,
            ),
            boxShadow: selected
                ? [
                    BoxShadow(
                      color: AppColors.accent.withValues(alpha: 0.18),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ]
                : const [],
          ),
          child: Row(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 52,
                height: 52,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: selected
                      ? AppColors.accent
                      : Colors.white.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  option.badge,
                  style: textTheme.titleSmall?.copyWith(
                    color: selected
                        ? AppColors.onAccent
                        : Colors.white.withValues(alpha: 0.9),
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.2,
                    height: 1,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      option.nativeName,
                      style: textTheme.titleMedium?.copyWith(
                        color: selected ? AppColors.accent : Colors.white,
                        fontWeight: FontWeight.w700,
                        height: 1.2,
                      ),
                    ),
                    if (showEnglishSubtitle) ...[
                      const SizedBox(height: 4),
                      Text(
                        option.englishName,
                        style: textTheme.bodySmall?.copyWith(
                          color: Colors.white.withValues(alpha: 0.62),
                          height: 1.2,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: selected ? AppColors.accent : Colors.transparent,
                  border: Border.all(
                    color: selected
                        ? AppColors.accent
                        : Colors.white.withValues(alpha: 0.35),
                    width: 1.5,
                  ),
                ),
                child: selected
                    ? const Icon(
                        Icons.check_rounded,
                        size: 16,
                        color: AppColors.onAccent,
                      )
                    : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
