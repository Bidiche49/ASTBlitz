import 'package:ast_blitz/data/repositories/auth_repository.dart';
import 'package:ast_blitz/presentation/providers/auth_provider.dart';
import 'package:ast_blitz/presentation/screens/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late MockAuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    // Mock authStateChanges to return empty stream
    when(() => mockAuthRepository.authStateChanges)
        .thenAnswer((_) => const Stream.empty());
    when(() => mockAuthRepository.currentUser).thenReturn(null);
  });

  Widget buildTestWidget() {
    return ProviderScope(
      overrides: [
        authRepositoryProvider.overrideWithValue(mockAuthRepository),
        authProvider.overrideWith((ref) => AuthNotifier(mockAuthRepository)),
      ],
      child: const MaterialApp(
        home: LoginScreen(),
      ),
    );
  }

  group('LoginScreen', () {
    // ==========================================================================
    // SMOKE TEST
    // ==========================================================================

    testWidgets('renders without errors', (tester) async {
      // ========================================================================
      // ARRANGE
      // ========================================================================
      await tester.pumpWidget(buildTestWidget());
      await tester.pump();

      // ========================================================================
      // ASSERT
      // ========================================================================
      expect(find.text('Connexion'), findsOneWidget);
    });

    // ==========================================================================
    // UI ELEMENTS
    // ==========================================================================

    testWidgets('displays email and password fields', (tester) async {
      // ========================================================================
      // ARRANGE
      // ========================================================================
      await tester.pumpWidget(buildTestWidget());
      await tester.pump();

      // ========================================================================
      // ASSERT
      // ========================================================================
      expect(find.text('Email'), findsOneWidget);
      expect(find.text('Mot de passe'), findsOneWidget);
    });

    testWidgets('displays login button', (tester) async {
      // ========================================================================
      // ARRANGE
      // ========================================================================
      await tester.pumpWidget(buildTestWidget());
      await tester.pump();

      // ========================================================================
      // ASSERT
      // ========================================================================
      expect(find.text('Se connecter'), findsOneWidget);
    });

    testWidgets('displays Google sign-in button', (tester) async {
      // ========================================================================
      // ARRANGE
      // ========================================================================
      await tester.pumpWidget(buildTestWidget());
      await tester.pump();

      // ========================================================================
      // ASSERT
      // ========================================================================
      expect(find.text('Continuer avec Google'), findsOneWidget);
    });

    testWidgets('displays register link', (tester) async {
      // ========================================================================
      // ARRANGE
      // ========================================================================
      await tester.pumpWidget(buildTestWidget());
      await tester.pump();

      // ========================================================================
      // ASSERT
      // ========================================================================
      expect(find.text('Pas de compte ? '), findsOneWidget);
      expect(find.text("S'inscrire"), findsOneWidget);
    });

    // ==========================================================================
    // VALIDATION
    // ==========================================================================

    testWidgets('shows error when email is empty', (tester) async {
      // ========================================================================
      // ARRANGE
      // ========================================================================
      await tester.pumpWidget(buildTestWidget());
      await tester.pump();

      // ========================================================================
      // ACT
      // ========================================================================
      await tester.tap(find.text('Se connecter'));
      await tester.pumpAndSettle();

      // ========================================================================
      // ASSERT
      // ========================================================================
      expect(find.text('Email requis'), findsOneWidget);
    });

    testWidgets('shows error when email format is invalid', (tester) async {
      // ========================================================================
      // ARRANGE
      // ========================================================================
      await tester.pumpWidget(buildTestWidget());
      await tester.pump();

      // ========================================================================
      // ACT
      // ========================================================================
      await tester.enterText(find.byType(TextFormField).first, 'invalid-email');
      await tester.tap(find.text('Se connecter'));
      await tester.pumpAndSettle();

      // ========================================================================
      // ASSERT
      // ========================================================================
      expect(find.text('Email invalide'), findsOneWidget);
    });
  });
}
