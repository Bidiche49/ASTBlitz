import 'package:ast_blitz/data/repositories/auth_repository.dart';
import 'package:ast_blitz/presentation/providers/auth_provider.dart';
import 'package:ast_blitz/presentation/screens/auth/register_screen.dart';
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
        home: RegisterScreen(),
      ),
    );
  }

  group('RegisterScreen', () {
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
      expect(find.text('Inscription'), findsOneWidget);
    });

    // ==========================================================================
    // UI ELEMENTS
    // ==========================================================================

    testWidgets('displays all form fields', (tester) async {
      // ========================================================================
      // ARRANGE
      // ========================================================================
      await tester.pumpWidget(buildTestWidget());
      await tester.pump();

      // ========================================================================
      // ASSERT
      // ========================================================================
      expect(find.text('Nom'), findsOneWidget);
      expect(find.text('Email'), findsOneWidget);
      expect(find.text('Mot de passe'), findsOneWidget);
      expect(find.text('Confirmer le mot de passe'), findsOneWidget);
    });

    testWidgets('displays register button', (tester) async {
      // ========================================================================
      // ARRANGE
      // ========================================================================
      await tester.pumpWidget(buildTestWidget());
      await tester.pump();

      // ========================================================================
      // ASSERT
      // ========================================================================
      expect(find.text('Creer mon compte'), findsOneWidget);
    });

    testWidgets('displays login link', (tester) async {
      // ========================================================================
      // ARRANGE
      // ========================================================================
      await tester.pumpWidget(buildTestWidget());
      await tester.pump();

      // ========================================================================
      // ASSERT
      // ========================================================================
      expect(find.text('Deja un compte ? '), findsOneWidget);
      expect(find.text('Se connecter'), findsOneWidget);
    });

    // ==========================================================================
    // VALIDATION
    // ==========================================================================

    testWidgets('shows error when name is empty', (tester) async {
      // ========================================================================
      // ARRANGE
      // ========================================================================
      await tester.pumpWidget(buildTestWidget());
      await tester.pump();

      // ========================================================================
      // ACT
      // ========================================================================
      await tester.tap(find.text('Creer mon compte'));
      await tester.pumpAndSettle();

      // ========================================================================
      // ASSERT
      // ========================================================================
      expect(find.text('Nom requis'), findsOneWidget);
    });
  });
}
