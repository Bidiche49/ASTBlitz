/// Fichier de mocks partagés pour les tests.
///
/// Utilise mocktail pour les mocks.
/// Pattern: class MockXxx extends Mock implements Xxx {}
library;

// =============================================================================
// SERVICES
// =============================================================================

// TODO: Ajouter les mocks de services au fur et à mesure
// class MockFirebaseService extends Mock implements FirebaseService {}

// =============================================================================
// REPOSITORIES
// =============================================================================

// TODO: Ajouter les mocks de repositories au fur et à mesure
// class MockQuizRepository extends Mock implements QuizRepository {}

// =============================================================================
// FAKES (pour registerFallbackValue)
// =============================================================================

// TODO: Ajouter les fakes au fur et à mesure
// class FakeQuestion extends Fake implements Question {}

// =============================================================================
// SETUP
// =============================================================================

/// Appeler dans setUpAll() pour enregistrer les fallback values.
void registerFallbackValues() {
  // registerFallbackValue(FakeQuestion());
}
