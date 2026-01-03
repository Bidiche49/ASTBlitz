/// Helpers partagés pour les tests.
library;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Wrapper pour les tests de widgets avec MaterialApp et ProviderScope.
///
/// Usage:
/// ```dart
/// await tester.pumpWidget(
///   testableWidget(MyWidget()),
/// );
/// ```
Widget testableWidget(
  Widget child, {
  List<Override> overrides = const [],
}) {
  return ProviderScope(
    overrides: overrides,
    child: MaterialApp(
      home: child,
    ),
  );
}

/// Wrapper pour les tests de widgets avec Scaffold.
Widget testableWidgetWithScaffold(
  Widget child, {
  List<Override> overrides = const [],
}) {
  return ProviderScope(
    overrides: overrides,
    child: MaterialApp(
      home: Scaffold(body: child),
    ),
  );
}
