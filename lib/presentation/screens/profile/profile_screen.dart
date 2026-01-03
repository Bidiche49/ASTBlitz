import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/constants/app_icons.dart';
import '../../navigation/app_router.dart';
import '../../providers/auth_provider.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authProvider);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: AppSpacing.paddingLg,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header avec avatar
              _buildHeader(context, user),
              const SizedBox(height: AppSpacing.xxl),

              // Niveau et XP
              _buildLevelSection(context),
              const SizedBox(height: AppSpacing.xxl),

              // Stats Cards
              _buildStatsGrid(context),
              const SizedBox(height: AppSpacing.xxl),

              // Moyennes par matiere
              _buildSubjectAverages(context),
              const SizedBox(height: AppSpacing.xxl),

              // Code parrainage
              _buildReferralSection(context),
              const SizedBox(height: AppSpacing.xxl),

              // Actions
              _buildActionsSection(context, ref),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, user) {
    final displayName = user?.displayName ?? 'Utilisateur';
    final email = user?.email ?? '';

    return Row(
      children: [
        // Avatar
        GestureDetector(
          onTap: () {
            // TODO: Ouvrir selecteur avatar
          },
          child: Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: AppColors.gradientBlueIndigo,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              shape: BoxShape.circle,
              boxShadow: AppShadows.listMd,
            ),
            child: Center(
              child: Text(
                _getInitials(displayName),
                style: AppTypography.h1.copyWith(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: AppSpacing.lg),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                displayName,
                style: AppTypography.h2,
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                email,
                style: AppTypography.bodySmall.copyWith(
                  color: AppColors.foregroundMuted,
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              // Titre selectionne (placeholder)
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: AppSpacing.xs,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primaryBlue.withValues(alpha: 0.1),
                  borderRadius: AppRadius.borderRadiusFull,
                ),
                child: Text(
                  'Apprenti Stratège',
                  style: AppTypography.labelSmall.copyWith(
                    color: AppColors.primaryBlue,
                  ),
                ),
              ),
            ],
          ),
        ),
        IconButton(
          onPressed: () {
            context.push(AppRoutes.settings);
          },
          icon: Icon(AppIcons.settings),
          color: AppColors.foregroundMuted,
        ),
      ],
    );
  }

  String _getInitials(String name) {
    final parts = name.trim().split(' ');
    if (parts.isEmpty) return '?';
    if (parts.length == 1) return parts[0][0].toUpperCase();
    return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
  }

  Widget _buildLevelSection(BuildContext context) {
    const level = 12;
    const currentXp = 850;
    const requiredXp = 1000;
    final progress = currentXp / requiredXp;

    return Container(
      padding: AppSpacing.paddingLg,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: AppColors.gradientSlate,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: AppRadius.borderRadiusXl,
        boxShadow: AppShadows.listMd,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Niveau $level',
                style: AppTypography.h3.copyWith(color: Colors.white),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: AppSpacing.xs,
                ),
                decoration: BoxDecoration(
                  color: AppColors.accentCyan.withValues(alpha: 0.2),
                  borderRadius: AppRadius.borderRadiusFull,
                ),
                child: Row(
                  children: [
                    Icon(
                      AppIcons.star,
                      size: 14,
                      color: AppColors.accentCyan,
                    ),
                    const SizedBox(width: AppSpacing.xs),
                    Text(
                      '$currentXp / $requiredXp XP',
                      style: AppTypography.labelSmall.copyWith(
                        color: AppColors.accentCyan,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          ClipRRect(
            borderRadius: AppRadius.borderRadiusFull,
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.white.withValues(alpha: 0.2),
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.accentCyan),
              minHeight: 8,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'Prochain niveau: ${requiredXp - currentXp} XP',
            style: AppTypography.bodySmall.copyWith(
              color: Colors.white.withValues(alpha: 0.7),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsGrid(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Statistiques',
          style: AppTypography.h3,
        ),
        const SizedBox(height: AppSpacing.lg),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          mainAxisSpacing: AppSpacing.md,
          crossAxisSpacing: AppSpacing.md,
          childAspectRatio: 1.5,
          children: [
            _StatCard(
              label: 'Score actuel',
              value: '350',
              icon: AppIcons.target,
              color: AppColors.chart1,
            ),
            _StatCard(
              label: 'Temps (semaine)',
              value: '4h 32m',
              icon: AppIcons.clock,
              color: AppColors.chart2,
            ),
            _StatCard(
              label: 'Exercices',
              value: '47',
              icon: AppIcons.zap,
              color: AppColors.chart4,
            ),
            _StatCard(
              label: 'Série actuelle',
              value: '12 jours',
              icon: AppIcons.flame,
              color: AppColors.destructive,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSubjectAverages(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Moyennes par matière',
          style: AppTypography.h3,
        ),
        const SizedBox(height: AppSpacing.lg),
        _SubjectProgress(
          title: 'Aptitude Numérique',
          percentage: 72,
          color: AppColors.chart1,
        ),
        const SizedBox(height: AppSpacing.md),
        _SubjectProgress(
          title: 'Raisonnement Logique',
          percentage: 68,
          color: AppColors.chart2,
        ),
        const SizedBox(height: AppSpacing.md),
        _SubjectProgress(
          title: 'Aptitude Verbale',
          percentage: 81,
          color: AppColors.chart3,
        ),
      ],
    );
  }

  Widget _buildReferralSection(BuildContext context) {
    const referralCode = 'AST-X7K9M2';

    return Container(
      padding: AppSpacing.paddingLg,
      decoration: BoxDecoration(
        color: AppColors.backgroundAlt,
        borderRadius: AppRadius.borderRadiusXl,
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: AppSpacing.paddingMd,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: AppColors.gradientYellowOrange,
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: AppRadius.borderRadiusLg,
                ),
                child: Icon(
                  AppIcons.gift,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              const SizedBox(width: AppSpacing.lg),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Mon code de parrainage',
                      style: AppTypography.labelLarge,
                    ),
                    Text(
                      'Partage ton code',
                      style: AppTypography.bodySmall.copyWith(
                        color: AppColors.foregroundMuted,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: AppSpacing.paddingLg,
                  decoration: BoxDecoration(
                    color: AppColors.background,
                    borderRadius: AppRadius.borderRadiusLg,
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Text(
                    referralCode,
                    style: AppTypography.h4.copyWith(
                      letterSpacing: 2,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              GestureDetector(
                onTap: () {
                  Clipboard.setData(const ClipboardData(text: referralCode));
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Code copié !'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
                child: Container(
                  padding: AppSpacing.paddingLg,
                  decoration: BoxDecoration(
                    color: AppColors.primaryDark,
                    borderRadius: AppRadius.borderRadiusLg,
                  ),
                  child: Icon(
                    AppIcons.copy,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionsSection(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _ActionTile(
          icon: AppIcons.award,
          title: 'Mes Badges',
          onTap: () => context.push(AppRoutes.badges),
        ),
        const SizedBox(height: AppSpacing.sm),
        _ActionTile(
          icon: AppIcons.barChart,
          title: 'Statistiques détaillées',
          onTap: () => context.push(AppRoutes.stats),
        ),
        const SizedBox(height: AppSpacing.sm),
        _ActionTile(
          icon: AppIcons.settings,
          title: 'Paramètres',
          onTap: () => context.push(AppRoutes.settings),
        ),
        const SizedBox(height: AppSpacing.lg),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: () {
              ref.read(authProvider.notifier).signOut();
            },
            icon: Icon(AppIcons.logOut, size: 18),
            label: const Text('Déconnexion'),
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.destructive,
              side: BorderSide(color: AppColors.destructive),
              padding: AppSpacing.verticalLg,
              shape: RoundedRectangleBorder(
                borderRadius: AppRadius.borderRadiusLg,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// Stat Card Widget
class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;

  const _StatCard({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppSpacing.paddingLg,
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: AppRadius.borderRadiusXl,
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                icon,
                color: color,
                size: 20,
              ),
              Text(
                value,
                style: AppTypography.h3.copyWith(color: color),
              ),
            ],
          ),
          Text(
            label,
            style: AppTypography.bodySmall.copyWith(
              color: AppColors.foregroundMuted,
            ),
          ),
        ],
      ),
    );
  }
}

// Subject Progress Widget
class _SubjectProgress extends StatelessWidget {
  final String title;
  final int percentage;
  final Color color;

  const _SubjectProgress({
    required this.title,
    required this.percentage,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppSpacing.paddingLg,
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: AppRadius.borderRadiusLg,
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: AppTypography.labelLarge,
              ),
              Text(
                '$percentage%',
                style: AppTypography.labelLarge.copyWith(color: color),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          ClipRRect(
            borderRadius: AppRadius.borderRadiusFull,
            child: LinearProgressIndicator(
              value: percentage / 100,
              backgroundColor: color.withValues(alpha: 0.2),
              valueColor: AlwaysStoppedAnimation<Color>(color),
              minHeight: 6,
            ),
          ),
        ],
      ),
    );
  }
}

// Action Tile Widget
class _ActionTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback? onTap;

  const _ActionTile({
    required this.icon,
    required this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: AppSpacing.paddingLg,
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: AppRadius.borderRadiusLg,
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: AppColors.foreground,
              size: 20,
            ),
            const SizedBox(width: AppSpacing.lg),
            Expanded(
              child: Text(
                title,
                style: AppTypography.labelLarge,
              ),
            ),
            Icon(
              AppIcons.chevronRight,
              color: AppColors.foregroundMuted,
            ),
          ],
        ),
      ),
    );
  }
}
