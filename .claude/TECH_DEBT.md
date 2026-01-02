# Dette Technique - AST Blitz Flutter

> Ce fichier documente les problemes techniques qui ne sont pas des bugs visibles
> mais qui devraient etre corriges pour ameliorer la qualite du code.

---

## Vue d'ensemble

| Priorite | Nombre | Description |
|----------|--------|-------------|
| P1 - Urgent | 0 | Impacte la stabilite |
| P2 - Important | 0 | Impacte la maintenabilite |
| P3 - Mineur | 0 | Amelioration souhaitee |

---

## Index

### P1 - Urgent

| ID | Titre | Impact | Effort | Fiche |
|----|-------|--------|--------|-------|
| - | - | - | - | - |

### P2 - Important

| ID | Titre | Impact | Effort | Fiche |
|----|-------|--------|--------|-------|
| - | - | - | - | - |

### P3 - Mineur

| ID | Titre | Impact | Effort | Fiche |
|----|-------|--------|--------|-------|
| - | - | - | - | - |

---

## Template

```markdown
## TD-XXX: [Titre court]

| Attribut | Valeur |
|----------|--------|
| **ID** | TD-XXX |
| **Priorite** | P1/P2/P3 |
| **Impact** | Performance / Maintenabilite / DX |
| **Effort** | Faible / Moyen / Eleve |
| **Statut** | A faire / En cours / Termine |

### Description
[Description du probleme technique]

### Impact
[Consequences sur le code/performance/maintenabilite]

### Fichiers concernes
- `lib/path/to/file.dart`

### Cause identifiee
[Explication technique]

### Solution proposee
[Approche recommandee]

### Historique
| Date | Action |
|------|--------|
| YYYY-MM-DD | Creation |
```

---

## Exemple

```markdown
## TD-001: Rebuilds excessifs dans QuizScreen

| Attribut | Valeur |
|----------|--------|
| **ID** | TD-001 |
| **Priorite** | P2 |
| **Impact** | Performance |
| **Effort** | Moyen |
| **Statut** | A faire |

### Description
Le QuizScreen rebuild entierement a chaque tick du timer car le provider
n'utilise pas `.select()` pour filtrer les changements.

### Impact
- FPS reduit (~45 au lieu de 60)
- Consommation batterie elevee
- Animations saccadees

### Fichiers concernes
- `lib/presentation/screens/quiz/quiz_screen.dart`
- `lib/presentation/providers/quiz_provider.dart`

### Cause identifiee
`ref.watch(quizProvider)` sans `.select()` cause un rebuild a chaque emission.

### Solution proposee
Utiliser `.select()` pour ne watch que les champs necessaires:
```dart
final timerValue = ref.watch(
  quizProvider.select((state) => state.timerRemaining)
);
```

### Historique
| Date | Action |
|------|--------|
| 2025-01-15 | Creation apres profiling |
```

---

## Regles

### Quand creer une entree

- Workaround temporaire accepte par l'utilisateur
- Code qui fonctionne mais mal structure
- Performance degradee identifiee
- Duplication de code significative
- TODO laisse dans le code

### Quand NE PAS creer d'entree

- Bug visible utilisateur → Creer un fix
- Feature manquante → Creer une FEAT
- Amelioration souhaitee → Creer une FEAT

### Lien avec le code

Quand une dette est creee, ajouter un TODO dans le code:

```dart
// TODO(TD-001): Utiliser .select() pour eviter rebuilds excessifs
// Voir .claude/TECH_DEBT.md pour details
final state = ref.watch(quizProvider);
```

---

## Liens

- [FEATURES.md](./FEATURES/FEATURES.md) - Si c'est une feature
- [TESTING.md](./TESTING/TESTING.md) - Tests associes
