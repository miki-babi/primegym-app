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

typedef _EmotionLabel = String Function(AppLocalizations l10n);

class ProgressPostScreen extends StatefulWidget {
  const ProgressPostScreen({super.key});

  @override
  State<ProgressPostScreen> createState() => _ProgressPostScreenState();
}

class _ProgressPostScreenState extends State<ProgressPostScreen> {
  int _mediaIndex = 0;
  bool _isVideo = false;
  int? _emotionIndex;
  ProgressVisibility _visibility = ProgressVisibility.publicFeed;
  final _weightController = TextEditingController();
  final _captionController = TextEditingController();

  static final _emotions = <(String, _EmotionLabel)>[
    ('🔥', (l) => l.emotionFiredUp),
    ('💪', (l) => l.emotionStrong),
    ('😊', (l) => l.emotionHappy),
    ('😌', (l) => l.emotionCalm),
    ('😤', (l) => l.emotionDetermined),
    ('🤩', (l) => l.emotionProud),
  ];

  List<LocalizedString> get _mediaOptions =>
      _isVideo ? MockData.progressVideoOptions : MockData.progressPhotoOptions;

  LocalizedString get _mediaLabel => _mediaOptions[_mediaIndex];

  @override
  void dispose() {
    _weightController.dispose();
    _captionController.dispose();
    super.dispose();
  }

  void _cycleMedia() {
    setState(() {
      _mediaIndex = (_mediaIndex + 1) % _mediaOptions.length;
    });
  }

  void _setMediaType(bool video) {
    setState(() {
      _isVideo = video;
      _mediaIndex = 0;
    });
  }

  LocalizedString _ls(String Function(AppLocalizations l) pick) {
    return LocalizedString(
      en: pick(lookupAppLocalizations(const Locale('en'))),
      am: pick(lookupAppLocalizations(const Locale('am'))),
      om: pick(lookupAppLocalizations(const Locale('om'))),
    );
  }

  void _submit() {
    final l10n = context.l10n;
    if (_emotionIndex == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.pickHowYouFeel)),
      );
      return;
    }

    final caption = _captionController.text.trim();
    final weightText = _weightController.text.trim().replaceAll(',', '.');
    double? weight;
    if (weightText.isNotEmpty) {
      weight = double.tryParse(weightText);
      if (weight == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.enterValidWeightKg)),
        );
        return;
      }
    }

    final emotion = _emotions[_emotionIndex!];
    final meta = _ls(emotion.$2);
    final body = caption.isEmpty
        ? _ls((l) => l.feelingEmotionToday(emotion.$2(l)))
        : LocalizedString(en: caption, am: caption, om: caption);

    final post = FeedPost(
      id: 'local-${DateTime.now().millisecondsSinceEpoch}',
      author: MockData.currentUser,
      type: _ls((l) => l.feedTypeProgress),
      body: body,
      timeAgo: _ls((l) => l.justNow),
      reactions: 0,
      photoLabel: _isVideo ? null : _mediaLabel,
      videoLabel: _isVideo ? _mediaLabel : null,
      media: [
        ProgressMediaItem(
          kind: _isVideo ? ProgressMediaKind.video : ProgressMediaKind.photo,
          label: _mediaLabel,
        ),
      ],
      weightKg: weight,
      emotionEmoji: emotion.$1,
      meta: meta,
      visibility: _visibility,
      postedAt: DateTime.now(),
    );
    AppStore.instance.addPost(post);
    context.pop(post);
  }

  String _visibilityHint(AppLocalizations l10n) {
    switch (_visibility) {
      case ProgressVisibility.privateOnly:
        return l10n.visibilityPrivateHint;
      case ProgressVisibility.friendsOnly:
        return l10n.visibilityFriendsHint;
      case ProgressVisibility.publicFeed:
        return l10n.visibilityPublicHint;
    }
  }

  String _submitLabel(AppLocalizations l10n) {
    switch (_visibility) {
      case ProgressVisibility.privateOnly:
        return l10n.postPrivately;
      case ProgressVisibility.friendsOnly:
        return l10n.visibilityFriends;
      case ProgressVisibility.publicFeed:
        return l10n.postProgress;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close_rounded),
          onPressed: () => context.pop(),
        ),
        title: Text(l10n.postProgressTitle),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 120),
        children: [
          Text(
            l10n.mediaTypeLabel.toUpperCase(),
            style: textTheme.labelMedium?.copyWith(
              color: AppColors.accent,
              letterSpacing: 1.1,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _MediaTypeChip(
                  label: l10n.mediaPhoto,
                  selected: !_isVideo,
                  icon: Icons.photo_camera_rounded,
                  onTap: () => _setMediaType(false),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _MediaTypeChip(
                  label: l10n.mediaVideo,
                  selected: _isVideo,
                  icon: Icons.videocam_rounded,
                  onTap: () => _setMediaType(true),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          GestureDetector(
            onTap: _cycleMedia,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              height: 220,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppColors.accent.withValues(alpha: 0.35 - _mediaIndex * 0.06),
                    AppColors.surfaceElevated,
                    AppColors.background,
                  ],
                ),
                border: Border.all(color: AppColors.accentMuted),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.accent.withValues(alpha: 0.2),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          _isVideo
                              ? Icons.play_circle_filled_rounded
                              : Icons.photo_camera_rounded,
                          size: 48,
                          color: AppColors.accent,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          context.l10nStr(_mediaLabel),
                          style: textTheme.titleLarge,
                        ),
                        const SizedBox(height: 6),
                        Text(
                          _isVideo
                              ? l10n.tapToChangeVideoDemo
                              : l10n.tapToChangePhotoDemo,
                          style: textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    right: 14,
                    top: 14,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.accentSoft,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.accentMuted),
                      ),
                      child: Text(
                        '${_mediaIndex + 1}/${_mediaOptions.length}',
                        style: textTheme.labelSmall?.copyWith(
                          color: AppColors.accent,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 28),
          Text(l10n.howDoYouFeel, style: textTheme.titleMedium),
          const SizedBox(height: 12),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              for (var i = 0; i < _emotions.length; i++)
                GestureDetector(
                  onTap: () => setState(() => _emotionIndex = i),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 180),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: _emotionIndex == i
                          ? AppColors.accentSoft
                          : AppColors.surface,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: _emotionIndex == i
                            ? AppColors.accent
                            : AppColors.border,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          _emotions[i].$1,
                          style: const TextStyle(fontSize: 22),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          _emotions[i].$2(l10n),
                          style: textTheme.labelLarge?.copyWith(
                            color: _emotionIndex == i
                                ? AppColors.accent
                                : AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 28),
          Text(l10n.weightOptional, style: textTheme.titleMedium),
          const SizedBox(height: 8),
          TextField(
            controller: _weightController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]')),
            ],
            decoration: InputDecoration(
              hintText: l10n.weightHint,
              suffixText: l10n.unitKg,
            ),
          ),
          const SizedBox(height: 24),
          Text(l10n.captionOptional, style: textTheme.titleMedium),
          const SizedBox(height: 8),
          TextField(
            controller: _captionController,
            maxLines: 4,
            textCapitalization: TextCapitalization.sentences,
            decoration: InputDecoration(
              hintText: l10n.captionHint,
            ),
          ),
          const SizedBox(height: 24),
          Text(l10n.visibilityLabel, style: textTheme.titleMedium),
          const SizedBox(height: 12),
          Row(
            children: [
              for (final v in ProgressVisibility.values) ...[
                if (v != ProgressVisibility.values.first)
                  const SizedBox(width: 8),
                Expanded(
                  child: _VisibilityChip(
                    visibility: v,
                    selected: _visibility == v,
                    onTap: () => setState(() => _visibility = v),
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: 10),
          Text(
            _visibilityHint(l10n),
            style: textTheme.bodySmall?.copyWith(color: AppColors.textMuted),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
          child: PgButton(
            label: _submitLabel(l10n),
            onPressed: _submit,
          ),
        ),
      ),
    );
  }
}

class _MediaTypeChip extends StatelessWidget {
  const _MediaTypeChip({
    required this.label,
    required this.selected,
    required this.icon,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: selected ? AppColors.accentSoft : AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: selected ? AppColors.accent : AppColors.border,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 18,
              color: selected ? AppColors.accent : AppColors.textMuted,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: selected ? AppColors.accent : AppColors.textSecondary,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

class _VisibilityChip extends StatelessWidget {
  const _VisibilityChip({
    required this.visibility,
    required this.selected,
    required this.onTap,
  });

  final ProgressVisibility visibility;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final (icon, label) = switch (visibility) {
      ProgressVisibility.privateOnly => (
          Icons.lock_rounded,
          l10n.visibilityPrivate,
        ),
      ProgressVisibility.friendsOnly => (
          Icons.group_rounded,
          l10n.visibilityFriends,
        ),
      ProgressVisibility.publicFeed => (
          Icons.public_rounded,
          l10n.visibilityPublic,
        ),
    };

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: selected ? AppColors.accentSoft : AppColors.surface,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: selected ? AppColors.accent : AppColors.border,
          ),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              size: 18,
              color: selected ? AppColors.accent : AppColors.textMuted,
            ),
            const SizedBox(height: 6),
            Text(
              label,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color:
                        selected ? AppColors.accent : AppColors.textSecondary,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
