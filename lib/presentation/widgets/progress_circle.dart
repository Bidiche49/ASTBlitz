import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../core/animations/app_animations.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';

class ProgressCircle extends StatefulWidget {
  final int current;
  final int max;
  final double size;
  final double strokeWidth;
  final bool showText;
  final bool animate;

  const ProgressCircle({
    super.key,
    required this.current,
    required this.max,
    this.size = 80,
    this.strokeWidth = 8,
    this.showText = true,
    this.animate = true,
  });

  @override
  State<ProgressCircle> createState() => _ProgressCircleState();
}

class _ProgressCircleState extends State<ProgressCircle>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _progressAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: AppDurations.slow,
      vsync: this,
    );

    _updateAnimation();

    if (widget.animate) {
      _controller.forward();
    } else {
      _controller.value = 1.0;
    }
  }

  @override
  void didUpdateWidget(ProgressCircle oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.current != widget.current || oldWidget.max != widget.max) {
      _updateAnimation();
      if (widget.animate) {
        _controller.forward(from: 0);
      }
    }
  }

  void _updateAnimation() {
    final progress = widget.max > 0 ? widget.current / widget.max : 0.0;
    _progressAnimation = Tween<double>(
      begin: 0,
      end: progress.clamp(0.0, 1.0),
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
    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: AnimatedBuilder(
        animation: _progressAnimation,
        builder: (context, child) {
          return CustomPaint(
            painter: _ProgressCirclePainter(
              progress: _progressAnimation.value,
              strokeWidth: widget.strokeWidth,
              gradientColors: AppColors.gradientProgress,
            ),
            child: child,
          );
        },
        child: widget.showText
            ? Center(
                child: Text(
                  '${widget.current}',
                  style: AppTypography.h2.copyWith(
                    color: AppColors.foreground,
                  ),
                ),
              )
            : null,
      ),
    );
  }
}

class _ProgressCirclePainter extends CustomPainter {
  final double progress;
  final double strokeWidth;
  final List<Color> gradientColors;

  _ProgressCirclePainter({
    required this.progress,
    required this.strokeWidth,
    required this.gradientColors,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;

    // Background circle
    final backgroundPaint = Paint()
      ..color = AppColors.border
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, backgroundPaint);

    // Progress arc
    if (progress > 0) {
      final rect = Rect.fromCircle(center: center, radius: radius);

      final progressPaint = Paint()
        ..shader = SweepGradient(
          startAngle: -math.pi / 2,
          endAngle: 3 * math.pi / 2,
          colors: gradientColors,
        ).createShader(rect)
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.round;

      final sweepAngle = 2 * math.pi * progress;

      canvas.drawArc(
        rect,
        -math.pi / 2, // Start from top
        sweepAngle,
        false,
        progressPaint,
      );
    }
  }

  @override
  bool shouldRepaint(_ProgressCirclePainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
