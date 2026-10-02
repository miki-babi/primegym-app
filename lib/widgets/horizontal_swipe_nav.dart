import 'package:flutter/material.dart';

/// Full-width horizontal swipe: right = back, left = forward.
class HorizontalSwipeNav extends StatefulWidget {
  const HorizontalSwipeNav({
    super.key,
    required this.child,
    this.onSwipeBack,
    this.onSwipeForward,
    this.distanceThreshold = 72,
    this.velocityThreshold = 420,
  });

  final Widget child;
  final VoidCallback? onSwipeBack;
  final VoidCallback? onSwipeForward;
  final double distanceThreshold;
  final double velocityThreshold;

  @override
  State<HorizontalSwipeNav> createState() => _HorizontalSwipeNavState();
}

class _HorizontalSwipeNavState extends State<HorizontalSwipeNav> {
  double _dragDx = 0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onHorizontalDragUpdate: (details) {
        _dragDx += details.delta.dx;
      },
      onHorizontalDragCancel: () => _dragDx = 0,
      onHorizontalDragEnd: (details) {
        final velocity = details.primaryVelocity ?? 0;
        final dx = _dragDx;
        _dragDx = 0;

        if (dx > widget.distanceThreshold ||
            velocity > widget.velocityThreshold) {
          widget.onSwipeBack?.call();
          return;
        }
        if (dx < -widget.distanceThreshold ||
            velocity < -widget.velocityThreshold) {
          widget.onSwipeForward?.call();
        }
      },
      child: widget.child,
    );
  }
}
