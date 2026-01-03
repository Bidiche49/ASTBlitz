import 'package:ast_blitz/presentation/screens/home/home_screen.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/test_helpers.dart';

void main() {
  group('HomeScreen', () {
    // ==========================================================================
    // SMOKE TEST
    // ==========================================================================

    testWidgets('renders without errors', (tester) async {
      // ========================================================================
      // ARRANGE
      // ========================================================================
      await tester.pumpWidget(
        testableWidget(const HomeScreen()),
      );

      // ========================================================================
      // ASSERT
      // ========================================================================
      expect(find.text('AST BLITZ'), findsOneWidget);
    });

    // ==========================================================================
    // HEADER
    // ==========================================================================

    testWidgets('displays app title in header', (tester) async {
      // ========================================================================
      // ARRANGE
      // ========================================================================
      await tester.pumpWidget(
        testableWidget(const HomeScreen()),
      );

      // ========================================================================
      // ASSERT
      // ========================================================================
      expect(find.text('AST BLITZ'), findsOneWidget);
    });

    // ==========================================================================
    // SCORE PREDICTOR
    // ==========================================================================

    testWidgets('displays score predictor section', (tester) async {
      // ========================================================================
      // ARRANGE
      // ========================================================================
      await tester.pumpWidget(
        testableWidget(const HomeScreen()),
      );

      // ========================================================================
      // ASSERT
      // ========================================================================
      expect(find.text('Score prédit'), findsOneWidget);
      expect(find.text('350 / 600'), findsOneWidget);
      expect(find.text('Objectif: 450'), findsOneWidget);
    });

    // ==========================================================================
    // DAILY QUIZ
    // ==========================================================================

    testWidgets('displays daily quiz card', (tester) async {
      // ========================================================================
      // ARRANGE
      // ========================================================================
      await tester.pumpWidget(
        testableWidget(const HomeScreen()),
      );

      // ========================================================================
      // ASSERT
      // ========================================================================
      expect(find.text('Quiz du Jour'), findsOneWidget);
      expect(find.text('3 questions pour bien démarrer'), findsOneWidget);
    });

    // ==========================================================================
    // MODULES
    // ==========================================================================

    testWidgets('displays all module cards', (tester) async {
      // ========================================================================
      // ARRANGE
      // ========================================================================
      await tester.pumpWidget(
        testableWidget(const HomeScreen()),
      );

      // ========================================================================
      // ASSERT
      // ========================================================================
      expect(find.text('Modules'), findsOneWidget);
      expect(find.text('Blitz'), findsOneWidget);
      expect(find.text('Cours'), findsOneWidget);
      expect(find.text('Mon Professeur'), findsOneWidget);
      expect(find.text('Duel'), findsOneWidget);
    });
  });
}
