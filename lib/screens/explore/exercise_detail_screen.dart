import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

import '../../data/mock_data.dart';
import '../../l10n/l10n_ext.dart';
import '../../l10n/localized_string.dart';
import '../../theme/app_colors.dart';
import '../../widgets/exercise_image.dart';
import '../../widgets/exercise_youtube_player.dart';
import '../../widgets/pg_button.dart';

class ExerciseDetailScreen extends StatefulWidget {
  const ExerciseDetailScreen({super.key, required this.exerciseId});

  final String exerciseId;

  @override
  State<ExerciseDetailScreen> createState() => _ExerciseDetailScreenState();
}

class _ExerciseDetailScreenState extends State<ExerciseDetailScreen> {
  bool _favoritePressed = false;
  bool _sheetVisible = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      setState(() => _sheetVisible = true);
    });
  }

  void _onFavorite() {
    HapticFeedback.selectionClick();
    setState(() => _favoritePressed = true);
    Future<void>.delayed(const Duration(milliseconds: 160), () {
      if (mounted) setState(() => _favoritePressed = false);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(context.l10n.addedToFavoritesDemo)),
    );
  }

  List<String> _splitCoachLines(String text) {
    final cleaned = text.trim();
    if (cleaned.isEmpty) return const [];

    final byBreak = cleaned
        .split(RegExp(r'[\n•·]+'))
        .map((s) => s.trim())
        .where((s) => s.isNotEmpty)
        .toList();
    if (byBreak.length > 1) return byBreak;

    final bySentence = cleaned
        .split(RegExp(r'(?<=[.!?])\s+'))
        .map((s) => s.trim())
        .where((s) => s.isNotEmpty)
        .toList();
    if (bySentence.length > 1) return bySentence;

    return [cleaned];
  }

  @override
  Widget build(BuildContext context) {
    final ex = MockData.exerciseById(widget.exerciseId) ?? MockData.exercises.first;
    final textTheme = Theme.of(context).textTheme;
    final l10n = context.l10n;
    final topPad = MediaQuery.paddingOf(context).top;
    final instructionSteps = _splitCoachLines(context.l10nStr(ex.instructions));
    final mistakeLines = _splitCoachLines(context.l10nStr(ex.commonMistakes));

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 280 + topPad,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Positioned.fill(
                        child: ExerciseImage(
                          assetPath: ex.imageAsset,
                          borderRadius: 0,
                          height: 280 + topPad,
                        ),
                      ),
                      Positioned(
                        left: 0,
                        right: 0,
                        bottom: 0,
                        height: 120,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                AppColors.background.withValues(alpha: 0),
                                AppColors.background,
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: topPad + 8,
                        left: 16,
                        right: 16,
                        child: Row(
                          children: [
                            _HeroIconButton(
                              icon: Icons.arrow_back_rounded,
                              onTap: () => context.pop(),
                            ),
                            const Spacer(),
                            AnimatedScale(
                              scale: _favoritePressed ? 1.18 : 1,
                              duration: const Duration(milliseconds: 160),
                              curve: Curves.easeOutBack,
                              child: _HeroIconButton(
                                icon: Icons.favorite_border_rounded,
                                onTap: _onFavorite,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Transform.translate(
                  offset: const Offset(0, -24),
                  child: AnimatedOpacity(
                    opacity: _sheetVisible ? 1 : 0,
                    duration: const Duration(milliseconds: 320),
                    curve: Curves.easeOut,
                    child: AnimatedSlide(
                      offset: _sheetVisible ? Offset.zero : const Offset(0, 0.04),
                      duration: const Duration(milliseconds: 360),
                      curve: Curves.easeOutCubic,
                      child: _ContentSheet(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              context.l10nStr(ex.name),
                              style: textTheme.headlineMedium,
                            ),
                            const SizedBox(height: 16),
                            Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: [
                                _MetaChip(
                                  label: context.l10nStr(ex.muscle),
                                  emphasized: true,
                                ),
                                _MetaChip(label: context.l10nStr(ex.type)),
                                _MetaChip(label: context.l10nStr(ex.difficulty)),
                                _MetaChip(
                                  label: context.l10nStr(ex.equipment),
                                  muted: true,
                                ),
                                ...ex.secondaryMuscles.map(
                                  (m) => _MetaChip(
                                    label: context.l10nStr(m),
                                    muted: true,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 32),
                            _SectionLabel(l10n.instructionsTitle),
                            const SizedBox(height: 12),
                            _CoachCard(
                              child: instructionSteps.length > 1
                                  ? Column(
                                      children: [
                                        for (var i = 0;
                                            i < instructionSteps.length;
                                            i++) ...[
                                          if (i > 0) const SizedBox(height: 12),
                                          _NumberedStep(
                                            index: i + 1,
                                            text: instructionSteps[i],
                                          ),
                                        ],
                                      ],
                                    )
                                  : Text(
                                      instructionSteps.first,
                                      style: textTheme.bodyLarge?.copyWith(
                                        height: 1.45,
                                      ),
                                    ),
                            ),
                            const SizedBox(height: 28),
                            _SectionLabel(l10n.commonMistakesTitle),
                            const SizedBox(height: 12),
                            _MistakesCard(lines: mistakeLines),
                            const SizedBox(height: 32),
                            _SectionLabel(l10n.exerciseVideoTitle),
                            const SizedBox(height: 12),
                            ExerciseYoutubePlayer(
                              videoId: ex.youtubeVideoId,
                              borderRadius: 20,
                            ),
                            // Keep clear of the video WebView — platform views
                            // paint above Flutter siblings when they share space.
                            const SizedBox(height: 28),
                            PgButton(
                              label: l10n.addToWorkout,
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(l10n.addedToWorkoutDemo),
                                  ),
                                );
                              },
                            ),
                            SizedBox(
                              height: 16 + MediaQuery.paddingOf(context).bottom,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ContentSheet extends StatelessWidget {
  const _ContentSheet({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: const EdgeInsets.fromLTRB(20, 28, 20, 8),
      child: child,
    );
  }
}

class _HeroIconButton extends StatelessWidget {
  const _HeroIconButton({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black.withValues(alpha: 0.42),
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: SizedBox(
          width: 44,
          height: 44,
          child: Icon(icon, color: Colors.white, size: 22),
        ),
      ),
    );
  }
}

class _MetaChip extends StatelessWidget {
  const _MetaChip({
    required this.label,
    this.emphasized = false,
    this.muted = false,
  });

  final String label;
  final bool emphasized;
  final bool muted;

  @override
  Widget build(BuildContext context) {
    final bg = emphasized
        ? AppColors.accentSoft
        : muted
            ? AppColors.surface
            : AppColors.surfaceElevated;
    final fg = emphasized
        ? AppColors.accent
        : muted
            ? AppColors.textTertiary
            : AppColors.textSecondary;
    final border = emphasized ? AppColors.accentMuted : AppColors.border;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: border),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: fg,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel(this.title);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title.toUpperCase(),
      style: Theme.of(context).textTheme.labelMedium?.copyWith(
            color: AppColors.textTertiary,
            letterSpacing: 1.2,
          ),
    );
  }
}

class _CoachCard extends StatelessWidget {
  const _CoachCard({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surfaceElevated,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: child,
    );
  }
}

class _NumberedStep extends StatelessWidget {
  const _NumberedStep({required this.index, required this.text});

  final int index;
  final String text;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 28,
          height: 28,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppColors.accentSoft,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppColors.accentMuted),
          ),
          child: Text(
            '$index',
            style: textTheme.labelLarge?.copyWith(
              color: AppColors.accent,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              text,
              style: textTheme.bodyLarge?.copyWith(height: 1.45),
            ),
          ),
        ),
      ],
    );
  }
}

class _MistakesCard extends StatelessWidget {
  const _MistakesCard({required this.lines});

  final List<String> lines;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.danger.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.danger.withValues(alpha: 0.28),
        ),
      ),
      child: Column(
        children: [
          for (var i = 0; i < lines.length; i++) ...[
            if (i > 0) const SizedBox(height: 12),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 2),
                  child: Icon(
                    Icons.warning_amber_rounded,
                    size: 18,
                    color: AppColors.danger,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    lines[i],
                    style: textTheme.bodyLarge?.copyWith(
                      height: 1.45,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
