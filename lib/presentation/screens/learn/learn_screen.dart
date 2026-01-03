import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/constants/app_icons.dart';
import '../../navigation/app_router.dart';

class LearnScreen extends StatefulWidget {
  const LearnScreen({super.key});

  @override
  State<LearnScreen> createState() => _LearnScreenState();
}

class _LearnScreenState extends State<LearnScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header avec tabs
            Padding(
              padding: AppSpacing.paddingLg,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'APPRENDRE',
                    style: AppTypography.h1.copyWith(
                      color: AppColors.primaryDark,
                      letterSpacing: 1,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  _buildTabBar(),
                ],
              ),
            ),

            // Content
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _CoursesTab(),
                  _FichesTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.backgroundAlt,
        borderRadius: AppRadius.borderRadiusFull,
      ),
      padding: const EdgeInsets.all(4),
      child: TabBar(
        controller: _tabController,
        indicator: BoxDecoration(
          color: AppColors.primaryDark,
          borderRadius: AppRadius.borderRadiusFull,
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        dividerColor: Colors.transparent,
        labelColor: Colors.white,
        unselectedLabelColor: AppColors.foregroundMuted,
        labelStyle: AppTypography.labelLarge,
        tabs: const [
          Tab(text: 'Cours'),
          Tab(text: 'Fiches'),
        ],
      ),
    );
  }
}

// Onglet Cours
class _CoursesTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: AppSpacing.paddingLg,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Reprendre
          _buildContinueSection(context),
          const SizedBox(height: AppSpacing.xxl),

          // Explorer
          _buildExploreSection(context),
        ],
      ),
    );
  }

  Widget _buildContinueSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Reprendre',
          style: AppTypography.h3,
        ),
        const SizedBox(height: AppSpacing.lg),
        _ContinueCard(
          title: 'Aptitude Numérique',
          subtitle: 'Cours 3 sur 8',
          progress: 3 / 8,
          onTap: () {
            context.push('${AppRoutes.courseContent}?subject=maths&id=3');
          },
        ),
      ],
    );
  }

  Widget _buildExploreSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Explorer les matières',
          style: AppTypography.h3,
        ),
        const SizedBox(height: AppSpacing.lg),
        _SubjectCard(
          title: 'Aptitude Numérique',
          description: 'Maîtrisez chiffres et formules.',
          icon: AppIcons.calculator,
          lessonsCount: 8,
          gradient: AppColors.gradientOrangeRed,
          onTap: () {
            context.push('${AppRoutes.subject}?subject=maths&type=cours');
          },
        ),
        const SizedBox(height: AppSpacing.md),
        _SubjectCard(
          title: 'Raisonnement Logique',
          description: '8 leçons',
          icon: AppIcons.brain,
          lessonsCount: 8,
          gradient: AppColors.gradientBlueIndigo,
          onTap: () {
            context.push('${AppRoutes.subject}?subject=logique&type=cours');
          },
        ),
        const SizedBox(height: AppSpacing.md),
        _SubjectCard(
          title: 'Aptitude Verbale',
          description: '5 leçons',
          icon: AppIcons.bookOpen,
          lessonsCount: 5,
          gradient: AppColors.gradientTealGreen,
          onTap: () {
            context.push('${AppRoutes.subject}?subject=langues&type=cours');
          },
        ),
      ],
    );
  }
}

// Onglet Fiches
class _FichesTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: AppSpacing.paddingLg,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Reprendre
          _buildContinueSection(context),
          const SizedBox(height: AppSpacing.xxl),

          // Explorer
          _buildExploreSection(context),
        ],
      ),
    );
  }

  Widget _buildContinueSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Reprendre',
          style: AppTypography.h3,
        ),
        const SizedBox(height: AppSpacing.lg),
        _ContinueCard(
          title: 'Raisonnement Logique',
          subtitle: 'Fiche 2 sur 6',
          progress: 2 / 6,
          onTap: () {
            context.push('${AppRoutes.courseContent}?subject=logique&type=fiches&id=2');
          },
        ),
      ],
    );
  }

  Widget _buildExploreSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Explorer les fiches',
          style: AppTypography.h3,
        ),
        const SizedBox(height: AppSpacing.lg),
        _SubjectCard(
          title: 'Aptitude Numérique',
          description: 'Fiches de révision rapide.',
          icon: AppIcons.calculator,
          lessonsCount: 6,
          gradient: AppColors.gradientOrangeRed,
          onTap: () {
            context.push('${AppRoutes.subject}?subject=maths&type=fiches');
          },
        ),
        const SizedBox(height: AppSpacing.md),
        _SubjectCard(
          title: 'Raisonnement Logique',
          description: '6 fiches',
          icon: AppIcons.brain,
          lessonsCount: 6,
          gradient: AppColors.gradientBlueIndigo,
          onTap: () {
            context.push('${AppRoutes.subject}?subject=logique&type=fiches');
          },
        ),
        const SizedBox(height: AppSpacing.md),
        _SubjectCard(
          title: 'Aptitude Verbale',
          description: '4 fiches',
          icon: AppIcons.bookOpen,
          lessonsCount: 4,
          gradient: AppColors.gradientTealGreen,
          onTap: () {
            context.push('${AppRoutes.subject}?subject=langues&type=fiches');
          },
        ),
      ],
    );
  }
}

// Continue Card (reprendre un cours/fiche)
class _ContinueCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final double progress;
  final VoidCallback? onTap;

  const _ContinueCard({
    required this.title,
    required this.subtitle,
    required this.progress,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: AppTypography.h4.copyWith(color: Colors.white),
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      Text(
                        subtitle,
                        style: AppTypography.bodySmall.copyWith(
                          color: Colors.white.withValues(alpha: 0.8),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: AppSpacing.paddingMd,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: AppRadius.borderRadiusFull,
                  ),
                  child: Icon(
                    AppIcons.play,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.lg),
            // Progress bar
            ClipRRect(
              borderRadius: AppRadius.borderRadiusFull,
              child: LinearProgressIndicator(
                value: progress,
                backgroundColor: Colors.white.withValues(alpha: 0.2),
                valueColor: AlwaysStoppedAnimation<Color>(
                  AppColors.accentCyan,
                ),
                minHeight: 6,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Subject Card (matiere)
class _SubjectCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final int lessonsCount;
  final List<Color> gradient;
  final VoidCallback? onTap;

  const _SubjectCard({
    required this.title,
    required this.description,
    required this.icon,
    required this.lessonsCount,
    required this.gradient,
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
          borderRadius: AppRadius.borderRadiusXl,
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          children: [
            Container(
              padding: AppSpacing.paddingMd,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: gradient,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: AppRadius.borderRadiusLg,
              ),
              child: Icon(
                icon,
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
                    title,
                    style: AppTypography.labelLarge,
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    description,
                    style: AppTypography.bodySmall.copyWith(
                      color: AppColors.foregroundMuted,
                    ),
                  ),
                ],
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
