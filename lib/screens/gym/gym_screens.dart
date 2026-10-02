import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../data/mock_data.dart';
import '../../l10n/l10n_ext.dart';
import '../../l10n/localized_string.dart';
import '../../theme/app_colors.dart';
import '../../widgets/pg_button.dart';
import '../../widgets/pg_card.dart';
import '../../widgets/section_header.dart';

class GymListScreen extends StatelessWidget {
  const GymListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => context.pop(),
        ),
        title: Text(l10n.gymsNearYou),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
        itemCount: MockData.gyms.length,
        separatorBuilder: (_, _) => const SizedBox(height: 12),
        itemBuilder: (context, i) {
          final gym = MockData.gyms[i];
          return PgCard(
            onTap: () => context.push('/gym/${gym.id}'),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(gym.name, style: textTheme.titleLarge),
                    ),
                    Text(
                      l10n.distanceKm(gym.distanceKm),
                      style: textTheme.bodySmall,
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  l10n.gymOpenUntilRating(
                    gym.rating,
                    context.l10nStr(gym.openUntil),
                  ),
                  style: textTheme.bodyMedium,
                ),
                const SizedBox(height: 8),
                Text(
                  l10n.peopleCheckedInToday(gym.checkedInToday),
                  style: textTheme.bodySmall?.copyWith(color: AppColors.accent),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class GymDetailScreen extends StatelessWidget {
  const GymDetailScreen({super.key, required this.gymId});

  final String gymId;

  @override
  Widget build(BuildContext context) {
    final gym = MockData.gymById(gymId) ?? MockData.gyms.first;
    final textTheme = Theme.of(context).textTheme;
    final l10n = context.l10n;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_rounded),
              onPressed: () => context.pop(),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      AppColors.accent.withValues(alpha: 0.35),
                      AppColors.surfaceElevated,
                    ],
                  ),
                ),
                child: const Center(
                  child: Icon(
                    Icons.fitness_center_rounded,
                    size: 56,
                    color: AppColors.accent,
                  ),
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 120),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                Text(gym.name, style: textTheme.headlineMedium),
                const SizedBox(height: 8),
                Text(
                  l10n.gymDistanceAway(gym.rating, gym.distanceKm),
                  style: textTheme.bodyLarge,
                ),
                const SizedBox(height: 24),
                SectionHeader(title: l10n.sectionInformation),
                const SizedBox(height: 12),
                _InfoRow(
                  label: l10n.infoHours,
                  value: l10n.openUntil(context.l10nStr(gym.openUntil)),
                ),
                _InfoRow(
                  label: l10n.infoMembership,
                  value: context.l10nStr(gym.priceLabel),
                ),
                _InfoRow(
                  label: l10n.infoLocation,
                  value: context.l10nStr(gym.address),
                ),
                _InfoRow(
                  label: l10n.infoAmenities,
                  value: gym.amenities.map(context.l10nStr).join(' · '),
                ),
                const SizedBox(height: 24),
                SectionHeader(title: l10n.sectionCommunity),
                const SizedBox(height: 12),
                PgCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.gymCommunitySuffix(gym.name).toUpperCase(),
                        style: textTheme.labelMedium,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        l10n.membersCount(gym.members),
                        style: textTheme.titleMedium,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        l10n.activeThisWeek(gym.activeThisWeek),
                        style: textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        l10n.septemberChallenge,
                        style: textTheme.bodyMedium?.copyWith(
                          color: AppColors.accent,
                        ),
                      ),
                      const SizedBox(height: 16),
                      PgButton(
                        label: l10n.joinCommunity,
                        variant: PgButtonVariant.secondary,
                        height: 48,
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(l10n.joinedCommunityDemo),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ]),
            ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
          child: PgButton(
            label: l10n.checkIn,
            icon: const Icon(
              Icons.qr_code_scanner_rounded,
              size: 18,
              color: Color(0xFF1A1200),
            ),
            onPressed: () => context.push('/gym/${gym.id}/check-in'),
          ),
        ),
      ),
    );
  }
}

class GymCheckInScreen extends StatefulWidget {
  const GymCheckInScreen({super.key, required this.gymId});

  final String gymId;

  @override
  State<GymCheckInScreen> createState() => _GymCheckInScreenState();
}

class _GymCheckInScreenState extends State<GymCheckInScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 650),
    );
    _scale = CurvedAnimation(parent: _controller, curve: Curves.elasticOut);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final gym = MockData.gymById(widget.gymId) ?? MockData.gyms.first;
    final textTheme = Theme.of(context).textTheme;
    final l10n = context.l10n;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const Spacer(),
              ScaleTransition(
                scale: _scale,
                child: Container(
                  width: 88,
                  height: 88,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.successSoft,
                    border: Border.all(
                      color: AppColors.success.withValues(alpha: 0.4),
                    ),
                  ),
                  child: const Icon(
                    Icons.check_rounded,
                    color: AppColors.success,
                    size: 40,
                  ),
                ),
              ),
              const SizedBox(height: 28),
              Text(l10n.checkedIn, style: textTheme.headlineMedium),
              const SizedBox(height: 12),
              Text(
                gym.name,
                style: textTheme.titleLarge?.copyWith(color: AppColors.accent),
              ),
              const SizedBox(height: 8),
              Text(
                l10n.checkInXpPeople(gym.checkedInToday + 1),
                style: textTheme.bodyLarge,
              ),
              const Spacer(),
              PgButton(
                label: l10n.startWorkout,
                onPressed: () => context.push('/workout/start'),
              ),
              const SizedBox(height: 12),
              PgButton(
                label: l10n.done,
                variant: PgButtonVariant.ghost,
                onPressed: () => context.go('/home'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 110,
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textTertiary,
                  ),
            ),
          ),
          Expanded(
            child: Text(value, style: Theme.of(context).textTheme.titleSmall),
          ),
        ],
      ),
    );
  }
}
