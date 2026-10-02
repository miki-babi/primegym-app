import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../data/mock_data.dart';
import '../../data/user_preferences.dart';
import '../../l10n/l10n_ext.dart';
import '../../l10n/localized_string.dart';
import '../../theme/app_colors.dart';
import '../../widgets/exercise_image.dart';
import '../../widgets/pg_card.dart';
import '../../widgets/section_header.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  List<(IconData, String, String)> _primaryCategories(AppLocalizations l10n) => [
        (
          Icons.local_fire_department_rounded,
          l10n.categoryChallenges,
          '/challenges'
        ),
        (Icons.groups_rounded, l10n.categoryCommunities, '/community'),
        (Icons.storefront_rounded, l10n.categoryShop, '/shop'),
      ];

  List<(IconData, String, String)> _laterCategories(AppLocalizations l10n) => [
        (Icons.fitness_center_rounded, l10n.categoryGyms, '/gyms'),
        (Icons.verified_user_rounded, l10n.categoryTrainers, '/trainers'),
        (Icons.event_rounded, l10n.categoryEvents, '/events'),
      ];

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final l10n = context.l10n;
    final envs = UserPreferences.instance.environments;
    final popularExercises =
        MockData.exercisesForEnvironments(envs).take(6).toList();
    final recommended = MockData.workoutsForEnvironments(envs);

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
              sliver: SliverToBoxAdapter(
                child: Text(l10n.exploreTitle, style: textTheme.headlineMedium),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
              sliver: SliverToBoxAdapter(
                child: TextField(
                  readOnly: true,
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(l10n.searchDemoOnlyForNow)),
                    );
                  },
                  decoration: InputDecoration(
                    hintText: l10n.exploreSearchHint,
                    prefixIcon: const Icon(Icons.search_rounded, size: 20),
                  ),
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 28, 20, 0),
              sliver: SliverToBoxAdapter(
                child: SectionHeader(title: l10n.sectionTrain),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
              sliver: SliverToBoxAdapter(
                child: SizedBox(
                  height: 40,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      for (final cat in _primaryCategories(l10n)) ...[
                        _ExploreChip(
                          icon: cat.$1,
                          label: cat.$2,
                          onTap: () {
                            if (cat.$3 == '/community') {
                              context.go(cat.$3);
                            } else {
                              context.push(cat.$3);
                            }
                          },
                        ),
                        const SizedBox(width: 8),
                      ],
                    ],
                  ),
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 28, 20, 0),
              sliver: SliverToBoxAdapter(
                child: SectionHeader(title: l10n.sectionPopularExercises),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
              sliver: SliverList.separated(
                itemCount: popularExercises.length,
                separatorBuilder: (_, _) => const SizedBox(height: 10),
                itemBuilder: (context, i) {
                  final ex = popularExercises[i];
                  return PgCard(
                    onTap: () => context.push('/exercise/${ex.id}'),
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        ExerciseImage(
                          assetPath: ex.imageAsset,
                          width: 56,
                          height: 56,
                          borderRadius: 14,
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                context.l10nStr(ex.name),
                                style: textTheme.titleMedium,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '${context.l10nStr(ex.muscle)} · ${context.l10nStr(ex.type)} · ${context.l10nStr(ex.difficulty)}',
                                style: textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ),
                        const Icon(
                          Icons.play_circle_outline_rounded,
                          color: AppColors.accent,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 28, 20, 0),
              sliver: SliverToBoxAdapter(
                child: SectionHeader(title: l10n.sectionRecommendedWorkouts),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
              sliver: SliverToBoxAdapter(
                child: SizedBox(
                  height: 160,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: recommended.length,
                    separatorBuilder: (_, _) => const SizedBox(width: 12),
                    itemBuilder: (context, i) {
                      final w = recommended[i];
                      return SizedBox(
                        width: 220,
                        child: PgCard(
                          onTap: () => context.push('/workout/${w.id}'),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (w.tag != null)
                                Text(
                                  context.l10nStr(w.tag!).toUpperCase(),
                                  style: textTheme.labelSmall?.copyWith(
                                    color: AppColors.accent,
                                  ),
                                ),
                              const Spacer(),
                              Text(
                                context.l10nStr(w.title),
                                style: textTheme.titleLarge,
                              ),
                              const SizedBox(height: 6),
                              Text(
                                l10n.workoutDurationLevel(
                                  w.durationMinutes,
                                  context.l10nStr(w.level),
                                ),
                                style: textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 28, 20, 32),
              sliver: SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SectionHeader(title: l10n.sectionComingLater),
                    const SizedBox(height: 8),
                    Text(
                      l10n.comingLaterHint,
                      style: textTheme.bodySmall,
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        for (final cat in _laterCategories(l10n))
                          _ExploreChip(
                            icon: cat.$1,
                            label: cat.$2,
                            muted: true,
                            onTap: () => context.push(cat.$3),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ExploreChip extends StatelessWidget {
  const _ExploreChip({
    required this.icon,
    required this.label,
    required this.onTap,
    this.muted = false,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool muted;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: muted ? AppColors.background : AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: muted ? AppColors.border : AppColors.accentMuted,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 18,
              color: muted ? AppColors.textMuted : AppColors.accent,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: muted
                        ? AppColors.textMuted
                        : AppColors.textSecondary,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
