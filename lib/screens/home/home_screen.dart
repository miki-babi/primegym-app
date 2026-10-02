import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../data/mock_data.dart';
import '../../data/user_preferences.dart';
import '../../l10n/l10n_ext.dart';
import '../../l10n/localized_string.dart';
import '../../theme/app_colors.dart';
import '../../widgets/pg_card.dart';
import '../../widgets/personalized_shop_card.dart';
import '../../widgets/section_header.dart';
import '../../widgets/shop_product_carousel.dart';
import '../../widgets/todays_workout_card.dart';
import '../../widgets/user_avatar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  String _greeting(AppLocalizations l10n) {
    final hour = DateTime.now().hour;
    if (hour < 12) return l10n.greetingMorning;
    if (hour < 17) return l10n.greetingAfternoon;
    return l10n.greetingEvening;
  }

  @override
  Widget build(BuildContext context) {
    final workout = MockData.todaysWorkoutFor(
      UserPreferences.instance.environments,
    );
    final shopProducts = MockData.personalizedProducts(
      UserPreferences.instance.environments,
    );
    final textTheme = Theme.of(context).textTheme;
    final l10n = context.l10n;
    final locale = Localizations.localeOf(context);

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
              sliver: SliverToBoxAdapter(
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            l10n.greetingWithName(
                              _greeting(l10n),
                              MockData.currentUser,
                            ),
                            style: textTheme.headlineSmall,
                          ),
                          const SizedBox(height: 6),
                          Row(
                            children: [
                              const Text('🔥', style: TextStyle(fontSize: 14)),
                              const SizedBox(width: 6),
                              Text(
                                l10n.dayStreak(MockData.streakDays),
                                style: textTheme.bodyMedium?.copyWith(
                                  color: AppColors.accent,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const UserAvatar(name: MockData.currentUser, size: 44),
                    const SizedBox(width: 12),
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: const Icon(
                        Icons.notifications_none_rounded,
                        size: 20,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 28, 20, 0),
              sliver: SliverToBoxAdapter(
                child: TodaysWorkoutCard(
                  todayLabel: l10n.sectionToday,
                  title: workout.title.resolve(locale),
                  subtitle: l10n.workoutProgressZeroOfOne,
                  ctaLabel: l10n.startWorkout,
                  onTap: () => context.push('/workout/${workout.id}'),
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
              sliver: SliverToBoxAdapter(
                child: _ExploreWorkoutsCard(
                  label: l10n.exploreWorkouts,
                  onTap: () => context.push('/explore/workouts'),
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 32, 20, 0),
              sliver: SliverToBoxAdapter(
                child: PgCard(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  child: Column(
                    children: [
                      for (final friend in MockData.friends.take(3))
                        Material(
                          color: Colors.transparent,
                          child: ListTile(
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
                            ),
                            leading: UserAvatar(
                              name: friend.name,
                              showOnline: true,
                              online: friend.isTraining,
                            ),
                            title: Text(
                              friend.name,
                              style: textTheme.titleMedium,
                            ),
                            trailing: Text(
                              friend.isTraining
                                  ? '🟢 ${context.l10nStr(friend.status)}'
                                  : '✅ ${context.l10nStr(friend.status)}',
                              style: textTheme.bodySmall?.copyWith(
                                color: friend.isTraining
                                    ? AppColors.success
                                    : AppColors.textTertiary,
                              ),
                            ),
                            onTap: () => context.push(
                              '/friend/${Uri.encodeComponent(friend.name)}',
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 32, 20, 0),
              sliver: SliverToBoxAdapter(
                child: SectionHeader(
                  title: l10n.recommendedForYou,
                  actionLabel: l10n.shopSeeAll,
                  onAction: () => context.push('/shop'),
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
              sliver: SliverToBoxAdapter(
                child: Text(
                  shopProductHeadline(l10n, shopProducts.first),
                  style: textTheme.titleMedium,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(top: 12),
                child: ShopProductCarousel(products: shopProducts),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 24)),
          ],
        ),
      ),
    );
  }
}

class _ExploreWorkoutsCard extends StatelessWidget {
  const _ExploreWorkoutsCard({
    required this.label,
    required this.onTap,
  });

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Material(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(16, 18, 16, 18),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.border),
          ),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: AppColors.accentSoft,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(
                  Icons.explore_rounded,
                  color: AppColors.accent,
                  size: 24,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  label,
                  style: textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
              const Icon(
                Icons.chevron_right_rounded,
                color: AppColors.textMuted,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
