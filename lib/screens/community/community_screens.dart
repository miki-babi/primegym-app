import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

import '../../data/app_store.dart';
import '../../data/mock_data.dart';
import '../../l10n/l10n_ext.dart';
import '../../l10n/localized_string.dart';
import '../../models/models.dart';
import '../../theme/app_colors.dart';
import '../../widgets/pg_button.dart';
import '../../widgets/pg_card.dart';
import '../../widgets/pg_progress_bar.dart';
import '../../widgets/section_header.dart';
import '../../widgets/user_avatar.dart';

class CommunityScreen extends StatelessWidget {
  const CommunityScreen({super.key});

  Future<void> _openComposer(BuildContext context) async {
    final result = await context.push<FeedPost>('/post-progress');
    if (result != null && context.mounted) {
      final l10n = context.l10n;
      final message = switch (result.visibility) {
        ProgressVisibility.privateOnly => l10n.savedAsPrivateProgress,
        ProgressVisibility.friendsOnly => l10n.savedAsFriendsProgress,
        ProgressVisibility.publicFeed => l10n.progressPostedToFeed,
      };
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final textTheme = Theme.of(context).textTheme;
    final store = AppStore.instance;
    final feed = store.visibleFeed();
    final friendsProgress = store.friendsProgressPosts();

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
                      child: Text(
                        l10n.communityTitle,
                        style: textTheme.headlineMedium,
                      ),
                    ),
                    TextButton.icon(
                      onPressed: () => _openComposer(context),
                      icon: const Icon(
                        Icons.add_a_photo_rounded,
                        size: 18,
                        color: AppColors.accent,
                      ),
                      label: Text(
                        l10n.postProgress,
                        style: textTheme.labelLarge?.copyWith(
                          color: AppColors.accent,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              sliver: SliverToBoxAdapter(
                child: SectionHeader(title: l10n.activeChallenges),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
              sliver: SliverToBoxAdapter(
                child: SizedBox(
                  height: 150,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: MockData.challenges.length,
                    separatorBuilder: (_, _) => const SizedBox(width: 12),
                    itemBuilder: (context, i) {
                      final c = MockData.challenges[i];
                      return SizedBox(
                        width: 240,
                        child: PgCard(
                          onTap: () => context.push('/challenge/${c.id}'),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                context.l10nStr(c.typeLabel).toUpperCase(),
                                style: textTheme.labelSmall?.copyWith(
                                  color: AppColors.accent,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                context.l10nStr(c.title),
                                style: textTheme.titleMedium,
                              ),
                              const Spacer(),
                              PgProgressBar(value: c.progress / c.goal),
                              const SizedBox(height: 8),
                              Text(
                                l10n.challengeDaysLeftShort(
                                  c.progress,
                                  c.goal,
                                  c.daysLeft,
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
            if (friendsProgress.isNotEmpty) ...[
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(20, 28, 20, 0),
                sliver: SliverToBoxAdapter(
                  child: SectionHeader(title: l10n.sectionFriendsProgress),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
                sliver: SliverToBoxAdapter(
                  child: SizedBox(
                    height: 112,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: friendsProgress.length,
                      separatorBuilder: (_, _) => const SizedBox(width: 12),
                      itemBuilder: (context, i) {
                        final post = friendsProgress[i];
                        return SizedBox(
                          width: 200,
                          child: PgCard(
                            onTap: () => context.push('/progress/${post.id}'),
                            padding: const EdgeInsets.all(12),
                            child: Row(
                              children: [
                                GestureDetector(
                                  onTap: () => context.push(
                                    '/friend/${Uri.encodeComponent(post.author)}',
                                  ),
                                  child: UserAvatar(name: post.author, size: 40),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      GestureDetector(
                                        onTap: () => context.push(
                                          '/friend/${Uri.encodeComponent(post.author)}',
                                        ),
                                        child: Text(
                                          post.author,
                                          style: textTheme.titleSmall,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        context.l10nStr(post.body),
                                        style: textTheme.bodySmall,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
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
            ],
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 28, 20, 0),
              sliver: SliverToBoxAdapter(
                child: SectionHeader(title: l10n.sectionFeed),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
              sliver: SliverFeedList(feed: feed),
            ),
          ],
        ),
      ),
    );
  }
}

class SliverFeedList extends StatelessWidget {
  const SliverFeedList({super.key, required this.feed});

  final List<FeedPost> feed;

  @override
  Widget build(BuildContext context) {
    return SliverList.separated(
      itemCount: feed.length,
      separatorBuilder: (_, _) => const SizedBox(height: 12),
      itemBuilder: (context, i) => FeedPostCard(post: feed[i]),
    );
  }
}

class FeedPostCard extends StatelessWidget {
  const FeedPostCard({super.key, required this.post});

  final FeedPost post;

  void _openProfile(BuildContext context) {
    context.push('/friend/${Uri.encodeComponent(post.author)}');
  }

  void _openDetail(BuildContext context) {
    context.push('/progress/${post.id}');
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final textTheme = Theme.of(context).textTheme;

    return PgCard(
      onTap: () => _openDetail(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () => _openProfile(context),
                child: UserAvatar(name: post.author, size: 40),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: GestureDetector(
                  onTap: () => _openProfile(context),
                  behavior: HitTestBehavior.opaque,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(post.author, style: textTheme.titleMedium),
                      Text(
                        '${context.l10nStr(post.type)} · ${context.l10nStr(post.timeAgo)}',
                        style: textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
              ),
              _VisibilityBadge(visibility: post.visibility),
              if (post.emotionEmoji != null) ...[
                const SizedBox(width: 8),
                Text(
                  post.emotionEmoji!,
                  style: const TextStyle(fontSize: 28),
                ),
              ],
            ],
          ),
          if (post.primaryMedia != null) ...[
            const SizedBox(height: 14),
            switch (post.primaryMedia!.kind) {
              ProgressMediaKind.photo => ProgressPhotoBlock(
                  label: post.primaryMedia!.label,
                  weightKg: post.weightKg,
                ),
              ProgressMediaKind.video => ProgressVideoBlock(
                  label: post.primaryMedia!.label,
                  weightKg: post.weightKg,
                ),
            },
          ],
          if (context.l10nStr(post.body).isNotEmpty) ...[
            const SizedBox(height: 14),
            Text(context.l10nStr(post.body), style: textTheme.bodyLarge),
          ],
          if (post.emotionEmoji != null && post.meta != null) ...[
            const SizedBox(height: 10),
            Text(
              '${post.emotionEmoji} ${context.l10nStr(post.meta!)}',
              style: textTheme.bodySmall?.copyWith(color: AppColors.accent),
            ),
          ] else if (post.meta != null) ...[
            const SizedBox(height: 10),
            Text(
              context.l10nStr(post.meta!),
              style: textTheme.bodySmall?.copyWith(color: AppColors.accent),
            ),
          ],
          if (post.weightKg != null && !post.hasMedia) ...[
            const SizedBox(height: 10),
            WeightChip(weightKg: post.weightKg!),
          ],
          const SizedBox(height: 14),
          Row(
            children: [
              _UpvoteButton(post: post),
              const SizedBox(width: 16),
              const Icon(
                Icons.chat_bubble_outline_rounded,
                size: 16,
                color: AppColors.textMuted,
              ),
              const SizedBox(width: 6),
              Text(l10n.cheer, style: textTheme.bodySmall),
            ],
          ),
        ],
      ),
    );
  }
}

class _UpvoteButton extends StatefulWidget {
  const _UpvoteButton({required this.post});

  final FeedPost post;

  @override
  State<_UpvoteButton> createState() => _UpvoteButtonState();
}

class _UpvoteButtonState extends State<_UpvoteButton> {
  double _scale = 1;

  void _onTap() {
    HapticFeedback.selectionClick();
    setState(() => _scale = 1.25);
    AppStore.instance.toggleUpvote(widget.post.id);
    Future<void>.delayed(const Duration(milliseconds: 160), () {
      if (mounted) setState(() => _scale = 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    final post = widget.post;
    final textTheme = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: _onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          children: [
            AnimatedScale(
              scale: _scale,
              duration: const Duration(milliseconds: 160),
              child: Icon(
                Icons.local_fire_department_rounded,
                size: 18,
                color: post.viewerHasUpvoted
                    ? AppColors.accent
                    : AppColors.textMuted,
              ),
            ),
            const SizedBox(width: 6),
            Text(
              '${post.reactions}',
              style: textTheme.bodySmall?.copyWith(
                color: post.viewerHasUpvoted
                    ? AppColors.accent
                    : AppColors.textSecondary,
                fontWeight:
                    post.viewerHasUpvoted ? FontWeight.w700 : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _VisibilityBadge extends StatelessWidget {
  const _VisibilityBadge({required this.visibility});

  final ProgressVisibility visibility;

  @override
  Widget build(BuildContext context) {
    if (visibility == ProgressVisibility.publicFeed) {
      return const SizedBox.shrink();
    }
    final l10n = context.l10n;
    final textTheme = Theme.of(context).textTheme;
    final (icon, label) = switch (visibility) {
      ProgressVisibility.privateOnly => (Icons.lock_rounded, l10n.privateBadge),
      ProgressVisibility.friendsOnly => (
          Icons.group_rounded,
          l10n.friendsOnlyBadge,
        ),
      ProgressVisibility.publicFeed => (
          Icons.public_rounded,
          l10n.publicBadge,
        ),
    };

    return Container(
      margin: const EdgeInsets.only(right: 4),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.accentSoft,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.accentMuted),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: AppColors.accent),
          const SizedBox(width: 4),
          Text(
            label,
            style: textTheme.labelSmall?.copyWith(color: AppColors.accent),
          ),
        ],
      ),
    );
  }
}

class ProgressPhotoBlock extends StatelessWidget {
  const ProgressPhotoBlock({
    super.key,
    required this.label,
    this.weightKg,
    this.height = 180,
  });

  final LocalizedString label;
  final double? weightKg;
  final double height;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final resolved = context.l10nStr(label);
    final shade = resolved.hashCode.abs() % 3;

    return Container(
      height: height,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.accent.withValues(alpha: 0.28 - shade * 0.04),
            AppColors.surfaceElevated,
          ],
        ),
        border: Border.all(color: AppColors.border),
      ),
      child: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.person_rounded,
                  size: 48,
                  color: AppColors.accent,
                ),
                const SizedBox(height: 8),
                Text(resolved, style: textTheme.titleMedium),
              ],
            ),
          ),
          if (weightKg != null)
            Positioned(
              left: 12,
              bottom: 12,
              child: WeightChip(weightKg: weightKg!),
            ),
        ],
      ),
    );
  }
}

class ProgressVideoBlock extends StatelessWidget {
  const ProgressVideoBlock({
    super.key,
    required this.label,
    this.weightKg,
    this.height = 180,
  });

  final LocalizedString label;
  final double? weightKg;
  final double height;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final resolved = context.l10nStr(label);

    return Container(
      height: height,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.accent.withValues(alpha: 0.2),
            const Color(0xFF1A1208),
            AppColors.surfaceElevated,
          ],
        ),
        border: Border.all(color: AppColors.border),
      ),
      child: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.accent.withValues(alpha: 0.2),
                    border: Border.all(color: AppColors.accentMuted),
                  ),
                  child: const Icon(
                    Icons.play_arrow_rounded,
                    size: 32,
                    color: AppColors.accent,
                  ),
                ),
                const SizedBox(height: 10),
                Text(resolved, style: textTheme.titleMedium),
              ],
            ),
          ),
          if (weightKg != null)
            Positioned(
              left: 12,
              bottom: 12,
              child: WeightChip(weightKg: weightKg!),
            ),
        ],
      ),
    );
  }
}

class WeightChip extends StatelessWidget {
  const WeightChip({super.key, required this.weightKg});

  final double weightKg;

  @override
  Widget build(BuildContext context) {
    final display = weightKg % 1 == 0 ? weightKg.toInt() : weightKg;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.accentSoft,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.accentMuted),
      ),
      child: Text(
        context.l10n.weightKgLabel(display),
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: AppColors.accent,
            ),
      ),
    );
  }
}

class ChallengeDetailScreen extends StatelessWidget {
  const ChallengeDetailScreen({super.key, required this.challengeId});

  final String challengeId;

  @override
  Widget build(BuildContext context) {
    final c = MockData.challengeById(challengeId) ?? MockData.challenges.first;
    final l10n = context.l10n;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => context.pop(),
        ),
        title: Text(l10n.challengeTitle),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.l10nStr(c.typeLabel).toUpperCase(),
              style: textTheme.labelMedium?.copyWith(color: AppColors.accent),
            ),
            const SizedBox(height: 8),
            Text(context.l10nStr(c.title), style: textTheme.headlineMedium),
            const SizedBox(height: 8),
            Text(context.l10nStr(c.subtitle), style: textTheme.bodyLarge),
            const SizedBox(height: 28),
            PgCard(
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        '${c.progress} / ${c.goal}',
                        style: textTheme.headlineSmall,
                      ),
                      const Spacer(),
                      Text(
                        l10n.daysLeft(c.daysLeft),
                        style: textTheme.bodyMedium,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  PgProgressBar(value: c.progress / c.goal, height: 10),
                  const SizedBox(height: 16),
                  Text(
                    l10n.participantsCount(c.participants),
                    style: textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
            const Spacer(),
            PgButton(
              label: l10n.viewLeaderboard,
              variant: PgButtonVariant.secondary,
              onPressed: () =>
                  context.push('/challenge/$challengeId/leaderboard'),
            ),
          ],
        ),
      ),
    );
  }
}

class ChallengeLeaderboardScreen extends StatelessWidget {
  const ChallengeLeaderboardScreen({super.key, required this.challengeId});

  final String challengeId;

  @override
  Widget build(BuildContext context) {
    final c = MockData.challengeById(challengeId) ?? MockData.challenges.first;
    final entries = AppStore.instance.leaderboardForChallenge(challengeId);
    final l10n = context.l10n;
    final textTheme = Theme.of(context).textTheme;
    final userRank =
        entries.indexWhere((e) => e.isCurrentUser) + 1;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => context.pop(),
        ),
        title: Text(l10n.leaderboardTitle),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
        children: [
          Text(context.l10nStr(c.title), style: textTheme.headlineSmall),
          const SizedBox(height: 8),
          Text(
            l10n.rankUpSnack(userRank),
            style: textTheme.bodyMedium?.copyWith(color: AppColors.accent),
          ),
          const SizedBox(height: 24),
          for (var i = 0; i < entries.length; i++) ...[
            _LeaderboardTile(
              rank: i + 1,
              entry: entries[i],
            ),
            if (i < entries.length - 1) const SizedBox(height: 10),
          ],
        ],
      ),
    );
  }
}

class _LeaderboardTile extends StatelessWidget {
  const _LeaderboardTile({required this.rank, required this.entry});

  final int rank;
  final LeaderboardEntry entry;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final textTheme = Theme.of(context).textTheme;
    return PgCard(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      child: Row(
        children: [
          SizedBox(
            width: 28,
            child: Text(
              '#$rank',
              style: textTheme.titleMedium?.copyWith(
                color: rank <= 3 ? AppColors.accent : AppColors.textSecondary,
              ),
            ),
          ),
          UserAvatar(name: entry.name, size: 40),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  entry.isCurrentUser
                      ? '${entry.name} (${l10n.youLabel})'
                      : entry.name,
                  style: textTheme.titleMedium,
                ),
              ],
            ),
          ),
          Text(
            '${entry.score}',
            style: textTheme.titleMedium?.copyWith(color: AppColors.accent),
          ),
        ],
      ),
    );
  }
}
