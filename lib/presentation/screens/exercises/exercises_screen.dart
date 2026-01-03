import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/constants/app_icons.dart';
import '../../navigation/app_router.dart';

class ExercisesScreen extends StatefulWidget {
  const ExercisesScreen({super.key});

  @override
  State<ExercisesScreen> createState() => _ExercisesScreenState();
}

class _ExercisesScreenState extends State<ExercisesScreen> {
  // Sous-tests actifs (tous par defaut)
  final Set<String> _activeSubtests = {
    'comprehension',
    'calcul',
    'raisonnement',
    'conditions',
    'expression',
    'logique',
  };

  static const _allSubtests = [
    ('comprehension', 'Compréhension'),
    ('calcul', 'Calcul'),
    ('raisonnement', 'Raisonnement'),
    ('conditions', 'Conditions Minimales'),
    ('expression', 'Expression'),
    ('logique', 'Logique'),
  ];

  void _showSubtestsModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _SubtestsModal(
        activeSubtests: _activeSubtests,
        onConfirm: (selected) {
          setState(() {
            _activeSubtests.clear();
            _activeSubtests.addAll(selected);
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: AppSpacing.paddingLg,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              _buildHeader(),
              const SizedBox(height: AppSpacing.xxl),

              // Personnalisation sous-tests
              _buildSubtestsCard(),
              const SizedBox(height: AppSpacing.xxl),

              // Modes rapides
              _buildQuickModes(),
              const SizedBox(height: AppSpacing.xxl),

              // Mode Classique
              _buildClassicMode(),
              const SizedBox(height: AppSpacing.xxl),

              // Entrainement cible
              _buildTargetedTraining(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'EXERCICES',
          style: AppTypography.h1.copyWith(
            color: AppColors.primaryDark,
            letterSpacing: 1,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          'Prêt à t\'entraîner ?',
          style: AppTypography.h3.copyWith(
            color: AppColors.foreground,
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          'Choisis ton mode de préparation.',
          style: AppTypography.bodyMedium.copyWith(
            color: AppColors.foregroundMuted,
          ),
        ),
      ],
    );
  }

  Widget _buildSubtestsCard() {
    return GestureDetector(
      onTap: _showSubtestsModal,
      child: Container(
        padding: AppSpacing.paddingLg,
        decoration: BoxDecoration(
          color: AppColors.backgroundAlt,
          borderRadius: AppRadius.borderRadiusXl,
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          children: [
            Container(
              padding: AppSpacing.paddingMd,
              decoration: BoxDecoration(
                color: AppColors.primaryBlue.withValues(alpha: 0.1),
                borderRadius: AppRadius.borderRadiusLg,
              ),
              child: Icon(
                AppIcons.settings,
                color: AppColors.primaryBlue,
                size: 24,
              ),
            ),
            const SizedBox(width: AppSpacing.lg),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Choisir quel sous-test réviser',
                    style: AppTypography.labelLarge,
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    '${_activeSubtests.length} sur ${_allSubtests.length} actifs',
                    style: AppTypography.bodySmall.copyWith(
                      color: AppColors.foregroundMuted,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.sm,
              ),
              decoration: BoxDecoration(
                color: AppColors.primaryBlue,
                borderRadius: AppRadius.borderRadiusFull,
              ),
              child: Text(
                'Personnaliser',
                style: AppTypography.labelSmall.copyWith(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickModes() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Modes',
          style: AppTypography.h3,
        ),
        const SizedBox(height: AppSpacing.lg),
        Row(
          children: [
            Expanded(
              child: _ModeCard(
                title: 'Mode Blitz',
                subtitle: 'Questions rapides',
                icon: AppIcons.zap,
                gradient: AppColors.gradientAmberOrange,
                onTap: () {
                  // TODO: Navigate to blitz mode
                  context.push('${AppRoutes.quiz}?mode=blitz');
                },
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: _ModeCard(
                title: 'Examen Blanc',
                subtitle: 'Conditions réelles',
                icon: AppIcons.fileText,
                gradient: AppColors.gradientBlueIndigo,
                onTap: () {
                  // TODO: Navigate to mock exam
                  context.push('${AppRoutes.quiz}?mode=mock');
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildClassicMode() {
    return Container(
      padding: AppSpacing.paddingLg,
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: AppRadius.borderRadiusXl,
        border: Border.all(color: AppColors.border),
        boxShadow: AppShadows.listSm,
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
                    colors: AppColors.gradientSlate,
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: AppRadius.borderRadiusLg,
                ),
                child: Icon(
                  AppIcons.clock,
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
                      'Mode Classique',
                      style: AppTypography.h4,
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      'Entraînement complet à votre rythme.',
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
              _DurationChip(
                label: '20 min',
                onTap: () => _startClassicMode(20),
              ),
              const SizedBox(width: AppSpacing.sm),
              _DurationChip(
                label: '40 min',
                onTap: () => _startClassicMode(40),
              ),
              const SizedBox(width: AppSpacing.sm),
              _DurationChip(
                label: '1 h',
                onTap: () => _startClassicMode(60),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _startClassicMode(int minutes) {
    context.push('${AppRoutes.quiz}?mode=classique&time=$minutes');
  }

  Widget _buildTargetedTraining() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Entraînement ciblé',
          style: AppTypography.h3,
        ),
        const SizedBox(height: AppSpacing.lg),
        _TargetedCard(
          title: 'Calcul',
          subtitle: 'Entraînement calcul mental',
          icon: AppIcons.calculator,
          onTap: () {
            context.push('${AppRoutes.quiz}?type=calcul');
          },
        ),
        const SizedBox(height: AppSpacing.md),
        _TargetedCard(
          title: 'Rang des lettres',
          subtitle: 'Maîtrise de l\'alphabet',
          icon: LucideIcons.hash,
          onTap: () {
            context.push('${AppRoutes.quiz}?type=lettres');
          },
        ),
      ],
    );
  }
}

// Mode Card (Blitz, Examen Blanc)
class _ModeCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final List<Color> gradient;
  final VoidCallback? onTap;

  const _ModeCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.gradient,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: AppSpacing.paddingLg,
        height: 120,
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
            Positioned(
              top: -15,
              right: -15,
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withValues(alpha: 0.1),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  icon,
                  color: Colors.white,
                  size: 28,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: AppTypography.labelLarge.copyWith(
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      subtitle,
                      style: AppTypography.bodySmall.copyWith(
                        color: Colors.white.withValues(alpha: 0.8),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Duration Chip (20 min, 40 min, 1h)
class _DurationChip extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;

  const _DurationChip({
    required this.label,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.md,
        ),
        decoration: BoxDecoration(
          color: AppColors.primaryDark,
          borderRadius: AppRadius.borderRadiusFull,
        ),
        child: Text(
          label,
          style: AppTypography.labelLarge.copyWith(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

// Targeted Training Card
class _TargetedCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback? onTap;

  const _TargetedCard({
    required this.title,
    required this.subtitle,
    required this.icon,
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
                color: AppColors.primaryDark.withValues(alpha: 0.1),
                borderRadius: AppRadius.borderRadiusLg,
              ),
              child: Icon(
                icon,
                color: AppColors.primaryDark,
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
                  Text(
                    subtitle,
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

// Subtests Modal
class _SubtestsModal extends StatefulWidget {
  final Set<String> activeSubtests;
  final ValueChanged<Set<String>> onConfirm;

  const _SubtestsModal({
    required this.activeSubtests,
    required this.onConfirm,
  });

  @override
  State<_SubtestsModal> createState() => _SubtestsModalState();
}

class _SubtestsModalState extends State<_SubtestsModal> {
  late Set<String> _selected;

  static const _allSubtests = [
    ('comprehension', 'Compréhension'),
    ('calcul', 'Calcul'),
    ('raisonnement', 'Raisonnement'),
    ('conditions', 'Conditions Minimales'),
    ('expression', 'Expression'),
    ('logique', 'Logique'),
  ];

  @override
  void initState() {
    super.initState();
    _selected = Set.from(widget.activeSubtests);
  }

  void _toggleSubtest(String id) {
    setState(() {
      if (_selected.contains(id)) {
        _selected.remove(id);
      } else {
        _selected.add(id);
      }
    });
  }

  void _selectAll() {
    setState(() {
      _selected = _allSubtests.map((e) => e.$1).toSet();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(AppRadius.xxl),
        ),
      ),
      padding: AppSpacing.paddingXl,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Handle
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.border,
                borderRadius: AppRadius.borderRadiusFull,
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.xl),

          // Title
          Text(
            'Personnaliser vos exercices',
            style: AppTypography.h3,
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'Sélectionnez les sous-tests à inclure dans vos entraînements.',
            style: AppTypography.bodyMedium.copyWith(
              color: AppColors.foregroundMuted,
            ),
          ),
          const SizedBox(height: AppSpacing.xl),

          // Subtests list
          ...List.generate(_allSubtests.length, (index) {
            final (id, label) = _allSubtests[index];
            final isSelected = _selected.contains(id);
            return Padding(
              padding: EdgeInsets.only(
                bottom: index < _allSubtests.length - 1 ? AppSpacing.sm : 0,
              ),
              child: GestureDetector(
                onTap: () => _toggleSubtest(id),
                child: Container(
                  padding: AppSpacing.paddingLg,
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.primaryBlue.withValues(alpha: 0.1)
                        : AppColors.backgroundAlt,
                    borderRadius: AppRadius.borderRadiusLg,
                    border: Border.all(
                      color: isSelected
                          ? AppColors.primaryBlue
                          : AppColors.border,
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          label,
                          style: AppTypography.labelLarge.copyWith(
                            color: isSelected
                                ? AppColors.primaryBlue
                                : AppColors.foreground,
                          ),
                        ),
                      ),
                      Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColors.primaryBlue
                              : Colors.transparent,
                          borderRadius: AppRadius.borderRadiusSm,
                          border: Border.all(
                            color: isSelected
                                ? AppColors.primaryBlue
                                : AppColors.border,
                            width: 2,
                          ),
                        ),
                        child: isSelected
                            ? const Icon(
                                Icons.check,
                                size: 16,
                                color: Colors.white,
                              )
                            : null,
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),

          const SizedBox(height: AppSpacing.xl),

          // Buttons
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: _selectAll,
                  style: OutlinedButton.styleFrom(
                    padding: AppSpacing.verticalLg,
                    side: BorderSide(color: AppColors.border),
                    shape: RoundedRectangleBorder(
                      borderRadius: AppRadius.borderRadiusLg,
                    ),
                  ),
                  child: Text(
                    'Tout sélectionner',
                    style: AppTypography.button.copyWith(
                      color: AppColors.foreground,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    widget.onConfirm(_selected);
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryBlue,
                    padding: AppSpacing.verticalLg,
                    shape: RoundedRectangleBorder(
                      borderRadius: AppRadius.borderRadiusLg,
                    ),
                  ),
                  child: Text(
                    'Valider',
                    style: AppTypography.button.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),

          // Bottom safe area
          SizedBox(height: MediaQuery.of(context).padding.bottom),
        ],
      ),
    );
  }
}
