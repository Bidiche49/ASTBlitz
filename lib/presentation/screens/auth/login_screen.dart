// TODO: P1-006 - Reimporter quand Apple Sign-In configure
// import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../navigation/app_router.dart';
import '../../providers/auth_provider.dart';
import 'widgets/auth_text_field.dart';
import 'widgets/social_login_button.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) return;

    final success = await ref.read(authProvider.notifier).signInWithEmail(
          email: _emailController.text,
          password: _passwordController.text,
        );

    if (success && mounted) {
      context.go(AppRoutes.home);
    }
  }

  Future<void> _handleGoogleLogin() async {
    final success = await ref.read(authProvider.notifier).signInWithGoogle();
    if (success && mounted) {
      context.go(AppRoutes.home);
    }
  }

  // TODO: P1-006 - Reactiver quand Apple Sign-In configure
  // Future<void> _handleAppleLogin() async {
  //   final success = await ref.read(authProvider.notifier).signInWithApple();
  //   if (success && mounted) {
  //     context.go(AppRoutes.home);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    final isLoading = authState is AuthLoading;

    ref.listen<AuthState>(authProvider, (previous, next) {
      if (next is AuthError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.message),
            backgroundColor: AppColors.destructive,
          ),
        );
        ref.read(authProvider.notifier).clearError();
      }
    });

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: AppSpacing.paddingXl,
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: AppSpacing.xxl),

                // Logo
                _buildLogo(),
                const SizedBox(height: AppSpacing.xxl * 2),

                // Titre
                Text(
                  'Connexion',
                  style: AppTypography.h1,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  'Connectez-vous pour continuer',
                  style: AppTypography.bodyMedium.copyWith(
                    color: AppColors.foregroundMuted,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppSpacing.xxl),

                // Email
                AuthTextField(
                  controller: _emailController,
                  label: 'Email',
                  keyboardType: TextInputType.emailAddress,
                  validator: _validateEmail,
                ),
                const SizedBox(height: AppSpacing.lg),

                // Password
                AuthTextField(
                  controller: _passwordController,
                  label: 'Mot de passe',
                  obscureText: _obscurePassword,
                  textInputAction: TextInputAction.done,
                  onFieldSubmitted: (_) => _handleLogin(),
                  validator: _validatePassword,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                    ),
                    onPressed: () {
                      setState(() => _obscurePassword = !_obscurePassword);
                    },
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),

                // Mot de passe oublie
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      // TODO: Forgot password flow
                    },
                    child: Text(
                      'Mot de passe oublie ?',
                      style: AppTypography.bodySmall.copyWith(
                        color: AppColors.primaryBlue,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),

                // Bouton connexion
                SizedBox(
                  height: 52,
                  child: ElevatedButton(
                    onPressed: isLoading ? null : _handleLogin,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryDark,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: AppRadius.borderRadiusMd,
                      ),
                    ),
                    child: isLoading
                        ? const SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : Text(
                            'Se connecter',
                            style: AppTypography.labelLarge.copyWith(
                              color: Colors.white,
                            ),
                          ),
                  ),
                ),
                const SizedBox(height: AppSpacing.xxl),

                // Separateur
                _buildDivider(),
                const SizedBox(height: AppSpacing.xxl),

                // Boutons sociaux
                SocialLoginButton(
                  type: SocialLoginType.google,
                  onPressed: _handleGoogleLogin,
                  isLoading: isLoading,
                ),
                // TODO: P1-006 - Reactiver quand Apple Developer configure
                // if (Platform.isIOS) ...[
                //   const SizedBox(height: AppSpacing.md),
                //   SocialLoginButton(
                //     type: SocialLoginType.apple,
                //     onPressed: _handleAppleLogin,
                //     isLoading: isLoading,
                //   ),
                // ],
                const SizedBox(height: AppSpacing.xxl),

                // Lien inscription
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Pas de compte ? ',
                      style: AppTypography.bodyMedium.copyWith(
                        color: AppColors.foregroundMuted,
                      ),
                    ),
                    TextButton(
                      onPressed: () => context.go(AppRoutes.register),
                      child: Text(
                        "S'inscrire",
                        style: AppTypography.labelLarge.copyWith(
                          color: AppColors.primaryBlue,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: AppColors.gradientSlate,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: AppRadius.borderRadiusXl,
      ),
      child: const Center(
        child: Text(
          'AST',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Row(
      children: [
        const Expanded(child: Divider(color: AppColors.border)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
          child: Text(
            'ou',
            style: AppTypography.bodySmall.copyWith(
              color: AppColors.foregroundMuted,
            ),
          ),
        ),
        const Expanded(child: Divider(color: AppColors.border)),
      ],
    );
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email requis';
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Email invalide';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Mot de passe requis';
    }
    if (value.length < 6) {
      return 'Minimum 6 caracteres';
    }
    return null;
  }
}
