import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

import '../../data/user_preferences.dart';
import '../../l10n/l10n_ext.dart';
import '../../l10n/locale_controller.dart';
import '../../theme/app_colors.dart';
import '../../widgets/horizontal_swipe_nav.dart';
import '../../widgets/looping_bg_video.dart';
import '../../widgets/pg_button.dart';

class OnboardingFlow extends StatefulWidget {
  const OnboardingFlow({super.key});

  @override
  State<OnboardingFlow> createState() => _OnboardingFlowState();
}

class _OnboardingFlowState extends State<OnboardingFlow> {
  int step = 0;
  String? language;
  final Set<TrainingEnvironment> trainingEnvironments = {};
  bool _goingForward = true;

  static const environmentKeys = TrainingEnvironment.values;
  static const _totalSteps = 3;

  void _back() {
    HapticFeedback.lightImpact();
    if (step > 0) {
      setState(() {
        _goingForward = false;
        step--;
      });
    }
  }

  void _next() {
    if (!_canContinue) {
      HapticFeedback.heavyImpact();
      return;
    }
    HapticFeedback.selectionClick();
    if (step < 2) {
      setState(() {
        _goingForward = true;
        step++;
      });
    } else {
      context.go('/home');
    }
  }

  bool get _canContinue => switch (step) {
    0 => language != null,
    1 => trainingEnvironments.isNotEmpty,
    2 => true,
    _ => false,
  };

  String _environmentLabel(AppLocalizations l10n, TrainingEnvironment env) {
    return switch (env) {
      TrainingEnvironment.noEquipment => l10n.equipmentNoEquipment,
      TrainingEnvironment.home => l10n.equipmentHome,
      TrainingEnvironment.gym => l10n.equipmentGym,
    };
  }

  String _environmentDetail(AppLocalizations l10n, TrainingEnvironment env) {
    return switch (env) {
      TrainingEnvironment.noEquipment => l10n.equipmentNoEquipmentDetail,
      TrainingEnvironment.home => l10n.equipmentHomeDetail,
      TrainingEnvironment.gym => l10n.equipmentGymDetail,
    };
  }

  IconData _environmentIcon(TrainingEnvironment env) {
    return switch (env) {
      TrainingEnvironment.noEquipment => Icons.self_improvement_rounded,
      TrainingEnvironment.home => Icons.home_rounded,
      TrainingEnvironment.gym => Icons.fitness_center_rounded,
    };
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    final primaryLabel = l10n.onboardingContinue;
    final isFinishStep = step == 2;

    final content = SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                if (step > 0) ...[
                  Material(
                    color: Colors.white.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(10),
                    child: InkWell(
                      onTap: _back,
                      borderRadius: BorderRadius.circular(10),
                      child: const SizedBox(
                        width: 40,
                        height: 40,
                        child: Icon(
                          Icons.arrow_back_rounded,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                ],
                Expanded(
                  child: _OnboardingProgress(step: step, total: _totalSteps),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Expanded(
              child: HorizontalSwipeNav(
                onSwipeBack: _back,
                onSwipeForward: _next,
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  transitionBuilder: (child, animation) {
                    final begin = Offset(_goingForward ? 0.06 : -0.06, 0);
                    return FadeTransition(
                      opacity: animation,
                      child: SlideTransition(
                        position: Tween<Offset>(
                          begin: begin,
                          end: Offset.zero,
                        ).animate(animation),
                        child: child,
                      ),
                    );
                  },
                  child: KeyedSubtree(
                    key: ValueKey(step),
                    child: _buildStep(l10n),
                  ),
                ),
              ),
            ),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              switchInCurve: Curves.easeOutCubic,
              switchOutCurve: Curves.easeInCubic,
              transitionBuilder: (child, animation) {
                return FadeTransition(
                  opacity: animation,
                  child: SizeTransition(
                    sizeFactor: animation,
                    alignment: Alignment.topCenter,
                    child: child,
                  ),
                );
              },
              child: _canContinue
                  ? Padding(
                      key: ValueKey(
                        isFinishStep ? 'cta-finish' : 'cta-$step-$primaryLabel',
                      ),
                      padding: const EdgeInsets.only(top: 12),
                      child: PgButton(
                        label: isFinishStep ? '' : primaryLabel,
                        icon: isFinishStep
                            ? const Icon(
                                Icons.check_rounded,
                                size: 28,
                                color: Color(0xFF1A1200),
                              )
                            : null,
                        onPressed: _next,
                      ),
                    )
                  : const SizedBox.shrink(key: ValueKey('cta-hidden')),
            ),
          ],
        ),
      ),
    );

    return PopScope(
      canPop: step == 0,
      onPopInvokedWithResult: (didPop, _) {
        if (didPop) return;
        _back();
      },
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: Stack(
          fit: StackFit.expand,
          children: [
            const LoopingBgVideo(),
            const DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0x66000000),
                    Color(0x99000000),
                    Color(0xE6000000),
                  ],
                  stops: [0.0, 0.45, 1.0],
                ),
              ),
            ),
            content,
          ],
        ),
      ),
    );
  }

  Widget _buildStep(AppLocalizations l10n) {
    return switch (step) {
      0 => _LanguageStep(
        selectedCode: language,
        onSelect: (code) {
          setState(() => language = code);
          LocaleController.instance.setLocale(Locale(code));
        },
      ),
      1 => _ChoiceStep(
        title: l10n.onboardingEquipmentTitle,
        subtitle: l10n.onboardingEquipmentSubtitle,
        options: [
          for (final env in environmentKeys)
            _ChoiceOption(
              id: env.name,
              label: _environmentLabel(l10n, env),
              description: _environmentDetail(l10n, env),
              icon: _environmentIcon(env),
            ),
        ],
        selected: {for (final env in trainingEnvironments) env.name},
        onToggle: (id) {
          final env = TrainingEnvironment.tryParse(id);
          if (env == null) return;
          setState(() {
            if (!trainingEnvironments.add(env)) {
              trainingEnvironments.remove(env);
            }
          });
          UserPreferences.instance.setEnvironments(trainingEnvironments);
        },
      ),
      _ => _PlanRevealStep(
        environmentLabel: trainingEnvironments.isEmpty
            ? _environmentLabel(l10n, TrainingEnvironment.gym)
            : trainingEnvironments
                  .map((e) => _environmentLabel(l10n, e))
                  .join(' · '),
      ),
    };
  }
}

class _OnboardingProgress extends StatelessWidget {
  const _OnboardingProgress({required this.step, required this.total});

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
                    ? AppColors.accent
                    : Colors.white.withValues(alpha: 0.2),
              ),
            ),
          ),
        ],
      ],
    );
  }
}

class _ChoiceOption {
  const _ChoiceOption({
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

class _LanguageOption {
  const _LanguageOption({
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

class _LanguageStep extends StatelessWidget {
  const _LanguageStep({
    required this.selectedCode,
    required this.onSelect,
  });

  final String? selectedCode;
  final ValueChanged<String> onSelect;

  static const _options = [
    _LanguageOption(
      code: 'en',
      nativeName: 'English',
      englishName: 'English',
      badge: 'EN',
    ),
    _LanguageOption(
      code: 'am',
      nativeName: 'አማርኛ',
      englishName: 'Amharic',
      badge: 'አማ',
    ),
    _LanguageOption(
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
    final titleLineHeight = (titleStyle?.fontSize ?? 24) * (titleStyle?.height ?? 1.2);
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
        for (var i = 0; i < _options.length; i++) ...[
          if (i > 0) const SizedBox(height: 12),
          _LanguageTile(
            option: _options[i],
            selected: selectedCode == _options[i].code,
            onTap: () => onSelect(_options[i].code),
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

  final _LanguageOption option;
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
                ? AppColors.accentSoft
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
                        ? const Color(0xFF1A1200)
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
                        color: Color(0xFF1A1200),
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

class _ChoiceStep extends StatelessWidget {
  const _ChoiceStep({
    required this.title,
    required this.subtitle,
    required this.options,
    required this.selected,
    required this.onToggle,
  });

  final String title;
  final String subtitle;
  final List<_ChoiceOption> options;
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

  final _ChoiceOption option;
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

    return Material(
      color: selected
          ? AppColors.accentSoft
          : Colors.white.withValues(alpha: 0.08),
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          width: double.infinity,
          padding: EdgeInsets.all(pad),
          decoration: BoxDecoration(
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
                        color: Color(0xFF1A1200),
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

class _PlanRevealStep extends StatelessWidget {
  const _PlanRevealStep({required this.environmentLabel});

  final String environmentLabel;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final l10n = context.l10n;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.accentSoft,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.accentMuted),
            ),
            child: Text(
              l10n.onboardingPlanReadyBadge,
              style: textTheme.labelMedium?.copyWith(
                color: AppColors.accent,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            l10n.onboardingPlanTitle,
            style: textTheme.headlineMedium?.copyWith(
              color: Colors.white,
              height: 1.15,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            l10n.onboardingPlanSubtitle,
            style: textTheme.bodyMedium?.copyWith(
              color: Colors.white.withValues(alpha: 0.8),
              height: 1.35,
            ),
          ),
          const SizedBox(height: 24),
          _PlanTile(
            icon: Icons.auto_awesome_rounded,
            title: l10n.onboardingPlanTrainingTitle,
            body: l10n.onboardingPlanTrainingBody(environmentLabel),
          ),
          const SizedBox(height: 12),
          _PlanTile(
            icon: Icons.groups_rounded,
            title: l10n.onboardingPlanCommunityTitle,
            body: l10n.onboardingPlanCommunityBody,
          ),
          const SizedBox(height: 12),
          _PlanTile(
            icon: Icons.videocam_rounded,
            title: l10n.onboardingPlanTrainerTitle,
            body: l10n.onboardingPlanTrainerBody,
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}

class _PlanTile extends StatelessWidget {
  const _PlanTile({
    required this.icon,
    required this.title,
    required this.body,
  });

  final IconData icon;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withValues(alpha: 0.14)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: AppColors.accentSoft,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: AppColors.accent, size: 22),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: textTheme.titleMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  body,
                  style: textTheme.bodySmall?.copyWith(
                    color: Colors.white.withValues(alpha: 0.78),
                    height: 1.35,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
