import 'package:flutter/material.dart';

import '../../core/constants/app_icons.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';

enum BlitzCoinSize { sm, md, lg }

class BlitzCoinIcon extends StatelessWidget {
  final BlitzCoinSize size;

  const BlitzCoinIcon({
    super.key,
    this.size = BlitzCoinSize.md,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _containerSize,
      height: _containerSize,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: AppColors.gradientYellowOrange,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: _borderRadius,
        boxShadow: AppShadows.listMd,
      ),
      child: Center(
        child: Icon(
          AppIcons.zap,
          color: Colors.white,
          size: _iconSize,
        ),
      ),
    );
  }

  double get _containerSize {
    return switch (size) {
      BlitzCoinSize.sm => 24,
      BlitzCoinSize.md => 48,
      BlitzCoinSize.lg => 64,
    };
  }

  double get _iconSize {
    return switch (size) {
      BlitzCoinSize.sm => 14,
      BlitzCoinSize.md => 28,
      BlitzCoinSize.lg => 36,
    };
  }

  BorderRadius get _borderRadius {
    return switch (size) {
      BlitzCoinSize.sm => AppRadius.borderRadiusSm,
      BlitzCoinSize.md => AppRadius.borderRadiusLg,
      BlitzCoinSize.lg => AppRadius.borderRadiusXl,
    };
  }
}
