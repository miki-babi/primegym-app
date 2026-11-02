import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

import '../../data/user_preferences.dart';
import '../../l10n/l10n_ext.dart';
import '../../l10n/locale_controller.dart';
import '../../theme/app_colors.dart';
import '../../widgets/horizontal_swipe_nav.dart';
import '../../widgets/pg_button.dart';
import 'steps/choice_step.dart';
import 'steps/equipment_step.dart';
import 'steps/generating_plan_step.dart';
import 'steps/language_step.dart';
import 'steps/name_step.dart';
import 'steps/offers_step.dart';

class OnboardingFlow extends StatefulWidget {
  const OnboardingFlow({super.key});

  @override
  State<OnboardingFlow> createState() => _OnboardingFlowState();
}

class _OnboardingFlowState extends State<OnboardingFlow> {
  static const _stepLanguage = 0;
  static const _stepOffers = 1;
  static const _stepName = 2;
  static const _stepGoal = 3;
  static const _stepFrequency = 4;
  static const _stepExperience = 5;
  static const _stepLocation = 6;
  static const _stepEquipment = 7;
  static const _stepGenerating = 8;
  static const _lastStep = _stepGenerating;

  /// Progress segments cover name → equipment (6 steps).
  static const _progressStart = _stepName;
  static const _progressCount = 6;

  int step = 0;
  String? language;
  String name = '';
  final Set<FitnessGoal> goals = {};
  TrainingFrequency? frequency;
  ExperienceLevel? experience;
  TrainingLocation? location;
  final Set<AvailableEquipment> equipment = {};
  bool _goingForward = true;

  late final TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    final prefs = UserPreferences.instance;
    name = prefs.displayName;
    goals.addAll(prefs.fitnessGoals);
    frequency = prefs.trainingFrequency;
    experience = prefs.experienceLevel;
    location = prefs.trainingLocation;
    equipment.addAll(prefs.equipment);
    _nameController = TextEditingController(text: name);
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  bool get _showProgress =>
      step >= _progressStart && step <= _stepEquipment;

  bool get _showBack => step > _stepLanguage && step != _stepGenerating;

  /// Offers owns its CTA. Equipment always shows Skip + Continue.
  bool get _showCta =>
      step != _stepGenerating &&
      step != _stepOffers &&
      (step == _stepEquipment || _canContinue);

  bool get _showEquipmentSkip => step == _stepEquipment;

  int get _progressIndex => (step - _progressStart).clamp(0, _progressCount - 1);

  void _back() {
    if (step == _stepLanguage || step == _stepGenerating) return;
    HapticFeedback.lightImpact();
    setState(() {
      _goingForward = false;
      step--;
    });
  }

  Future<void> _next() async {
    if (!_canContinue) {
      HapticFeedback.heavyImpact();
      return;
    }
    HapticFeedback.selectionClick();
    await _persistCurrentStep();
    if (!mounted) return;
    if (step < _lastStep) {
      setState(() {
        _goingForward = true;
        step++;
      });
    }
  }

  Future<void> _skipEquipment() async {
    if (step != _stepEquipment) return;
    HapticFeedback.selectionClick();
    equipment.clear();
    await UserPreferences.instance.setEquipment({});
    if (!mounted) return;
    setState(() {
      _goingForward = true;
      step++;
    });
  }

  Future<void> _persistCurrentStep() async {
    final prefs = UserPreferences.instance;
    switch (step) {
      case _stepName:
        await prefs.setDisplayName(name);
        return;
      case _stepGoal:
        await prefs.setFitnessGoals(goals);
        return;
      case _stepFrequency:
        if (frequency != null) await prefs.setTrainingFrequency(frequency!);
        return;
      case _stepExperience:
        if (experience != null) await prefs.setExperienceLevel(experience!);
        return;
      case _stepLocation:
        if (location != null) await prefs.setTrainingLocation(location!);
        return;
      case _stepEquipment:
        await prefs.setEquipment(equipment);
        return;
      case _stepLanguage:
      case _stepOffers:
      case _stepGenerating:
        return;
    }
  }

  bool get _canContinue => switch (step) {
    _stepLanguage => language != null,
    _stepOffers => true,
    _stepName => name.trim().isNotEmpty,
    _stepGoal => goals.isNotEmpty,
    _stepFrequency => frequency != null,
    _stepExperience => experience != null,
    _stepLocation => location != null,
    _stepEquipment => equipment.isNotEmpty,
    _stepGenerating => false,
    _ => false,
  };

  String get _ctaLabel => context.l10n.onboardingContinue;

  void _finishOnboarding() {
    if (!mounted) return;
    context.go('/home');
  }

  @override
  Widget build(BuildContext context) {
    final content = SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (_showBack || _showProgress)
              Row(
                children: [
                  if (_showBack) ...[
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
                    child: _showProgress
                        ? OnboardingProgress(
                            step: _progressIndex,
                            total: _progressCount,
                          )
                        : const SizedBox(height: 3),
                  ),
                ],
              )
            else
              const SizedBox(height: 40),
            const SizedBox(height: 12),
            Expanded(
              child: HorizontalSwipeNav(
                // Offers PageView + equipment accordion own vertical/horizontal
                // gestures; don't steal them for step navigation.
                onSwipeBack: _showBack &&
                        step != _stepOffers &&
                        step != _stepEquipment
                    ? _back
                    : null,
                onSwipeForward: step != _stepGenerating &&
                        step != _stepOffers &&
                        step != _stepEquipment &&
                        _canContinue
                    ? _next
                    : null,
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
                    child: _buildStep(),
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
              child: _showCta
                  ? Padding(
                      key: ValueKey(
                        'cta-$step-$_ctaLabel-$_showEquipmentSkip',
                      ),
                      padding: const EdgeInsets.only(top: 12),
                      child: _showEquipmentSkip
                          ? Row(
                              children: [
                                Expanded(
                                  child: PgButton(
                                    label: context.l10n.onboardingSkip,
                                    variant: PgButtonVariant.secondary,
                                    onPressed: _skipEquipment,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: PgButton(
                                    label: _ctaLabel,
                                    onPressed: _canContinue ? _next : null,
                                  ),
                                ),
                              ],
                            )
                          : PgButton(
                              label: _ctaLabel,
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
      canPop: step == _stepLanguage,
      onPopInvokedWithResult: (didPop, _) {
        if (didPop) return;
        _back();
      },
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: content,
      ),
    );
  }

  Widget _buildStep() {
    final l10n = context.l10n;
    return switch (step) {
      _stepLanguage => LanguageStep(
        selectedCode: language,
        onSelect: (code) {
          setState(() => language = code);
          LocaleController.instance.setLocale(Locale(code));
        },
      ),
      _stepOffers => OffersStep(onGetStarted: () { _next(); }),
      _stepName => NameStep(
        controller: _nameController,
        onChanged: (value) => setState(() => name = value),
      ),
      _stepGoal => OnboardingChoiceStep(
        title: l10n.onboardingGoalTitle,
        subtitle: l10n.onboardingGoalSubtitle,
        options: [
          OnboardingChoiceOption(
            id: FitnessGoal.strength.name,
            label: l10n.goalStrength,
            icon: Icons.bolt_rounded,
          ),
          OnboardingChoiceOption(
            id: FitnessGoal.weightLoss.name,
            label: l10n.goalWeightLoss,
            icon: Icons.monitor_weight_outlined,
          ),
          OnboardingChoiceOption(
            id: FitnessGoal.muscleGain.name,
            label: l10n.goalMuscleGain,
            icon: Icons.fitness_center_rounded,
          ),
        ],
        selected: {for (final goal in goals) goal.name},
        onToggle: (id) {
          final next = FitnessGoal.tryParse(id);
          if (next == null) return;
          setState(() {
            if (!goals.add(next)) {
              goals.remove(next);
            }
          });
        },
      ),
      _stepFrequency => OnboardingChoiceStep(
        title: l10n.onboardingFrequencyTitle,
        subtitle: l10n.onboardingFrequencySubtitle,
        options: [
          OnboardingChoiceOption(
            id: TrainingFrequency.once.name,
            label: l10n.frequencyOnce,
            icon: Icons.looks_one_rounded,
          ),
          OnboardingChoiceOption(
            id: TrainingFrequency.twice.name,
            label: l10n.frequencyTwice,
            icon: Icons.looks_two_rounded,
          ),
          OnboardingChoiceOption(
            id: TrainingFrequency.three.name,
            label: l10n.frequencyThree,
            icon: Icons.looks_3_rounded,
          ),
          OnboardingChoiceOption(
            id: TrainingFrequency.four.name,
            label: l10n.frequencyFour,
            icon: Icons.looks_4_rounded,
          ),
          OnboardingChoiceOption(
            id: TrainingFrequency.five.name,
            label: l10n.frequencyFive,
            icon: Icons.looks_5_rounded,
          ),
          OnboardingChoiceOption(
            id: TrainingFrequency.six.name,
            label: l10n.frequencySix,
            icon: Icons.looks_6_rounded,
          ),
          OnboardingChoiceOption(
            id: TrainingFrequency.everyday.name,
            label: l10n.frequencyEveryday,
            icon: Icons.all_inclusive_rounded,
          ),
        ],
        selected: {if (frequency != null) frequency!.name},
        onToggle: (id) {
          final next = TrainingFrequency.tryParse(id);
          if (next == null) return;
          setState(() => frequency = next);
        },
      ),
      _stepExperience => OnboardingChoiceStep(
        title: l10n.onboardingExperienceTitle,
        subtitle: l10n.onboardingExperienceSubtitle,
        options: [
          OnboardingChoiceOption(
            id: ExperienceLevel.beginner.name,
            label: l10n.levelBeginner,
            icon: Icons.spa_rounded,
          ),
          OnboardingChoiceOption(
            id: ExperienceLevel.intermediate.name,
            label: l10n.levelIntermediate,
            icon: Icons.trending_up_rounded,
          ),
          OnboardingChoiceOption(
            id: ExperienceLevel.advanced.name,
            label: l10n.levelAdvanced,
            icon: Icons.local_fire_department_rounded,
          ),
        ],
        selected: {if (experience != null) experience!.name},
        onToggle: (id) {
          final next = ExperienceLevel.tryParse(id);
          if (next == null) return;
          setState(() => experience = next);
        },
      ),
      _stepLocation => OnboardingChoiceStep(
        title: l10n.onboardingLocationTitle,
        subtitle: l10n.onboardingLocationSubtitle,
        options: [
          OnboardingChoiceOption(
            id: TrainingLocation.home.name,
            label: l10n.equipmentHome,
            description: l10n.equipmentHomeDesc,
            icon: Icons.home_rounded,
          ),
          OnboardingChoiceOption(
            id: TrainingLocation.gym.name,
            label: l10n.equipmentGym,
            description: l10n.equipmentGymDesc,
            icon: Icons.fitness_center_rounded,
          ),
          OnboardingChoiceOption(
            id: TrainingLocation.outdoor.name,
            label: l10n.locationOutdoor,
            description: l10n.locationOutdoorDetail,
            icon: Icons.park_rounded,
          ),
        ],
        selected: {if (location != null) location!.name},
        onToggle: (id) {
          final next = TrainingLocation.tryParse(id);
          if (next == null) return;
          setState(() => location = next);
        },
      ),
      _stepEquipment => EquipmentStep(
        selected: equipment,
        onToggle: (item) {
          setState(() {
            if (!equipment.add(item)) {
              equipment.remove(item);
            }
          });
        },
      ),
      _ => GeneratingPlanStep(onComplete: _finishOnboarding),
    };
  }
}
