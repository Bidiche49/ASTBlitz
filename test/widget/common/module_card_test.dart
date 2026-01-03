import 'package:ast_blitz/presentation/widgets/module_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ModuleCard', () {
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
            body: ModuleCard(
              title: 'Test Module',
              icon: Icons.star,
            ),
          ),
        ),
      );

      // ========================================================================
      // ASSERT
      // ========================================================================
      expect(find.byType(ModuleCard), findsOneWidget);
    });

    // ==========================================================================
    // CONTENT
    // ==========================================================================

    testWidgets('displays title', (tester) async {
      // ========================================================================
      // ARRANGE
      // ========================================================================
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ModuleCard(
              title: 'Blitz',
              icon: Icons.bolt,
            ),
          ),
        ),
      );

      // ========================================================================
      // ASSERT
      // ========================================================================
      expect(find.text('Blitz'), findsOneWidget);
    });

    testWidgets('displays icon', (tester) async {
      // ========================================================================
      // ARRANGE
      // ========================================================================
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ModuleCard(
              title: 'Test',
              icon: Icons.book,
            ),
          ),
        ),
      );

      // ========================================================================
      // ASSERT
      // ========================================================================
      expect(find.byIcon(Icons.book), findsOneWidget);
    });

    // ==========================================================================
    // INTERACTIONS
    // ==========================================================================

    testWidgets('calls onTap when tapped', (tester) async {
      // ========================================================================
      // ARRANGE
      // ========================================================================
      var tapped = false;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ModuleCard(
              title: 'Tap me',
              icon: Icons.touch_app,
              onTap: () => tapped = true,
            ),
          ),
        ),
      );

      // ========================================================================
      // ACT
      // ========================================================================
      await tester.tap(find.byType(ModuleCard));
      await tester.pumpAndSettle();

      // ========================================================================
      // ASSERT
      // ========================================================================
      expect(tapped, isTrue);
    });
  });
}
