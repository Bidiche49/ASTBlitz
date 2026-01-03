import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';

enum ButtonVariant { primary, secondary, destructive, outline, ghost, link }

enum ButtonSize { sm, md, lg, icon }

class AppButton extends StatelessWidget {
  final String? label;
  final IconData? icon;
  final ButtonVariant variant;
  final ButtonSize size;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool expanded;

  const AppButton({
    super.key,
    this.label,
    this.icon,
    this.variant = ButtonVariant.primary,
    this.size = ButtonSize.md,
    this.onPressed,
    this.isLoading = false,
    this.expanded = false,
  }) : assert(label != null || icon != null, 'label or icon must be provided');

  @override
  Widget build(BuildContext context) {
    final style = _getButtonStyle();
    final child = _buildChild();

    Widget button;

    if (variant == ButtonVariant.link) {
      button = TextButton(
        onPressed: isLoading ? null : onPressed,
        style: style,
        child: child,
      );
    } else if (variant == ButtonVariant.outline || variant == ButtonVariant.ghost) {
      button = OutlinedButton(
        onPressed: isLoading ? null : onPressed,
        style: style,
        child: child,
      );
    } else {
      button = ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: style,
        child: child,
      );
    }

    if (expanded) {
      return SizedBox(width: double.infinity, child: button);
    }

    return button;
  }

  Widget _buildChild() {
    if (isLoading) {
      return SizedBox(
        width: _iconSize,
        height: _iconSize,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          color: _foregroundColor,
        ),
      );
    }

    if (size == ButtonSize.icon) {
      return Icon(icon, size: _iconSize);
    }

    if (icon != null && label != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: _iconSize),
          const SizedBox(width: AppSpacing.sm),
          Text(label!, style: _textStyle),
        ],
      );
    }

    if (icon != null) {
      return Icon(icon, size: _iconSize);
    }

    return Text(label!, style: _textStyle);
  }

  ButtonStyle _getButtonStyle() {
    return ButtonStyle(
      backgroundColor: WidgetStateProperty.resolveWith(_backgroundColor),
      foregroundColor: WidgetStateProperty.all(_foregroundColor),
      elevation: WidgetStateProperty.all(_elevation),
      shadowColor: WidgetStateProperty.all(Colors.black26),
      padding: WidgetStateProperty.all(_padding),
      minimumSize: WidgetStateProperty.all(_minimumSize),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(borderRadius: AppRadius.borderRadiusMd),
      ),
      side: variant == ButtonVariant.outline
          ? WidgetStateProperty.all(const BorderSide(color: AppColors.border))
          : null,
    );
  }

  Color _backgroundColor(Set<WidgetState> states) {
    final isDisabled = states.contains(WidgetState.disabled);
    final isHovered = states.contains(WidgetState.hovered);
    final isPressed = states.contains(WidgetState.pressed);

    if (isDisabled) {
      return AppColors.backgroundAlt;
    }

    return switch (variant) {
      ButtonVariant.primary => isPressed
          ? AppColors.primaryDark.withValues(alpha: 0.8)
          : isHovered
              ? AppColors.primaryDark.withValues(alpha: 0.9)
              : AppColors.primaryDark,
      ButtonVariant.secondary => isPressed
          ? AppColors.backgroundAlt.withValues(alpha: 0.8)
          : AppColors.backgroundAlt,
      ButtonVariant.destructive => isPressed
          ? AppColors.destructive.withValues(alpha: 0.8)
          : isHovered
              ? AppColors.destructive.withValues(alpha: 0.9)
              : AppColors.destructive,
      ButtonVariant.outline => isHovered || isPressed
          ? AppColors.backgroundAlt
          : Colors.transparent,
      ButtonVariant.ghost => isHovered || isPressed
          ? AppColors.backgroundAlt
          : Colors.transparent,
      ButtonVariant.link => Colors.transparent,
    };
  }

  Color get _foregroundColor {
    return switch (variant) {
      ButtonVariant.primary => Colors.white,
      ButtonVariant.secondary => AppColors.foreground,
      ButtonVariant.destructive => Colors.white,
      ButtonVariant.outline => AppColors.foreground,
      ButtonVariant.ghost => AppColors.foreground,
      ButtonVariant.link => AppColors.primaryBlue,
    };
  }

  double get _elevation {
    return switch (variant) {
      ButtonVariant.primary => 2,
      ButtonVariant.secondary => 1,
      ButtonVariant.destructive => 1,
      ButtonVariant.outline => 0,
      ButtonVariant.ghost => 0,
      ButtonVariant.link => 0,
    };
  }

  EdgeInsets get _padding {
    return switch (size) {
      ButtonSize.sm => const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ButtonSize.md => const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      ButtonSize.lg => const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
      ButtonSize.icon => const EdgeInsets.all(8),
    };
  }

  Size get _minimumSize {
    return switch (size) {
      ButtonSize.sm => const Size(0, 32),
      ButtonSize.md => const Size(0, 36),
      ButtonSize.lg => const Size(0, 40),
      ButtonSize.icon => const Size(36, 36),
    };
  }

  double get _iconSize {
    return switch (size) {
      ButtonSize.sm => 16,
      ButtonSize.md => 18,
      ButtonSize.lg => 20,
      ButtonSize.icon => 20,
    };
  }

  TextStyle get _textStyle {
    final baseStyle = switch (size) {
      ButtonSize.sm => AppTypography.labelSmall,
      ButtonSize.md => AppTypography.button,
      ButtonSize.lg => AppTypography.button,
      ButtonSize.icon => AppTypography.button,
    };

    return baseStyle.copyWith(
      color: _foregroundColor,
      decoration: variant == ButtonVariant.link ? TextDecoration.underline : null,
    );
  }
}
