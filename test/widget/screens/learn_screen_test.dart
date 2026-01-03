import 'package:ast_blitz/presentation/screens/learn/learn_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget buildTestWidget() {
    return MaterialApp(
      home: MediaQuery(
        data: const MediaQueryData(size: Size(400, 800)),
        child: const LearnScreen(),
      ),
    );
  }

  group('LearnScreen', () {
    // ==========================================================================
    // SMOKE TEST
    // ==========================================================================

    testWidgets('renders without errors', (tester) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pumpAndSettle();

      expect(find.text('APPRENDRE'), findsOneWidget);
    });

    // ==========================================================================
    // TABS
    // ==========================================================================

    testWidgets('displays Cours and Fiches tabs', (tester) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pumpAndSettle();

      expect(find.text('Cours'), findsOneWidget);
      expect(find.text('Fiches'), findsOneWidget);
    });

    // ==========================================================================
    // COURS TAB CONTENT
    // ==========================================================================

    testWidgets('displays Reprendre section', (tester) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pumpAndSettle();

      expect(find.text('Reprendre'), findsWidgets);
    });

    testWidgets('displays Explorer section', (tester) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pumpAndSettle();

      expect(find.text('Explorer les matières'), findsOneWidget);
    });
  });
}
