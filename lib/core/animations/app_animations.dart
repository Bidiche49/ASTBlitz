import 'package:flutter/material.dart';

class AppDurations {
  AppDurations._();

  static const Duration fast = Duration(milliseconds: 200);
  static const Duration normal = Duration(milliseconds: 300);
  static const Duration slow = Duration(milliseconds: 500);
  static const Duration slower = Duration(milliseconds: 800);
  static const Duration slowest = Duration(milliseconds: 1200);
}

class AppCurves {
  AppCurves._();

  static const Curve easeOut = Curves.easeOut;
  static const Curve easeInOut = Curves.easeInOut;
  static const Curve linear = Curves.linear;
  static const Curve spring = Curves.elasticOut;
  static const Curve decelerate = Curves.decelerate;
  static const Curve bounceOut = Curves.bounceOut;
}

/// Extension pour ajouter des animations communes aux widgets
extension AnimatedWidgetExtension on Widget {
  /// Fade in + slide up animation
  Widget fadeSlideIn({
    Duration duration = AppDurations.normal,
    Duration delay = Duration.zero,
    double offsetY = 20,
  }) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: duration,
      curve: AppCurves.easeOut,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, offsetY * (1 - value)),
            child: child,
          ),
        );
      },
      child: this,
    );
  }

  /// Scale animation on tap
  Widget scaleTap({
    double scaleDown = 0.95,
    Duration duration = AppDurations.fast,
  }) {
    return _ScaleTapWidget(
      scaleDown: scaleDown,
      duration: duration,
      child: this,
    );
  }
}

class _ScaleTapWidget extends StatefulWidget {
  final Widget child;
  final double scaleDown;
  final Duration duration;

  const _ScaleTapWidget({
    required this.child,
    required this.scaleDown,
    required this.duration,
  });

  @override
  State<_ScaleTapWidget> createState() => _ScaleTapWidgetState();
}

class _ScaleTapWidgetState extends State<_ScaleTapWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: widget.scaleDown,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: AppCurves.easeOut,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _controller.forward(),
      onTapUp: (_) => _controller.reverse(),
      onTapCancel: () => _controller.reverse(),
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: child,
          );
        },
        child: widget.child,
      ),
    );
  }
}

/// Widget pour les animations staggered (liste)
class StaggeredListAnimation extends StatelessWidget {
  final int index;
  final Duration itemDelay;
  final Duration itemDuration;
  final Widget child;

  const StaggeredListAnimation({
    super.key,
    required this.index,
    this.itemDelay = const Duration(milliseconds: 50),
    this.itemDuration = AppDurations.normal,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: itemDuration,
      curve: AppCurves.easeOut,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, 20 * (1 - value)),
            child: child,
          ),
        );
      },
      child: child,
    );
  }
}
