import 'package:flutter/material.dart';

import '../../data/mock_data.dart';
import '../../l10n/l10n_ext.dart';
import '../../l10n/localized_string.dart';
import '../../theme/app_colors.dart';
import '../../widgets/pg_card.dart';
import '../../widgets/pg_progress_bar.dart';
import '../../widgets/section_header.dart';

class ActivityScreen extends StatelessWidget {
  const ActivityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final l10n = context.l10n;
    final xpProgress = MockData.xp / MockData.xpToNext;

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
          children: [
            Text(l10n.activityTitle, style: textTheme.headlineMedium),
            const SizedBox(height: 24),
            PgCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        l10n.levelLabel(MockData.level),
                        style: textTheme.headlineSmall,
                      ),
                      const Spacer(),
                      Text(
                        '🔥 ${l10n.dayStreakShort(MockData.streakDays)}',
                        style: textTheme.titleSmall?.copyWith(
                          color: AppColors.accent,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  PgProgressBar(value: xpProgress, height: 10),
                  const SizedBox(height: 10),
                  Text(
                    l10n.xpProgress(MockData.xp, MockData.xpToNext),
                    style: textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28),
            SectionHeader(title: l10n.sectionThisWeek),
            const SizedBox(height: 12),
            Row(
              children: [
                _StatTile(label: l10n.statWorkouts, value: '3'),
                const SizedBox(width: 12),
                _StatTile(label: l10n.statMinutes, value: '148'),
                const SizedBox(width: 12),
                _StatTile(label: l10n.statXp, value: '+405'),
              ],
            ),
            const SizedBox(height: 28),
            SectionHeader(title: l10n.sectionRecent),
            const SizedBox(height: 12),
            for (final entry in MockData.recentActivity) ...[
              PgCard(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: AppColors.accentSoft,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.bolt_rounded,
                        color: AppColors.accent,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            context.l10nStr(entry.title),
                            style: textTheme.titleMedium,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${context.l10nStr(entry.subtitle)} · ${context.l10nStr(entry.dateLabel)}',
                            style: textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                    Text(
                      '+${entry.xp}',
                      style: textTheme.titleSmall?.copyWith(
                        color: AppColors.accent,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
            ],
          ],
        ),
      ),
    );
  }
}

class _StatTile extends StatelessWidget {
  const _StatTile({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.border),
        ),
        child: Column(
          children: [
            Text(value, style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 4),
            Text(label, style: Theme.of(context).textTheme.bodySmall),
          ],
        ),
      ),
    );
  }
}
