import 'package:ast_blitz/presentation/screens/exercises/exercises_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget buildTestWidget({Size size = const Size(400, 800)}) {
    return MaterialApp(
      home: MediaQuery(
        data: MediaQueryData(size: size),
        child: const ExercisesScreen(),
      ),
    );
  }

  group('ExercisesScreen', () {
    // ==========================================================================
    // SMOKE TEST
    // ==========================================================================

    testWidgets('renders without errors', (tester) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pump();

      expect(find.text('EXERCICES'), findsOneWidget);
    });

    // ==========================================================================
    // HEADER
    // ==========================================================================

    testWidgets('displays header with intro text', (tester) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pump();

      expect(find.text('Prêt à t\'entraîner ?'), findsOneWidget);
      expect(find.text('Choisis ton mode de préparation.'), findsOneWidget);
    });

    // ==========================================================================
    // SUBTESTS CARD
    // ==========================================================================

    testWidgets('displays subtests customization card', (tester) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pump();

      expect(find.text('Choisir quel sous-test réviser'), findsOneWidget);
      expect(find.text('Personnaliser'), findsOneWidget);
    });

    // ==========================================================================
    // MODES
    // ==========================================================================

    testWidgets('displays quick modes (Blitz and Examen Blanc)', (tester) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pump();

      expect(find.text('Mode Blitz'), findsOneWidget);
      expect(find.text('Questions rapides'), findsOneWidget);
      expect(find.text('Examen Blanc'), findsOneWidget);
      expect(find.text('Conditions réelles'), findsOneWidget);
    });

    testWidgets('displays classic mode with durations', (tester) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pump();

      expect(find.text('Mode Classique'), findsOneWidget);
      expect(find.text('20 min'), findsOneWidget);
      expect(find.text('40 min'), findsOneWidget);
      expect(find.text('1 h'), findsOneWidget);
    });

    // ==========================================================================
    // TARGETED TRAINING
    // ==========================================================================

    testWidgets('displays targeted training options', (tester) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pump();

      expect(find.text('Entraînement ciblé'), findsOneWidget);
      expect(find.text('Calcul'), findsOneWidget);
      expect(find.text('Rang des lettres'), findsOneWidget);
    });

  });
}
