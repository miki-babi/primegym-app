import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../data/app_store.dart';
import '../../data/mock_data.dart';
import '../../l10n/l10n_ext.dart';
import '../../l10n/localized_string.dart';
import '../../models/models.dart';
import '../../theme/app_colors.dart';
import '../../widgets/exercise_image.dart';
import '../../widgets/pg_button.dart';
import '../../widgets/pg_card.dart';
import '../../widgets/section_header.dart';
import '../../widgets/user_avatar.dart';
import 'community_screens.dart';

class ProgressPostDetailScreen extends StatelessWidget {
  const ProgressPostDetailScreen({super.key, required this.postId});

  final String postId;

  @override
  Widget build(BuildContext context) {
    final store = AppStore.instance;
    final post = store.postById(postId);
    final l10n = context.l10n;
    final textTheme = Theme.of(context).textTheme;

    if (post == null || !store.canViewerSee(post)) {
      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_rounded),
            onPressed: () => context.pop(),
          ),
          title: Text(l10n.progressDetailTitle),
        ),
        body: Center(child: Text(l10n.progressNotFound)),
      );
    }

    final live = store.postById(post.id) ?? post;
    final exercises = [
      for (final id in live.exerciseIds)
        if (MockData.exerciseById(id) != null) MockData.exerciseById(id)!,
    ];

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => context.pop(),
        ),
        title: Text(l10n.progressDetailTitle),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
        children: [
          GestureDetector(
            onTap: () => context.push('/friend/${Uri.encodeComponent(live.author)}'),
            behavior: HitTestBehavior.opaque,
            child: Row(
              children: [
                UserAvatar(name: live.author, size: 48),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(live.author, style: textTheme.titleLarge),
                      Text(
                        '${context.l10nStr(live.type)} · ${context.l10nStr(live.timeAgo)}',
                        style: textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
                _DetailVisibilityBadge(visibility: live.visibility),
                if (live.emotionEmoji != null) ...[
                  const SizedBox(width: 8),
                  Text(live.emotionEmoji!, style: const TextStyle(fontSize: 28)),
                ],
              ],
            ),
          ),
          if (live.resolvedMedia.isNotEmpty) ...[
            const SizedBox(height: 20),
            _ProgressMediaCarousel(
              media: live.resolvedMedia,
              weightKg: live.weightKg,
            ),
          ],
          if (context.l10nStr(live.body).isNotEmpty) ...[
            const SizedBox(height: 20),
            Text(context.l10nStr(live.body), style: textTheme.bodyLarge),
          ],
          if (live.meta != null) ...[
            const SizedBox(height: 12),
            Text(
              live.emotionEmoji != null
                  ? '${live.emotionEmoji} ${context.l10nStr(live.meta!)}'
                  : context.l10nStr(live.meta!),
              style: textTheme.bodyMedium?.copyWith(color: AppColors.accent),
            ),
          ],
          if (live.weightKg != null && !live.hasMedia) ...[
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerLeft,
              child: WeightChip(weightKg: live.weightKg!),
            ),
          ],
          const SizedBox(height: 20),
          _DetailUpvoteRow(post: live),
          if (live.workoutSessionId != null) ...[
            Builder(
              builder: (context) {
                final session =
                    AppStore.instance.sessionById(live.workoutSessionId!);
                if (session == null) return const SizedBox.shrink();
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 28),
                    SectionHeader(title: l10n.friendWorkoutSection),
                    const SizedBox(height: 12),
                    _WorkoutSessionSummaryCard(session: session),
                  ],
                );
              },
            ),
          ] else if (exercises.isNotEmpty) ...[
            const SizedBox(height: 28),
            SectionHeader(title: l10n.friendExercises),
            const SizedBox(height: 12),
            for (final ex in exercises) ...[
              _ExerciseRow(exercise: ex),
              const SizedBox(height: 10),
            ],
          ],
        ],
      ),
    );
  }
}

class _ProgressMediaCarousel extends StatefulWidget {
  const _ProgressMediaCarousel({
    required this.media,
    this.weightKg,
  });

  final List<ProgressMediaItem> media;
  final double? weightKg;

  @override
  State<_ProgressMediaCarousel> createState() => _ProgressMediaCarouselState();
}

class _ProgressMediaCarouselState extends State<_ProgressMediaCarousel> {
  late final PageController _controller;
  int _index = 0;

  @override
  void initState() {
    super.initState();
    _controller = PageController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _goTo(int index) {
    if (index == _index) return;
    _controller.animateToPage(
      index,
      duration: const Duration(milliseconds: 240),
      curve: Curves.easeOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    final media = widget.media;
    final textTheme = Theme.of(context).textTheme;
    final count = media.length;

    return Column(
      children: [
        SizedBox(
          height: 220,
          child: PageView.builder(
            controller: _controller,
            itemCount: count,
            onPageChanged: (i) => setState(() => _index = i),
            itemBuilder: (context, i) {
              final item = media[i];
              final weight = i == 0 ? widget.weightKg : null;
              return switch (item.kind) {
                ProgressMediaKind.photo => ProgressPhotoBlock(
                    label: item.label,
                    weightKg: weight,
                    height: 220,
                  ),
                ProgressMediaKind.video => ProgressVideoBlock(
                    label: item.label,
                    weightKg: weight,
                    height: 220,
                  ),
              };
            },
          ),
        ),
        if (count > 1) ...[
          const SizedBox(height: 12),
          SizedBox(
            height: 56,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: count,
              separatorBuilder: (_, _) => const SizedBox(width: 8),
              itemBuilder: (context, i) {
                final item = media[i];
                final selected = i == _index;
                final label = context.l10nStr(item.label);
                final shade = label.hashCode.abs() % 3;
                return Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () => _goTo(i),
                    borderRadius: BorderRadius.circular(12),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 180),
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: selected
                              ? AppColors.accent
                              : AppColors.border,
                          width: selected ? 2 : 1,
                        ),
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            AppColors.accent.withValues(
                              alpha: 0.28 - shade * 0.04,
                            ),
                            AppColors.surfaceElevated,
                          ],
                        ),
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Icon(
                            item.kind == ProgressMediaKind.video
                                ? Icons.play_arrow_rounded
                                : Icons.image_outlined,
                            size: 22,
                            color: selected
                                ? AppColors.accent
                                : AppColors.textSecondary,
                          ),
                          if (item.kind == ProgressMediaKind.video)
                            Positioned(
                              right: 4,
                              bottom: 4,
                              child: Icon(
                                Icons.videocam_rounded,
                                size: 12,
                                color: AppColors.accent.withValues(alpha: 0.9),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '${_index + 1}/$count',
            style: textTheme.labelSmall?.copyWith(
              color: AppColors.textMuted,
            ),
          ),
        ],
      ],
    );
  }
}

class FriendProfileScreen extends StatefulWidget {
  const FriendProfileScreen({super.key, required this.friendName});

  final String friendName;

  @override
  State<FriendProfileScreen> createState() => _FriendProfileScreenState();
}

class _FriendProfileScreenState extends State<FriendProfileScreen>
    with TickerProviderStateMixin {
  late final TabController _tabController;
  late final AnimationController _enterController;
  late final Animation<double> _avatarScale;
  late final Animation<double> _glowOpacity;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _enterController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 420),
    );
    _avatarScale = Tween<double>(begin: 0.88, end: 1).animate(
      CurvedAnimation(
        parent: _enterController,
        curve: const Interval(0, 0.65, curve: Curves.easeOutCubic),
      ),
    );
    _glowOpacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _enterController,
        curve: const Interval(0, 0.55, curve: Curves.easeOut),
      ),
    );
    _enterController.forward();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _enterController.dispose();
    super.dispose();
  }

  String _formatCount(int n) {
    if (n >= 1000000) {
      final v = n / 1000000;
      return '${v.toStringAsFixed(v.truncateToDouble() == v ? 0 : 1)}M';
    }
    if (n >= 1000) {
      final v = n / 1000;
      return '${v.toStringAsFixed(v.truncateToDouble() == v ? 0 : 1)}K';
    }
    return '$n';
  }

  @override
  Widget build(BuildContext context) {
    final name = Uri.decodeComponent(widget.friendName);
    final profile = AppStore.instance.friendProfile(name);
    final l10n = context.l10n;
    final textTheme = Theme.of(context).textTheme;

    if (profile == null) {
      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_rounded),
            onPressed: () => context.pop(),
          ),
          title: Text(l10n.friendProfile),
        ),
        body: Center(child: Text(l10n.friendNotFound)),
      );
    }

    final status = profile.status;
    final handle =
        status.handle.isEmpty ? '@${status.name.toLowerCase()}' : status.handle;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => context.pop(),
        ),
        title: Text(l10n.friendProfile),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 4, 20, 0),
            child: ListenableBuilder(
              listenable: AppStore.instance,
              builder: (context, _) {
                final following = AppStore.instance.isFollowing(status.name);
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        AnimatedBuilder(
                          animation: _enterController,
                          builder: (context, child) {
                            return Transform.scale(
                              scale: _avatarScale.value,
                              child: SizedBox(
                                width: 96,
                                height: 96,
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Opacity(
                                      opacity: _glowOpacity.value,
                                      child: Container(
                                        width: 96,
                                        height: 96,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          gradient: RadialGradient(
                                            colors: [
                                              AppColors.accent.withValues(
                                                alpha: 0.28,
                                              ),
                                              AppColors.accent.withValues(
                                                alpha: 0,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    child!,
                                  ],
                                ),
                              ),
                            );
                          },
                          child: UserAvatar(
                            name: status.name,
                            size: 88,
                            showOnline: true,
                            online: status.isTraining,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: status.name,
                                  style: textTheme.titleLarge,
                                ),
                                TextSpan(
                                  text: '  |  ',
                                  style: textTheme.titleMedium?.copyWith(
                                    color: AppColors.textMuted,
                                  ),
                                ),
                                TextSpan(
                                  text: handle,
                                  style: textTheme.titleMedium?.copyWith(
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        _SocialStat(
                          value: _formatCount(status.followingCount),
                          label: l10n.friendStatFollowing,
                        ),
                        _SocialStat(
                          value: _formatCount(status.followersCount),
                          label: l10n.friendStatFollowers,
                        ),
                        _SocialStat(
                          value: _formatCount(status.likesCount),
                          label: l10n.friendStatUpvotes,
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: PgButton(
                            label: following
                                ? l10n.friendFollowing
                                : l10n.friendFollow,
                            variant: following
                                ? PgButtonVariant.secondary
                                : PgButtonVariant.primary,
                            height: 44,
                            onPressed: () =>
                                AppStore.instance.toggleFollow(status.name),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: PgButton(
                            label: l10n.friendMessage,
                            variant: PgButtonVariant.secondary,
                            height: 44,
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(l10n.friendInboxComingSoon),
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(width: 10),
                        Material(
                          color: AppColors.accentSoft,
                          borderRadius: BorderRadius.circular(16),
                          child: InkWell(
                            onTap: () {
                              showModalBottomSheet<void>(
                                context: context,
                                backgroundColor: AppColors.surface,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(24),
                                  ),
                                ),
                                builder: (context) => _ShareProfileSheet(
                                  name: status.name,
                                  handle: handle,
                                ),
                              );
                            },
                            borderRadius: BorderRadius.circular(16),
                            child: const SizedBox(
                              width: 44,
                              height: 44,
                              child: Icon(
                                Icons.ios_share_rounded,
                                color: AppColors.accent,
                                size: 22,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    if (context.l10nStr(status.bio).isNotEmpty) ...[
                      const SizedBox(height: 12),
                      Text(
                        context.l10nStr(status.bio),
                        style: textTheme.bodySmall?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ],
                );
              },
            ),
          ),
          const SizedBox(height: 12),
          TabBar(
            controller: _tabController,
            indicatorColor: AppColors.accent,
            labelColor: AppColors.accent,
            unselectedLabelColor: AppColors.textMuted,
            tabs: [
              Tab(text: l10n.friendTabProgress),
              Tab(text: l10n.friendTabWorkouts),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _ProgressTimelineTab(posts: profile.posts),
                _WorkoutTimelineTab(workouts: profile.workouts),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SocialStat extends StatelessWidget {
  const _SocialStat({required this.value, required this.label});

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: textTheme.labelSmall?.copyWith(color: AppColors.textMuted),
          ),
        ],
      ),
    );
  }
}

class _ShareProfileSheet extends StatelessWidget {
  const _ShareProfileSheet({
    required this.name,
    required this.handle,
  });

  final String name;
  final String handle;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final textTheme = Theme.of(context).textTheme;
    final bottomInset = MediaQuery.paddingOf(context).bottom;
    final link =
        'https://primegym.app/friend/${Uri.encodeComponent(name)}';

    return Padding(
      padding: EdgeInsets.fromLTRB(20, 12, 20, 16 + bottomInset),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.border,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(l10n.friendShareProfile, style: textTheme.titleLarge),
          const SizedBox(height: 6),
          Text(
            '$name · $handle',
            style: textTheme.bodyMedium?.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 20),
          Material(
            color: AppColors.surfaceElevated,
            borderRadius: BorderRadius.circular(16),
            child: InkWell(
              onTap: () async {
                await Clipboard.setData(ClipboardData(text: link));
                if (!context.mounted) return;
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(l10n.friendLinkCopied)),
                );
              },
              borderRadius: BorderRadius.circular(16),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
                child: Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: AppColors.accentSoft,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.accentMuted),
                      ),
                      child: const Icon(
                        Icons.link_rounded,
                        color: AppColors.accent,
                        size: 22,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        l10n.friendCopyLink,
                        style: textTheme.titleSmall,
                      ),
                    ),
                    const Icon(
                      Icons.copy_rounded,
                      size: 18,
                      color: AppColors.textMuted,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

String _formatDayLabel(BuildContext context, DateTime date) {
  final locale = Localizations.localeOf(context).toString();
  return DateFormat.yMMMd(locale).format(date);
}

String _formatKg(double kg) {
  return kg % 1 == 0 ? kg.toInt().toString() : kg.toStringAsFixed(1);
}

class _DayTimelineSection extends StatelessWidget {
  const _DayTimelineSection({
    required this.dateLabel,
    required this.children,
    this.isLast = false,
  });

  final String dateLabel;
  final List<Widget> children;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            width: 20,
            child: Column(
              children: [
                Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.accent,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.accent.withValues(alpha: 0.35),
                        blurRadius: 6,
                      ),
                    ],
                  ),
                ),
                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 2,
                      margin: const EdgeInsets.only(top: 4),
                      color: AppColors.border,
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  dateLabel,
                  style: textTheme.labelMedium?.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 12),
                ...children,
                SizedBox(height: isLast ? 0 : 16),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ProgressTimelineTab extends StatelessWidget {
  const _ProgressTimelineTab({required this.posts});

  final List<FeedPost> posts;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final textTheme = Theme.of(context).textTheme;

    if (posts.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Text(
            l10n.noFriendProgressYet,
            textAlign: TextAlign.center,
            style: textTheme.bodyMedium?.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
      itemCount: posts.length,
      separatorBuilder: (_, _) => const SizedBox(height: 12),
      itemBuilder: (context, index) => _FriendProgressCard(post: posts[index]),
    );
  }
}

class _FriendProgressCard extends StatelessWidget {
  const _FriendProgressCard({required this.post});

  final FeedPost post;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final body = context.l10nStr(post.body);

    return ListenableBuilder(
      listenable: AppStore.instance,
      builder: (context, _) {
        final live = AppStore.instance.postById(post.id) ?? post;
        final caption = body.isNotEmpty
            ? body
            : (live.meta != null ? context.l10nStr(live.meta!) : '');

        return PgCard(
          padding: const EdgeInsets.all(12),
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                GestureDetector(
                  onTap: () => context.push('/progress/${live.id}'),
                  child: _ProgressThumb(post: live),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () => context.push('/progress/${live.id}'),
                          behavior: HitTestBehavior.opaque,
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              caption.isEmpty ? '—' : caption,
                              style: textTheme.titleSmall,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: _ProgressUpvoteButton(post: live),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _ProgressThumb extends StatelessWidget {
  const _ProgressThumb({required this.post});

  final FeedPost post;

  static const double size = 88;

  @override
  Widget build(BuildContext context) {
    final primary = post.primaryMedia;
    final isVideo = primary?.kind == ProgressMediaKind.video;
    final hasMedia = primary != null;
    final label = hasMedia ? context.l10nStr(primary.label) : '';
    final shade = label.hashCode.abs() % 3;

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        gradient: hasMedia
            ? LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColors.accent.withValues(alpha: 0.28 - shade * 0.04),
                  AppColors.surfaceElevated,
                ],
              )
            : null,
        color: hasMedia ? null : AppColors.surfaceElevated,
        border: Border.all(color: AppColors.border),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          if (!isVideo)
            Icon(
              Icons.image_outlined,
              size: 28,
              color: hasMedia ? AppColors.accent : AppColors.textMuted,
            ),
          if (isVideo)
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.accent.withValues(alpha: 0.22),
                border: Border.all(color: AppColors.accentMuted),
              ),
              child: const Icon(
                Icons.play_arrow_rounded,
                size: 22,
                color: AppColors.accent,
              ),
            ),
        ],
      ),
    );
  }
}

class _ProgressUpvoteButton extends StatefulWidget {
  const _ProgressUpvoteButton({required this.post});

  final FeedPost post;

  @override
  State<_ProgressUpvoteButton> createState() => _ProgressUpvoteButtonState();
}

class _ProgressUpvoteButtonState extends State<_ProgressUpvoteButton> {
  double _scale = 1;

  void _onTap() {
    HapticFeedback.selectionClick();
    setState(() => _scale = 1.2);
    AppStore.instance.toggleUpvote(widget.post.id);
    Future<void>.delayed(const Duration(milliseconds: 160), () {
      if (mounted) setState(() => _scale = 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    final post = AppStore.instance.postById(widget.post.id) ?? widget.post;
    final textTheme = Theme.of(context).textTheme;
    final active = post.viewerHasUpvoted;

    return Material(
      color: active ? AppColors.accentSoft : AppColors.surfaceElevated,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        onTap: _onTap,
        borderRadius: BorderRadius.circular(20),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 160),
          constraints: const BoxConstraints(minHeight: 44, minWidth: 44),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: active ? AppColors.accent : AppColors.border,
              width: active ? 1.5 : 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedScale(
                scale: _scale,
                duration: const Duration(milliseconds: 160),
                child: Icon(
                  Icons.local_fire_department_rounded,
                  size: 20,
                  color: active ? AppColors.accent : AppColors.textSecondary,
                ),
              ),
              const SizedBox(width: 6),
              Text(
                '${post.reactions}',
                style: textTheme.labelLarge?.copyWith(
                  color: active ? AppColors.accent : AppColors.textPrimary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _WorkoutTimelineTab extends StatelessWidget {
  const _WorkoutTimelineTab({required this.workouts});

  final List<FriendWorkoutSession> workouts;

  Map<DateTime, List<FriendWorkoutSession>> _groupByDay(
    List<FriendWorkoutSession> list,
  ) {
    final map = <DateTime, List<FriendWorkoutSession>>{};
    for (final session in list) {
      final day = DateTime(
        session.date.year,
        session.date.month,
        session.date.day,
      );
      map.putIfAbsent(day, () => []).add(session);
    }
    final keys = map.keys.toList()..sort((a, b) => b.compareTo(a));
    return {for (final k in keys) k: map[k]!};
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final textTheme = Theme.of(context).textTheme;

    if (workouts.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Text(
            l10n.noFriendWorkoutsYet,
            textAlign: TextAlign.center,
            style: textTheme.bodyMedium?.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ),
      );
    }

    final grouped = _groupByDay(workouts);
    final entries = grouped.entries.toList();

    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
      children: [
        for (var i = 0; i < entries.length; i++)
          _DayTimelineSection(
            dateLabel: _formatDayLabel(context, entries[i].key),
            isLast: i == entries.length - 1,
            children: [
              for (final session in entries[i].value) ...[
                _WorkoutSessionCard(session: session),
                const SizedBox(height: 12),
              ],
            ],
          ),
      ],
    );
  }
}

class _WorkoutSessionSummaryCard extends StatelessWidget {
  const _WorkoutSessionSummaryCard({required this.session});

  final FriendWorkoutSession session;

  int get _totalSets =>
      session.sets.fold<int>(0, (sum, s) => sum + s.sets);

  double get _volumeKg => session.sets.fold<double>(
        0,
        (sum, s) => sum + (s.sets * s.reps * s.weightKg),
      );

  void _openExercises(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => _WorkoutExercisesSheet(session: session),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final textTheme = Theme.of(context).textTheme;
    final stats = [
      l10n.friendWorkoutExercises(session.sets.length),
      l10n.friendWorkoutSets(_totalSets),
      l10n.friendWorkoutVolumeShort(_formatKg(_volumeKg)),
    ];

    return PgCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.l10nStr(session.title),
            style: textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              for (var i = 0; i < stats.length; i++) ...[
                if (i > 0) ...[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      '|',
                      style: textTheme.titleSmall?.copyWith(
                        color: AppColors.textMuted,
                      ),
                    ),
                  ),
                ],
                Flexible(
                  child: Text(
                    stats[i],
                    style: textTheme.titleSmall?.copyWith(
                      color: AppColors.textSecondary,
                      fontWeight: FontWeight.w600,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: 16),
          Align(
            alignment: Alignment.centerRight,
            child: Material(
              color: AppColors.accentSoft,
              borderRadius: BorderRadius.circular(12),
              child: InkWell(
                onTap: () => _openExercises(context),
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  constraints: const BoxConstraints(minHeight: 44),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.accentMuted),
                  ),
                  child: Text(
                    l10n.seeMore,
                    style: textTheme.labelLarge?.copyWith(
                      color: AppColors.accent,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _WorkoutExercisesSheet extends StatelessWidget {
  const _WorkoutExercisesSheet({required this.session});

  final FriendWorkoutSession session;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final textTheme = Theme.of(context).textTheme;
    final bottomInset = MediaQuery.paddingOf(context).bottom;

    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.55,
      minChildSize: 0.4,
      maxChildSize: 0.9,
      builder: (context, scrollController) {
        return ListenableBuilder(
          listenable: AppStore.instance,
          builder: (context, _) {
            final saved = AppStore.instance.isWorkoutSaved(session.id);
            return Padding(
              padding: EdgeInsets.fromLTRB(20, 12, 20, 16 + bottomInset),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: AppColors.border,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    context.l10nStr(session.title),
                    style: textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: ListView.separated(
                      controller: scrollController,
                      itemCount: session.sets.length,
                      separatorBuilder: (_, _) => const Divider(
                        height: 16,
                        color: AppColors.border,
                      ),
                      itemBuilder: (context, index) {
                        final set = session.sets[index];
                        return _WorkoutSetRow(
                          set: set,
                          detailLabel: l10n.workoutSetsRepsWeight(
                            set.sets,
                            set.reps,
                            _formatKg(set.weightKg),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 12),
                  PgButton(
                    label: saved ? l10n.removeFromSaved : l10n.saveForLater,
                    variant: saved
                        ? PgButtonVariant.secondary
                        : PgButtonVariant.primary,
                    onPressed: () {
                      if (saved) {
                        AppStore.instance.unsaveWorkoutForLater(session.id);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(l10n.removedFromSavedSnack),
                          ),
                        );
                      } else {
                        AppStore.instance.saveWorkoutForLater(session.id);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(l10n.savedForLaterSnack),
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

class _WorkoutSessionCard extends StatelessWidget {
  const _WorkoutSessionCard({required this.session});

  final FriendWorkoutSession session;

  int get _totalSets =>
      session.sets.fold<int>(0, (sum, s) => sum + s.sets);

  double get _volumeKg => session.sets.fold<double>(
        0,
        (sum, s) => sum + (s.sets * s.reps * s.weightKg),
      );

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final textTheme = Theme.of(context).textTheme;
    final metaParts = [
      l10n.friendWorkoutExercises(session.sets.length),
      l10n.friendWorkoutSets(_totalSets),
      l10n.friendWorkoutVolume(_formatKg(_volumeKg)),
    ];

    return PgCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.l10nStr(session.title),
            style: textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Text(
            metaParts.join(' · '),
            style: textTheme.bodySmall?.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 16),
          for (var i = 0; i < session.sets.length; i++) ...[
            if (i > 0) ...[
              const SizedBox(height: 4),
              const Divider(height: 16, color: AppColors.border),
            ],
            _WorkoutSetRow(
              set: session.sets[i],
              detailLabel: l10n.workoutSetsRepsWeight(
                session.sets[i].sets,
                session.sets[i].reps,
                _formatKg(session.sets[i].weightKg),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _WorkoutSetRow extends StatelessWidget {
  const _WorkoutSetRow({
    required this.set,
    required this.detailLabel,
  });

  final FriendWorkoutSet set;
  final String detailLabel;

  @override
  Widget build(BuildContext context) {
    final exercise = MockData.exerciseById(set.exerciseId);
    final textTheme = Theme.of(context).textTheme;
    if (exercise == null) return const SizedBox.shrink();

    return InkWell(
      onTap: () => context.push('/exercise/${exercise.id}'),
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          children: [
            ExerciseImage(
              assetPath: exercise.imageAsset,
              width: 52,
              height: 52,
              borderRadius: 12,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    context.l10nStr(exercise.name),
                    style: textTheme.titleSmall,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    detailLabel,
                    style: textTheme.bodySmall?.copyWith(
                      color: AppColors.textSecondary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ExerciseRow extends StatelessWidget {
  const _ExerciseRow({required this.exercise});

  final ExerciseItem exercise;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return PgCard(
      onTap: () => context.push('/exercise/${exercise.id}'),
      padding: const EdgeInsets.all(14),
      child: Row(
        children: [
          ExerciseImage(
            assetPath: exercise.imageAsset,
            width: 52,
            height: 52,
            borderRadius: 12,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.l10nStr(exercise.name),
                  style: textTheme.titleMedium,
                ),
                const SizedBox(height: 4),
                Text(
                  '${context.l10nStr(exercise.muscle)} · ${context.l10nStr(exercise.difficulty)}',
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
  }
}

class _DetailUpvoteRow extends StatefulWidget {
  const _DetailUpvoteRow({required this.post});

  final FeedPost post;

  @override
  State<_DetailUpvoteRow> createState() => _DetailUpvoteRowState();
}

class _DetailUpvoteRowState extends State<_DetailUpvoteRow> {
  double _scale = 1;

  void _onTap() {
    HapticFeedback.selectionClick();
    setState(() => _scale = 1.2);
    AppStore.instance.toggleUpvote(widget.post.id);
    Future<void>.delayed(const Duration(milliseconds: 160), () {
      if (mounted) setState(() => _scale = 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    final post = AppStore.instance.postById(widget.post.id) ?? widget.post;
    final textTheme = Theme.of(context).textTheme;
    final active = post.viewerHasUpvoted;
    final l10n = context.l10n;

    return Align(
      alignment: Alignment.centerRight,
      child: Material(
        color: active ? AppColors.accentSoft : AppColors.surfaceElevated,
        borderRadius: BorderRadius.circular(20),
        child: InkWell(
          onTap: _onTap,
          borderRadius: BorderRadius.circular(20),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 160),
            constraints: const BoxConstraints(minHeight: 44),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: active ? AppColors.accent : AppColors.border,
                width: active ? 1.5 : 1,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                AnimatedScale(
                  scale: _scale,
                  duration: const Duration(milliseconds: 160),
                  child: Icon(
                    Icons.local_fire_department_rounded,
                    size: 22,
                    color: active ? AppColors.accent : AppColors.textSecondary,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  '${post.reactions}',
                  style: textTheme.titleMedium?.copyWith(
                    color: active ? AppColors.accent : AppColors.textPrimary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  l10n.upvote,
                  style: textTheme.labelLarge?.copyWith(
                    color: active ? AppColors.accent : AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _DetailVisibilityBadge extends StatelessWidget {
  const _DetailVisibilityBadge({required this.visibility});

  final ProgressVisibility visibility;

  @override
  Widget build(BuildContext context) {
    if (visibility == ProgressVisibility.publicFeed) {
      return const SizedBox.shrink();
    }
    final l10n = context.l10n;
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
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: AppColors.accent,
                ),
          ),
        ],
      ),
    );
  }
}
