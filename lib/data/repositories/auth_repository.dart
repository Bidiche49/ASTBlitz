import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

/// Resultat d'une operation d'authentification.
sealed class AuthResult {
  const AuthResult();
}

class AuthSuccess extends AuthResult {
  final User user;
  const AuthSuccess(this.user);
}

class AuthFailure extends AuthResult {
  final String message;
  final String? code;
  const AuthFailure(this.message, {this.code});
}

/// Repository pour l'authentification Firebase.
class AuthRepository {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  AuthRepository({
    FirebaseAuth? firebaseAuth,
    GoogleSignIn? googleSignIn,
  })  : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _googleSignIn = googleSignIn ?? GoogleSignIn();

  /// Stream de l'utilisateur connecte.
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  /// Utilisateur actuel.
  User? get currentUser => _firebaseAuth.currentUser;

  /// Connexion avec email/password.
  Future<AuthResult> signInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      return AuthSuccess(credential.user!);
    } on FirebaseAuthException catch (e) {
      return AuthFailure(_mapFirebaseError(e.code), code: e.code);
    } catch (e) {
      return AuthFailure('Une erreur est survenue');
    }
  }

  /// Inscription avec email/password.
  Future<AuthResult> signUpWithEmail({
    required String email,
    required String password,
    String? displayName,
  }) async {
    try {
      final credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );

      if (displayName != null && displayName.isNotEmpty) {
        await credential.user!.updateDisplayName(displayName);
      }

      return AuthSuccess(credential.user!);
    } on FirebaseAuthException catch (e) {
      return AuthFailure(_mapFirebaseError(e.code), code: e.code);
    } catch (e) {
      return AuthFailure('Une erreur est survenue');
    }
  }

  /// Connexion avec Google.
  Future<AuthResult> signInWithGoogle() async {
    try {
      final googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        return const AuthFailure('Connexion annulee');
      }

      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential =
          await _firebaseAuth.signInWithCredential(credential);
      return AuthSuccess(userCredential.user!);
    } on FirebaseAuthException catch (e) {
      return AuthFailure(_mapFirebaseError(e.code), code: e.code);
    } catch (e) {
      return AuthFailure('Erreur Google Sign-In');
    }
  }

  /// Connexion avec Apple (iOS uniquement).
  Future<AuthResult> signInWithApple() async {
    if (!Platform.isIOS) {
      return const AuthFailure('Apple Sign-In disponible uniquement sur iOS');
    }

    try {
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      final oauthCredential = OAuthProvider('apple.com').credential(
        idToken: appleCredential.identityToken,
        accessToken: appleCredential.authorizationCode,
      );

      final userCredential =
          await _firebaseAuth.signInWithCredential(oauthCredential);

      // Apple ne renvoie le nom que lors de la premiere connexion
      if (appleCredential.givenName != null) {
        final displayName =
            '${appleCredential.givenName} ${appleCredential.familyName ?? ''}'
                .trim();
        await userCredential.user!.updateDisplayName(displayName);
      }

      return AuthSuccess(userCredential.user!);
    } on SignInWithAppleAuthorizationException catch (e) {
      if (e.code == AuthorizationErrorCode.canceled) {
        return const AuthFailure('Connexion annulee');
      }
      return AuthFailure('Erreur Apple Sign-In: ${e.message}');
    } on FirebaseAuthException catch (e) {
      return AuthFailure(_mapFirebaseError(e.code), code: e.code);
    } catch (e) {
      return AuthFailure('Erreur Apple Sign-In');
    }
  }

  /// Deconnexion.
  Future<void> signOut() async {
    await Future.wait([
      _firebaseAuth.signOut(),
      _googleSignIn.signOut(),
    ]);
  }

  /// Envoi email de reinitialisation mot de passe.
  Future<AuthResult> sendPasswordResetEmail(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email.trim());
      return AuthSuccess(_firebaseAuth.currentUser!);
    } on FirebaseAuthException catch (e) {
      return AuthFailure(_mapFirebaseError(e.code), code: e.code);
    } catch (e) {
      return const AuthFailure('Une erreur est survenue');
    }
  }

  /// Mappe les codes d'erreur Firebase vers des messages utilisateur.
  String _mapFirebaseError(String code) {
    return switch (code) {
      'user-not-found' => 'Aucun compte avec cet email',
      'wrong-password' => 'Mot de passe incorrect',
      'email-already-in-use' => 'Cet email est deja utilise',
      'weak-password' => 'Mot de passe trop faible (min 6 caracteres)',
      'invalid-email' => 'Email invalide',
      'user-disabled' => 'Ce compte a ete desactive',
      'too-many-requests' => 'Trop de tentatives, reessayez plus tard',
      'operation-not-allowed' => 'Operation non autorisee',
      'invalid-credential' => 'Identifiants invalides',
      _ => 'Une erreur est survenue',
    };
  }
}

/// Provider pour AuthRepository.
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository();
});

/// Provider pour le stream d'auth state.
final authStateProvider = StreamProvider<User?>((ref) {
  return ref.watch(authRepositoryProvider).authStateChanges;
});

/// Provider pour savoir si l'utilisateur est authentifie.
final isAuthenticatedProvider = Provider<bool>((ref) {
  final authState = ref.watch(authStateProvider);
  return authState.whenOrNull(data: (user) => user != null) ?? false;
});
