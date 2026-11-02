import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

import 'horizontal_swipe_nav.dart';

/// Full-width left-to-right swipe pops the current route when possible.
class SwipeToPop extends StatelessWidget {
  const SwipeToPop({super.key, required this.child});

  final Widget child;

  void _popIfPossible(BuildContext context) {
    if (!Navigator.of(context).canPop()) return;
    HapticFeedback.lightImpact();
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    return HorizontalSwipeNav(
      onSwipeBack: () => _popIfPossible(context),
      child: child,
    );
  }
}
