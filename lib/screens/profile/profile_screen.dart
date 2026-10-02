import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../data/mock_data.dart';
import '../../data/user_preferences.dart';
import '../../l10n/l10n_ext.dart';
import '../../l10n/locale_controller.dart';
import '../../theme/app_colors.dart';
import '../../widgets/pg_card.dart';
import '../../widgets/user_avatar.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  String _environmentLabel(AppLocalizations l10n, TrainingEnvironment env) {
    return switch (env) {
      TrainingEnvironment.noEquipment => l10n.equipmentNoEquipment,
      TrainingEnvironment.home => l10n.equipmentHome,
      TrainingEnvironment.gym => l10n.equipmentGym,
    };
  }

  String _environmentDesc(AppLocalizations l10n, TrainingEnvironment env) {
    return switch (env) {
      TrainingEnvironment.noEquipment => l10n.equipmentNoEquipmentDesc,
      TrainingEnvironment.home => l10n.equipmentHomeDesc,
      TrainingEnvironment.gym => l10n.equipmentGymDesc,
    };
  }

  Future<void> _pickLanguage(BuildContext context) async {
    final selected = await showModalBottomSheet<Locale>(
      context: context,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (sheetContext) {
        final sheetL10n = sheetContext.l10n;
        final current = LocaleController.instance.languageCode;
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  sheetL10n.chooseLanguage,
                  style: Theme.of(sheetContext).textTheme.titleLarge,
                ),
                const SizedBox(height: 16),
                _LanguageOption(
                  label: sheetL10n.languageEnglish,
                  selected: current == 'en',
                  onTap: () => Navigator.pop(sheetContext, const Locale('en')),
                ),
                _LanguageOption(
                  label: sheetL10n.languageAmharic,
                  selected: current == 'am',
                  onTap: () => Navigator.pop(sheetContext, const Locale('am')),
                ),
                _LanguageOption(
                  label: sheetL10n.languageAfaanOromoo,
                  selected: current == 'om',
                  onTap: () => Navigator.pop(sheetContext, const Locale('om')),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(sheetContext),
                  child: Text(sheetL10n.cancel),
                ),
              ],
            ),
          ),
        );
      },
    );

    if (selected != null) {
      await LocaleController.instance.setLocale(selected);
    }
  }

  Future<void> _pickTrainingEnvironment(BuildContext context) async {
    final draft = Set<TrainingEnvironment>.of(
      UserPreferences.instance.environments,
    );

    final confirmed = await showModalBottomSheet<Set<TrainingEnvironment>>(
      context: context,
      backgroundColor: AppColors.surface,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (sheetContext) {
        return StatefulBuilder(
          builder: (context, setSheetState) {
            final sheetL10n = context.l10n;
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      sheetL10n.settingsTrainingEnvironment,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      sheetL10n.onboardingEquipmentSubtitle,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.textTertiary,
                          ),
                    ),
                    const SizedBox(height: 16),
                    for (final env in TrainingEnvironment.values)
                      _LanguageOption(
                        label:
                            '${_environmentLabel(sheetL10n, env)} · ${_environmentDesc(sheetL10n, env)}',
                        selected: draft.contains(env),
                        onTap: () {
                          setSheetState(() {
                            if (!draft.add(env)) {
                              if (draft.length > 1) draft.remove(env);
                            }
                          });
                        },
                      ),
                    const SizedBox(height: 8),
                    FilledButton(
                      onPressed: () => Navigator.pop(sheetContext, Set.of(draft)),
                      child: Text(sheetL10n.onboardingContinue),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(sheetContext),
                      child: Text(sheetL10n.cancel),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );

    if (confirmed != null && confirmed.isNotEmpty) {
      await UserPreferences.instance.setEnvironments(confirmed);
    }
  }

  void _showDemoSnack(BuildContext context, String title) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(context.l10n.settingsDemoOnly(title))),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final l10n = context.l10n;
    final environments = UserPreferences.instance.environments;
    final environmentSubtitle = environments
        .map((e) => _environmentLabel(l10n, e))
        .join(' · ');

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
          children: [
            Text(l10n.profileTitle, style: textTheme.headlineMedium),
            const SizedBox(height: 24),
            Row(
              children: [
                const UserAvatar(name: MockData.currentUser, size: 72),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(MockData.currentUser, style: textTheme.headlineSmall),
                      const SizedBox(height: 4),
                      Text(
                        l10n.profileLevelIntermediate(MockData.level),
                        style: textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        l10n.locationStreakDays(MockData.streakDays),
                        style: textTheme.bodySmall?.copyWith(
                          color: AppColors.accent,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 28),
            PgCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(l10n.goalsTitle, style: textTheme.titleMedium),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      _GoalChip(l10n.goalBuildMuscle),
                      _GoalChip(l10n.goalImproveStrength),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            _SettingsTile(
              icon: Icons.translate_rounded,
              title: l10n.settingsLanguage,
              subtitle: LocaleController.instance.currentLanguageDisplayName,
              onTap: () => _pickLanguage(context),
            ),
            _SettingsTile(
              icon: Icons.home_work_rounded,
              title: l10n.settingsTrainingEnvironment,
              subtitle: environmentSubtitle,
              onTap: () => _pickTrainingEnvironment(context),
            ),
            _SettingsTile(
              icon: Icons.local_shipping_outlined,
              title: l10n.myOrders,
              subtitle: l10n.trackOrder,
              onTap: () => context.push('/orders'),
            ),
            _SettingsTile(
              icon: Icons.notifications_none_rounded,
              title: l10n.settingsNotifications,
              subtitle: l10n.settingsNotificationsOn,
              onTap: () => _showDemoSnack(context, l10n.settingsNotifications),
            ),
            _SettingsTile(
              icon: Icons.shield_outlined,
              title: l10n.settingsPrivacy,
              subtitle: l10n.settingsPrivacySubtitle,
              onTap: () => _showDemoSnack(context, l10n.settingsPrivacy),
            ),
            _SettingsTile(
              icon: Icons.credit_card_rounded,
              title: l10n.settingsSubscription,
              subtitle: l10n.settingsFreePlan,
              onTap: () => _showDemoSnack(context, l10n.settingsSubscription),
            ),
            const SizedBox(height: 8),
            TextButton(
              onPressed: () => context.go('/onboarding'),
              child: Text(l10n.replayOnboardingDemo),
            ),
          ],
        ),
      ),
    );
  }
}

class _LanguageOption extends StatelessWidget {
  const _LanguageOption({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Material(
        color: selected ? AppColors.accentSoft : AppColors.surfaceElevated,
        borderRadius: BorderRadius.circular(14),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(14),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: selected ? AppColors.accent : AppColors.border,
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    label,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: selected
                              ? AppColors.accent
                              : AppColors.textPrimary,
                        ),
                  ),
                ),
                if (selected)
                  const Icon(Icons.check_rounded, color: AppColors.accent),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _GoalChip extends StatelessWidget {
  const _GoalChip(this.label);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.accentSoft,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.accentMuted),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppColors.accent,
              fontWeight: FontWeight.w600,
            ),
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  const _SettingsTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: PgCard(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        onTap: onTap,
        child: Row(
          children: [
            Icon(icon, color: AppColors.accent, size: 20),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 2),
                  Text(subtitle, style: Theme.of(context).textTheme.bodySmall),
                ],
              ),
            ),
            const Icon(Icons.chevron_right_rounded, color: AppColors.textMuted),
          ],
        ),
      ),
    );
  }
}
