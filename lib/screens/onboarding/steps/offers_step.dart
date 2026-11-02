import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../l10n/l10n_ext.dart';
import '../../../theme/app_colors.dart';
import '../../../widgets/pg_button.dart';

class OffersStep extends StatefulWidget {
  const OffersStep({super.key, required this.onGetStarted});

  final VoidCallback onGetStarted;

  @override
  State<OffersStep> createState() => _OffersStepState();
}

class _OffersStepState extends State<OffersStep> {
  static const _pageCount = 3;
  static const _swipeDistance = 72.0;
  static const _swipeVelocity = 420.0;

  int _page = 0;
  double _dragDx = 0;

  bool get _isLastPage => _page >= _pageCount - 1;

  void _goTo(int index) {
    final next = index.clamp(0, _pageCount - 1);
    if (next == _page) return;
    HapticFeedback.selectionClick();
    setState(() => _page = next);
  }

  void _onContinue() {
    HapticFeedback.selectionClick();
    if (_isLastPage) {
      widget.onGetStarted();
      return;
    }
    _goTo(_page + 1);
  }

  void _onSwipeEnd(DragEndDetails details) {
    final velocity = details.primaryVelocity ?? 0;
    final dx = _dragDx;
    _dragDx = 0;

    if (dx > _swipeDistance || velocity > _swipeVelocity) {
      _goTo(_page - 1);
      return;
    }
    if (dx < -_swipeDistance || velocity < -_swipeVelocity) {
      _goTo(_page + 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final pages = [
      _OfferPageData(
        icon: Icons.auto_awesome_rounded,
        title: l10n.onboardingPlanTrainingTitle,
        body: l10n.onboardingOffersTrainingBody,
      ),
      _OfferPageData(
        icon: Icons.groups_rounded,
        title: l10n.onboardingPlanCommunityTitle,
        body: l10n.onboardingPlanCommunityBody,
      ),
      _OfferPageData(
        icon: Icons.videocam_rounded,
        title: l10n.onboardingPlanTrainerTitle,
        body: l10n.onboardingPlanTrainerBody,
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onHorizontalDragUpdate: (details) {
              _dragDx += details.delta.dx;
            },
            onHorizontalDragCancel: () => _dragDx = 0,
            onHorizontalDragEnd: _onSwipeEnd,
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 420),
              switchInCurve: Curves.easeInOutCubic,
              switchOutCurve: Curves.easeInOutCubic,
              layoutBuilder: (currentChild, previousChildren) {
                return Stack(
                  alignment: Alignment.center,
                  fit: StackFit.expand,
                  children: [
                    ...previousChildren,
                    ?currentChild,
                  ],
                );
              },
              transitionBuilder: (child, animation) {
                final curved = CurvedAnimation(
                  parent: animation,
                  curve: Curves.easeInOutCubic,
                );
                return FadeTransition(
                  opacity: curved,
                  child: ScaleTransition(
                    scale: Tween<double>(begin: 0.96, end: 1).animate(curved),
                    child: child,
                  ),
                );
              },
              child: KeyedSubtree(
                key: ValueKey(_page),
                child: _OfferPage(data: pages[_page]),
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        _PageDots(count: _pageCount, index: _page),
        const SizedBox(height: 20),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 240),
          switchInCurve: Curves.easeOutCubic,
          switchOutCurve: Curves.easeInCubic,
          transitionBuilder: (child, animation) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
          child: PgButton(
            key: ValueKey(_isLastPage),
            label: _isLastPage
                ? l10n.onboardingGetStarted
                : l10n.onboardingNext,
            onPressed: _onContinue,
          ),
        ),
      ],
    );
  }
}

class _OfferPageData {
  const _OfferPageData({
    required this.icon,
    required this.title,
    required this.body,
  });

  final IconData icon;
  final String title;
  final String body;
}

class _OfferPage extends StatelessWidget {
  const _OfferPage({required this.data});

  final _OfferPageData data;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 88,
            height: 88,
            decoration: BoxDecoration(
              color: AppColors.accentSoft,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: AppColors.accent.withValues(alpha: 0.35),
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.accent.withValues(alpha: 0.22),
                  blurRadius: 28,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Icon(data.icon, color: AppColors.accent, size: 40),
          ),
          const SizedBox(height: 32),
          Text(
            data.title,
            textAlign: TextAlign.center,
            style: textTheme.headlineSmall?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            data.body,
            textAlign: TextAlign.center,
            style: textTheme.bodyLarge?.copyWith(
              color: Colors.white.withValues(alpha: 0.78),
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}

class _PageDots extends StatelessWidget {
  const _PageDots({required this.count, required this.index});

  final int count;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count, (i) {
        final active = i == index;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 280),
          curve: Curves.easeOutCubic,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: active ? 24 : 8,
          height: 8,
          decoration: BoxDecoration(
            color: active
                ? AppColors.accent
                : Colors.white.withValues(alpha: 0.28),
            borderRadius: BorderRadius.circular(8),
          ),
        );
      }),
    );
  }
}
