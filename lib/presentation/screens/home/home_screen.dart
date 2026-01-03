import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/constants/app_icons.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: AppSpacing.paddingLg,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              _buildHeader(context),
              const SizedBox(height: AppSpacing.xxl),

              // Score Predictor placeholder
              _buildScorePredictorPlaceholder(context),
              const SizedBox(height: AppSpacing.xxl),

              // Quiz du Jour
              _buildDailyQuizCard(context),
              const SizedBox(height: AppSpacing.xxl),

              // Modules Grid
              _buildModulesGrid(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'AST BLITZ',
          style: AppTypography.h1.copyWith(
            color: AppColors.primaryDark,
            letterSpacing: 1,
          ),
        ),
        IconButton(
          onPressed: () {
            // TODO: Open menu
          },
          icon: const Icon(AppIcons.menu),
          color: AppColors.foreground,
        ),
      ],
    );
  }

  Widget _buildScorePredictorPlaceholder(BuildContext context) {
    return Container(
      padding: AppSpacing.paddingXl,
      decoration: BoxDecoration(
        color: AppColors.backgroundAlt,
        borderRadius: AppRadius.borderRadiusXl,
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          // Progress circle placeholder
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: AppColors.gradientProgress,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Center(
              child: Text(
                '350',
                style: AppTypography.h2.copyWith(color: Colors.white),
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.lg),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Score prédit',
                  style: AppTypography.bodySmall.copyWith(
                    color: AppColors.foregroundMuted,
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                Row(
                  children: [
                    Text(
                      '350 / 600',
                      style: AppTypography.h3,
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Icon(
                      AppIcons.trendingUp,
                      size: 20,
                      color: AppColors.success,
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  'Objectif: 450',
                  style: AppTypography.bodySmall.copyWith(
                    color: AppColors.foregroundMuted,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDailyQuizCard(BuildContext context) {
    return Container(
      padding: AppSpacing.paddingXl,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: AppColors.gradientOrangeRed,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: AppRadius.borderRadiusXl,
        boxShadow: AppShadows.listLg,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Quiz du Jour',
                  style: AppTypography.h3.copyWith(color: Colors.white),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  '3 questions pour bien démarrer',
                  style: AppTypography.bodySmall.copyWith(
                    color: Colors.white.withValues(alpha: 0.9),
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                Text(
                  'Testez vos connaissances avec le défi quotidien !',
                  style: AppTypography.bodySmall.copyWith(
                    color: Colors.white.withValues(alpha: 0.8),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.lg),
          Container(
            padding: AppSpacing.paddingMd,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              borderRadius: AppRadius.borderRadiusFull,
            ),
            child: const Icon(
              AppIcons.play,
              color: Colors.white,
              size: 32,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildModulesGrid(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Modules',
          style: AppTypography.h3,
        ),
        const SizedBox(height: AppSpacing.lg),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          mainAxisSpacing: AppSpacing.md,
          crossAxisSpacing: AppSpacing.md,
          childAspectRatio: 1.3,
          children: [
            _buildModuleCard(
              context,
              title: 'Blitz',
              icon: AppIcons.zap,
              gradient: AppColors.gradientSlate,
            ),
            _buildModuleCard(
              context,
              title: 'Cours',
              icon: AppIcons.bookOpen,
              gradient: AppColors.gradientSlate,
            ),
            _buildModuleCard(
              context,
              title: 'Mon Professeur',
              icon: AppIcons.sparkles,
              gradient: AppColors.gradientAmberOrange,
            ),
            _buildModuleCard(
              context,
              title: 'Duel',
              icon: AppIcons.users,
              gradient: AppColors.gradientBlueIndigo,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildModuleCard(
    BuildContext context, {
    required String title,
    required IconData icon,
    required List<Color> gradient,
  }) {
    return GestureDetector(
      onTap: () {
        // TODO: Navigate to module
      },
      child: Container(
        padding: AppSpacing.paddingLg,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: gradient,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: AppRadius.borderRadiusXl,
          boxShadow: AppShadows.listMd,
        ),
        child: Stack(
          children: [
            // Decorative circle
            Positioned(
              top: -20,
              right: -20,
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withValues(alpha: 0.1),
                ),
              ),
            ),
            // Content
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  icon,
                  color: Colors.white,
                  size: 28,
                ),
                Text(
                  title,
                  style: AppTypography.labelLarge.copyWith(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
