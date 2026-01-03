# Standards de Tests - AST Blitz Flutter

> Conventions et patterns obligatoires pour tous les tests.

---

## 1. Philosophie

### Pourquoi tester

- Detecter les bugs AVANT la production
- Documenter le comportement attendu
- Permettre le refactoring sans peur
- Accelerer le developpement long terme

### Principes

| Principe | Description |
|----------|-------------|
| **Un test = une assertion** | Chaque test verifie UNE seule chose |
| **Independance** | Les tests ne dependent pas les uns des autres |
| **Determinisme** | Un test donne toujours le meme resultat |
| **Rapidite** | Tests unitaires < 100ms |
| **Lisibilite** | Le nom decrit ce qu'il teste |

---

## 2. Pattern AAA

**OBLIGATOIRE** pour tous les tests.

```dart
test('description claire du comportement', () {
  // ============================================================
  // ARRANGE - Preparer les donnees et mocks
  // ============================================================
  final mockService = MockService();
  when(() => mockService.getData()).thenReturn(data);

  // ============================================================
  // ACT - Executer l'action a tester
  // ============================================================
  final result = sut.doSomething();

  // ============================================================
  // ASSERT - Verifier le resultat
  // ============================================================
  expect(result, expectedValue);
  verify(() => mockService.getData()).called(1);
});
```

---

## 3. Structure des fichiers

```
test/
├── helpers/
│   └── mocks.dart              # Mocks partages
├── unit/
│   ├── providers/
│   │   └── xxx_provider_test.dart
│   ├── models/
│   │   └── xxx_model_test.dart
│   └── utils/
│       └── xxx_utils_test.dart
├── widget/
│   ├── common/
│   │   └── xxx_widget_test.dart
│   └── screens/
│       └── xxx_screen_test.dart
└── integration/
    └── xxx_integration_test.dart
```

---

## 4. Nommage

### Fichiers

| Type | Pattern | Exemple |
|------|---------|---------|
| Unit | `{class}_test.dart` | `quiz_provider_test.dart` |
| Widget | `{widget}_test.dart` | `module_card_test.dart` |
| Integration | `{feature}_integration_test.dart` | `quiz_flow_integration_test.dart` |

### Tests

Format: `{action} {result} when {condition}`

**Bons exemples:**
```dart
test('returns questions when quiz starts', () {});
test('throws TimeoutException when timer expires', () {});
test('increments score when answer is correct', () {});
```

**Mauvais exemples:**
```dart
test('test1', () {});           // Non descriptif
test('it works', () {});        // Trop vague
test('should return', () {});   // "should" superflu
```

---

## 5. Tests OBLIGATOIRES

**Ces tests sont NON NEGOCIABLES pour chaque composant.**

### 5.1 Ecrans (Screens)

| Test | Description | Priorite |
|------|-------------|----------|
| **Smoke test** | L'ecran se charge sans crash | P0 |
| **Elements UI** | Les elements principaux sont presents | P0 |
| **Validation** | Erreurs affichees si formulaire invalide | P1 |

```dart
group('MyScreen', () {
  // P0 - OBLIGATOIRE
  testWidgets('renders without errors', (tester) async {
    await tester.pumpWidget(buildTestWidget());
    expect(find.byType(MyScreen), findsOneWidget);
  });

  // P0 - OBLIGATOIRE
  testWidgets('displays main UI elements', (tester) async {
    await tester.pumpWidget(buildTestWidget());
    expect(find.text('Titre'), findsOneWidget);
    expect(find.byType(ElevatedButton), findsWidgets);
  });

  // P1 - Recommande si formulaire
  testWidgets('shows error when input is invalid', (tester) async {
    // ...
  });
});
```

### 5.2 Widgets reutilisables

| Test | Description | Priorite |
|------|-------------|----------|
| **Smoke test** | Le widget se charge | P0 |
| **Props** | Les props sont respectees | P0 |
| **Callbacks** | onTap/onPressed fonctionne | P1 |
| **Etats** | loading, disabled, error | P1 |

```dart
group('MyWidget', () {
  // P0 - OBLIGATOIRE
  testWidgets('renders without errors', (tester) async {
    await tester.pumpWidget(MyWidget());
    expect(find.byType(MyWidget), findsOneWidget);
  });

  // P0 - OBLIGATOIRE
  testWidgets('displays label from props', (tester) async {
    await tester.pumpWidget(MyWidget(label: 'Test'));
    expect(find.text('Test'), findsOneWidget);
  });

  // P1 - Recommande
  testWidgets('calls onTap when tapped', (tester) async {
    var tapped = false;
    await tester.pumpWidget(MyWidget(onTap: () => tapped = true));
    await tester.tap(find.byType(MyWidget));
    expect(tapped, isTrue);
  });
});
```

### 5.3 Providers / Notifiers

| Test | Description | Priorite |
|------|-------------|----------|
| **Etat initial** | L'etat initial est correct | P0 |
| **Happy path** | L'action principale fonctionne | P0 |
| **Erreurs** | Les erreurs sont gerees | P1 |

### 5.4 Resume des tests obligatoires

| Composant | Minimum tests | Tests obligatoires |
|-----------|---------------|-------------------|
| **Screen** | 2 | smoke + elements UI |
| **Widget** | 2 | smoke + props |
| **Provider** | 2 | etat initial + happy path |
| **Model** | 1 | serialization (si applicable) |

> **REGLE**: Un composant sans ses tests obligatoires ne peut PAS etre commit.

---

## 6. Edge Cases Recommandes

Pour chaque fonctionnalite (au-dela des tests obligatoires):

```dart
group('methodName', () {
  // Happy path
  test('succeeds with valid input', () {});

  // Validation
  test('throws when input is null', () {});
  test('throws when input is empty', () {});
  test('handles boundary values', () {});

  // Erreurs
  test('throws when network fails', () {});
  test('handles timeout gracefully', () {});

  // Etats particuliers
  test('handles concurrent calls', () {});
});
```

---

## 6. Mocking avec Mocktail

### Creer un mock

```dart
import 'package:mocktail/mocktail.dart';

class MockQuizRepository extends Mock implements QuizRepository {}
```

### Configurer

```dart
// Retourner une valeur
when(() => mock.getQuestions()).thenReturn(questions);

// Retourner un Future
when(() => mock.fetchData()).thenAnswer((_) async => data);

// Lancer exception
when(() => mock.save()).thenThrow(Exception('error'));
```

### Verifier

```dart
verify(() => mock.save(any())).called(1);
verifyNever(() => mock.delete());
```

### Fallback values

```dart
setUpAll(() {
  registerFallbackValue(FakeQuestion());
});

class FakeQuestion extends Fake implements Question {}
```

---

## 7. Tests de Widgets

```dart
testWidgets('displays timer when quiz starts', (tester) async {
  // ARRANGE
  await tester.pumpWidget(
    MaterialApp(
      home: QuizScreen(questions: testQuestions),
    ),
  );

  // ACT
  await tester.tap(find.text('Start'));
  await tester.pumpAndSettle();

  // ASSERT
  expect(find.byType(TimerWidget), findsOneWidget);
});
```

### Finders courants

```dart
find.text('Text exact')
find.byType(WidgetType)
find.byKey(Key('my_key'))
find.byIcon(Icons.check)
```

### Actions courantes

```dart
await tester.tap(finder);
await tester.enterText(finder, 'text');
await tester.pump();           // 1 frame
await tester.pumpAndSettle();  // Attendre stabilisation
```

---

## 8. Tests Riverpod

```dart
testWidgets('provider updates state', (tester) async {
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        quizRepositoryProvider.overrideWithValue(mockRepository),
      ],
      child: MaterialApp(home: QuizScreen()),
    ),
  );

  // ...
});
```

---

## 9. Checklist avant commit

- [ ] Pattern AAA respecte avec commentaires
- [ ] Noms de tests descriptifs
- [ ] Edge cases couverts
- [ ] Pas de `skip: true` sans justification
- [ ] `flutter test` passe
- [ ] Pas de warnings

---

## 10. Anti-patterns

| Anti-pattern | Probleme | Solution |
|--------------|----------|----------|
| Test flaky | Echec aleatoire | Mocker le temps, eviter DateTime.now() |
| Test lent | > 1s pour unitaire | Mocker les IO |
| Test couple | Depend d'un autre | Utiliser setUp() |
| Test fragile | Casse a chaque changement | Tester comportement, pas implementation |
