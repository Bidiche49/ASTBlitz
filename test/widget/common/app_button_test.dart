import 'package:ast_blitz/presentation/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppButton', () {
    // ==========================================================================
    // SMOKE TESTS
    // ==========================================================================

    testWidgets('renders with label', (tester) async {
      // ========================================================================
      // ARRANGE
      // ========================================================================
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppButton(label: 'Test Button'),
          ),
        ),
      );

      // ========================================================================
      // ASSERT
      // ========================================================================
      expect(find.text('Test Button'), findsOneWidget);
    });

    testWidgets('renders with icon', (tester) async {
      // ========================================================================
      // ARRANGE
      // ========================================================================
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppButton(icon: Icons.add, size: ButtonSize.icon),
          ),
        ),
      );

      // ========================================================================
      // ASSERT
      // ========================================================================
      expect(find.byIcon(Icons.add), findsOneWidget);
    });

    // ==========================================================================
    // VARIANTS
    // ==========================================================================

    testWidgets('renders primary variant', (tester) async {
      // ========================================================================
      // ARRANGE
      // ========================================================================
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppButton(
              label: 'Primary',
              variant: ButtonVariant.primary,
            ),
          ),
        ),
      );

      // ========================================================================
      // ASSERT
      // ========================================================================
      expect(find.byType(ElevatedButton), findsOneWidget);
    });

    testWidgets('renders outline variant', (tester) async {
      // ========================================================================
      // ARRANGE
      // ========================================================================
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppButton(
              label: 'Outline',
              variant: ButtonVariant.outline,
            ),
          ),
        ),
      );

      // ========================================================================
      // ASSERT
      // ========================================================================
      expect(find.byType(OutlinedButton), findsOneWidget);
    });

    // ==========================================================================
    // LOADING STATE
    // ==========================================================================

    testWidgets('shows loading indicator when isLoading is true', (tester) async {
      // ========================================================================
      // ARRANGE
      // ========================================================================
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppButton(
              label: 'Loading',
              isLoading: true,
            ),
          ),
        ),
      );

      // ========================================================================
      // ASSERT
      // ========================================================================
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.text('Loading'), findsNothing);
    });

    // ==========================================================================
    // INTERACTIONS
    // ==========================================================================

    testWidgets('calls onPressed when tapped', (tester) async {
      // ========================================================================
      // ARRANGE
      // ========================================================================
      var pressed = false;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppButton(
              label: 'Tap me',
              onPressed: () => pressed = true,
            ),
          ),
        ),
      );

      // ========================================================================
      // ACT
      // ========================================================================
      await tester.tap(find.text('Tap me'));

      // ========================================================================
      // ASSERT
      // ========================================================================
      expect(pressed, isTrue);
    });

    testWidgets('does not call onPressed when disabled', (tester) async {
      // ========================================================================
      // ARRANGE
      // ========================================================================
      var pressed = false;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppButton(
              label: 'Disabled',
              onPressed: null,
            ),
          ),
        ),
      );

      // ========================================================================
      // ACT
      // ========================================================================
      await tester.tap(find.text('Disabled'));

      // ========================================================================
      // ASSERT
      // ========================================================================
      expect(pressed, isFalse);
    });
  });
}
