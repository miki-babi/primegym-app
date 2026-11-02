import 'package:flutter/material.dart';

import '../../../theme/app_colors.dart';

class OnboardingChoiceOption {
  const OnboardingChoiceOption({
    required this.id,
    required this.label,
    required this.icon,
    this.description,
  });

  final String id;
  final String label;
  final String? description;
  final IconData icon;
}

class OnboardingProgress extends StatelessWidget {
  const OnboardingProgress({
    super.key,
    required this.step,
    required this.total,
  });

  final int step;
  final int total;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (var i = 0; i < total; i++) ...[
          if (i > 0) const SizedBox(width: 4),
          Expanded(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              height: 3,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3),
                color: i <= step
                    ? AppColors.accentSupport
                    : Colors.white.withValues(alpha: 0.2),
              ),
            ),
          ),
        ],
      ],
    );
  }
}

class OnboardingChoiceStep extends StatelessWidget {
  const OnboardingChoiceStep({
    super.key,
    required this.title,
    required this.subtitle,
    required this.options,
    required this.selected,
    required this.onToggle,
  });

  final String title;
  final String subtitle;
  final List<OnboardingChoiceOption> options;
  final Set<String> selected;
  final ValueChanged<String> onToggle;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: textTheme.titleLarge?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            height: 1.2,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          subtitle,
          style: textTheme.bodySmall?.copyWith(
            color: Colors.white.withValues(alpha: 0.72),
            height: 1.3,
          ),
        ),
        const SizedBox(height: 12),
        Expanded(
          child: options.length <= 3
              ? Column(
                  children: [
                    for (var i = 0; i < options.length; i++) ...[
                      if (i > 0) const SizedBox(height: 8),
                      Expanded(
                        child: _ChoiceTile(
                          option: options[i],
                          selected: selected.contains(options[i].id),
                          onTap: () => onToggle(options[i].id),
                          expanded: true,
                          compact: true,
                        ),
                      ),
                    ],
                  ],
                )
              : ListView.separated(
                  itemCount: options.length,
                  separatorBuilder: (_, _) => const SizedBox(height: 8),
                  itemBuilder: (context, i) {
                    final option = options[i];
                    return _ChoiceTile(
                      option: option,
                      selected: selected.contains(option.id),
                      onTap: () => onToggle(option.id),
                      expanded: true,
                      compact: true,
                    );
                  },
                ),
        ),
      ],
    );
  }
}

class _ChoiceTile extends StatelessWidget {
  const _ChoiceTile({
    required this.option,
    required this.selected,
    required this.onTap,
    this.expanded = false,
    this.compact = false,
  });

  final OnboardingChoiceOption option;
  final bool selected;
  final VoidCallback onTap;
  final bool expanded;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final description = option.description;
    final iconColor = selected ? AppColors.accent : Colors.white;
    final titleColor = selected ? AppColors.accent : Colors.white;
    final pad = compact ? 12.0 : (expanded ? 20.0 : 16.0);
    final iconBox = compact ? 40.0 : 48.0;

    final fill = selected
        ? AppColors.accent.withValues(alpha: 0.22)
        : Colors.white.withValues(alpha: 0.08);

    return Material(
      color: fill,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          width: double.infinity,
          padding: EdgeInsets.all(pad),
          decoration: BoxDecoration(
            color: fill,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: selected
                  ? AppColors.accent
                  : Colors.white.withValues(alpha: 0.14),
              width: selected ? 1.5 : 1,
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: iconBox,
                height: iconBox,
                decoration: BoxDecoration(
                  color: selected
                      ? AppColors.accentMuted
                      : Colors.white.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  option.icon,
                  size: compact ? 20 : 24,
                  color: iconColor,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      option.label,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: textTheme.titleMedium?.copyWith(
                        color: titleColor,
                        fontWeight: FontWeight.w600,
                        height: 1.2,
                        fontSize: compact ? 16 : null,
                      ),
                    ),
                    if (description != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        description,
                        maxLines: compact ? 2 : 4,
                        overflow: TextOverflow.ellipsis,
                        style: textTheme.bodySmall?.copyWith(
                          color: Colors.white.withValues(alpha: 0.78),
                          height: 1.3,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(width: 8),
              AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: selected ? AppColors.accent : Colors.transparent,
                  border: Border.all(
                    color: selected
                        ? AppColors.accent
                        : Colors.white.withValues(alpha: 0.4),
                    width: 1.5,
                  ),
                ),
                child: selected
                    ? const Icon(
                        Icons.check_rounded,
                        size: 14,
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
