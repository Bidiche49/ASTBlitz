# TESTING - Couverture de Tests

> Ce fichier centralise la strategie de tests et le suivi de l'avancement.
> Les details de chaque tache de test se trouvent dans les fichiers `TEST-XXX.md`.

---

## Vue d'ensemble

### Objectif

Atteindre **70% de couverture de tests** sur les chemins critiques,
avec focus sur la **qualite** plutot que la quantite.

### Etat actuel

| Metrique | Valeur |
|----------|--------|
| Couverture globale | 0% |
| Tests unitaires | 0 |
| Tests widgets | 0 |
| Tests integration | 0 |

### Couverture par couche (cible)

| Couche | Cible | Actuel |
|--------|-------|--------|
| Models | 80% | 0% |
| Providers | 70% | 0% |
| Repositories | 70% | 0% |
| Widgets | 60% | 0% |
| Screens | 50% | 0% |
| Utils | 80% | 0% |

---

## Regles de gestion

### Structure

```
TESTING/
├── TESTING.md           ← Ce fichier (index)
├── STANDARDS.md         ← Conventions de tests
├── PENDING/             ← Tests a implementer
│   └── TEST-XXX.md
└── COMPLETED/           ← Tests termines
    └── TEST-XXX.md
```

### Workflow

1. **Nouvelle tache de test**: Creer `TEST-XXX.md` dans `PENDING/`
2. **Test en cours**: Mettre a jour le statut
3. **Test termine**: Deplacer vers `COMPLETED/`, noter le commit
4. **Reprise**: Lire ce fichier + STANDARDS.md + fichier test en cours

### Conventions

- **Nommage**: `TEST-XXX.md` (XXX = numero a 3 chiffres)
- **Priorites**: Critique > Haute > Moyenne > Basse
- **Statuts**: A faire | En cours | Termine | Bloque
- **Commits**: Format `test(scope): description`

---

## Index des tests

### Phase 1: Core & Utils

| ID | Titre | Priorite | Statut | Commit | Details |
|----|-------|----------|--------|--------|---------|
| TEST-001 | Tests AppColors | Moyenne | A faire | - | [Fiche](./PENDING/TEST-001.md) |
| TEST-002 | Tests AppTypography | Moyenne | A faire | - | - |
| TEST-003 | Tests Utils | Haute | A faire | - | - |

### Phase 2: Providers

| ID | Titre | Priorite | Statut | Commit | Details |
|----|-------|----------|--------|--------|---------|
| TEST-010 | Tests QuizProvider | Critique | A faire | - | - |
| TEST-011 | Tests UserProvider | Haute | A faire | - | - |
| TEST-012 | Tests CourseProvider | Haute | A faire | - | - |

### Phase 3: Widgets

| ID | Titre | Priorite | Statut | Commit | Details |
|----|-------|----------|--------|--------|---------|
| TEST-020 | Tests AppButton | Moyenne | A faire | - | - |
| TEST-021 | Tests ModuleCard | Moyenne | A faire | - | - |
| TEST-022 | Tests ProgressCircle | Moyenne | A faire | - | - |

### Phase 4: Screens

| ID | Titre | Priorite | Statut | Commit | Details |
|----|-------|----------|--------|--------|---------|
| TEST-030 | Smoke test HomeScreen | Haute | A faire | - | - |
| TEST-031 | Tests QuizScreen | Critique | A faire | - | - |
| TEST-032 | Tests ProfileScreen | Moyenne | A faire | - | - |

---

## Statistiques

| Statut | Phase 1 | Phase 2 | Phase 3 | Phase 4 | Total |
|--------|---------|---------|---------|---------|-------|
| Termine | 0 | 0 | 0 | 0 | 0 |
| En cours | 0 | 0 | 0 | 0 | 0 |
| A faire | 3 | 3 | 3 | 3 | 12 |

---

## Commandes

```bash
# Lancer tous les tests
flutter test

# Lancer tests d'un fichier
flutter test test/unit/xxx_test.dart

# Avec couverture
flutter test --coverage

# Generer rapport HTML
genhtml coverage/lcov.info -o coverage/html
open coverage/html/index.html
```

---

## Liens

- [STANDARDS.md](./STANDARDS.md) - Conventions de tests
- [FEATURES.md](../FEATURES/FEATURES.md) - Features correspondantes
