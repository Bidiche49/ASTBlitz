import 'package:ast_blitz/presentation/widgets/progress_circle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ProgressCircle', () {
    // ==========================================================================
    // SMOKE TEST
    // ==========================================================================

    testWidgets('renders without errors', (tester) async {
      // ========================================================================
      // ARRANGE
      // ========================================================================
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ProgressCircle(current: 50, max: 100),
          ),
        ),
      );

      // ========================================================================
      // ASSERT
      // ========================================================================
      expect(find.byType(ProgressCircle), findsOneWidget);
    });

    // ==========================================================================
    // TEXT DISPLAY
    // ==========================================================================

    testWidgets('displays current value', (tester) async {
      // ========================================================================
      // ARRANGE
      // ========================================================================
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ProgressCircle(current: 75, max: 100),
          ),
        ),
      );

      // ========================================================================
      // ASSERT
      // ========================================================================
      expect(find.text('75'), findsOneWidget);
    });

    testWidgets('hides text when showText is false', (tester) async {
      // ========================================================================
      // ARRANGE
      // ========================================================================
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ProgressCircle(current: 75, max: 100, showText: false),
          ),
        ),
      );

      // ========================================================================
      // ASSERT
      // ========================================================================
      expect(find.text('75'), findsNothing);
    });

    // ==========================================================================
    // SIZE
    // ==========================================================================

    testWidgets('respects custom size', (tester) async {
      // ========================================================================
      // ARRANGE
      // ========================================================================
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ProgressCircle(current: 50, max: 100, size: 120),
          ),
        ),
      );

      // ========================================================================
      // ASSERT
      // ========================================================================
      final sizedBox = tester.widget<SizedBox>(
        find.descendant(
          of: find.byType(ProgressCircle),
          matching: find.byType(SizedBox),
        ),
      );
      expect(sizedBox.width, 120);
      expect(sizedBox.height, 120);
    });
  });
}
