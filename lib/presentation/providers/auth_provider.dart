import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/auth_repository.dart';

/// Etat de l'authentification pour l'UI.
sealed class AuthState {
  const AuthState();
}

class AuthInitial extends AuthState {
  const AuthInitial();
}

class AuthLoading extends AuthState {
  const AuthLoading();
}

class AuthAuthenticated extends AuthState {
  final String? displayName;
  final String? email;

  const AuthAuthenticated({this.displayName, this.email});
}

class AuthUnauthenticated extends AuthState {
  const AuthUnauthenticated();
}

class AuthError extends AuthState {
  final String message;
  const AuthError(this.message);
}

/// Notifier pour gerer l'authentification.
class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepository _authRepository;

  AuthNotifier(this._authRepository) : super(const AuthInitial()) {
    _init();
  }

  void _init() {
    _authRepository.authStateChanges.listen((user) {
      if (user != null) {
        state = AuthAuthenticated(
          displayName: user.displayName,
          email: user.email,
        );
      } else {
        state = const AuthUnauthenticated();
      }
    });
  }

  /// Connexion avec email/password.
  Future<bool> signInWithEmail({
    required String email,
    required String password,
  }) async {
    state = const AuthLoading();

    final result = await _authRepository.signInWithEmail(
      email: email,
      password: password,
    );

    return switch (result) {
      AuthSuccess(user: final user) => () {
          state = AuthAuthenticated(
            displayName: user.displayName,
            email: user.email,
          );
          return true;
        }(),
      AuthFailure(message: final message) => () {
          state = AuthError(message);
          return false;
        }(),
    };
  }

  /// Inscription avec email/password.
  Future<bool> signUpWithEmail({
    required String email,
    required String password,
    String? displayName,
  }) async {
    state = const AuthLoading();

    final result = await _authRepository.signUpWithEmail(
      email: email,
      password: password,
      displayName: displayName,
    );

    return switch (result) {
      AuthSuccess(user: final user) => () {
          state = AuthAuthenticated(
            displayName: user.displayName,
            email: user.email,
          );
          return true;
        }(),
      AuthFailure(message: final message) => () {
          state = AuthError(message);
          return false;
        }(),
    };
  }

  /// Connexion avec Google.
  Future<bool> signInWithGoogle() async {
    state = const AuthLoading();

    final result = await _authRepository.signInWithGoogle();

    return switch (result) {
      AuthSuccess(user: final user) => () {
          state = AuthAuthenticated(
            displayName: user.displayName,
            email: user.email,
          );
          return true;
        }(),
      AuthFailure(message: final message) => () {
          state = AuthError(message);
          return false;
        }(),
    };
  }

  /// Connexion avec Apple.
  Future<bool> signInWithApple() async {
    state = const AuthLoading();

    final result = await _authRepository.signInWithApple();

    return switch (result) {
      AuthSuccess(user: final user) => () {
          state = AuthAuthenticated(
            displayName: user.displayName,
            email: user.email,
          );
          return true;
        }(),
      AuthFailure(message: final message) => () {
          state = AuthError(message);
          return false;
        }(),
    };
  }

  /// Deconnexion.
  Future<void> signOut() async {
    await _authRepository.signOut();
    state = const AuthUnauthenticated();
  }

  /// Reset l'erreur pour revenir a l'etat unauthenticated.
  void clearError() {
    if (state is AuthError) {
      state = const AuthUnauthenticated();
    }
  }
}

/// Provider pour AuthNotifier.
final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier(ref.watch(authRepositoryProvider));
});
