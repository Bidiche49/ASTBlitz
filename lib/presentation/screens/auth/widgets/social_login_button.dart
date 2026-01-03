import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';

/// Type de connexion sociale.
enum SocialLoginType { google, apple }

/// Bouton de connexion sociale (Google, Apple).
class SocialLoginButton extends StatelessWidget {
  final SocialLoginType type;
  final VoidCallback onPressed;
  final bool isLoading;

  const SocialLoginButton({
    super.key,
    required this.type,
    required this.onPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: OutlinedButton(
        onPressed: isLoading ? null : onPressed,
        style: OutlinedButton.styleFrom(
          backgroundColor: _backgroundColor,
          foregroundColor: _foregroundColor,
          side: BorderSide(color: _borderColor),
          shape: RoundedRectangleBorder(
            borderRadius: AppRadius.borderRadiusMd,
          ),
        ),
        child: isLoading
            ? SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: _foregroundColor,
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildIcon(),
                  const SizedBox(width: AppSpacing.md),
                  Text(
                    _label,
                    style: AppTypography.labelLarge.copyWith(
                      color: _foregroundColor,
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Widget _buildIcon() {
    return switch (type) {
      SocialLoginType.google => Image.network(
          'https://www.gstatic.com/firebasejs/ui/2.0.0/images/auth/google.svg',
          width: 24,
          height: 24,
          errorBuilder: (context, error, stackTrace) => const Icon(Icons.g_mobiledata, size: 24),
        ),
      SocialLoginType.apple => const Icon(Icons.apple, size: 24),
    };
  }

  String get _label => switch (type) {
        SocialLoginType.google => 'Continuer avec Google',
        SocialLoginType.apple => 'Continuer avec Apple',
      };

  Color get _backgroundColor => switch (type) {
        SocialLoginType.google => Colors.white,
        SocialLoginType.apple => Colors.black,
      };

  Color get _foregroundColor => switch (type) {
        SocialLoginType.google => AppColors.foreground,
        SocialLoginType.apple => Colors.white,
      };

  Color get _borderColor => switch (type) {
        SocialLoginType.google => AppColors.border,
        SocialLoginType.apple => Colors.black,
      };
}
