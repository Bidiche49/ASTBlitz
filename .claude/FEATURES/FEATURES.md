# FEATURES - Index des Fonctionnalites

> Ce fichier centralise toutes les features a implementer.
> Les details de chaque feature se trouvent dans les fichiers individuels `FEAT-XXX.md`.

---

## Vue d'ensemble

### Objectif

Implementer l'application AST Blitz Flutter basee sur les specs de `FLUTTER_SPECS.md`.

### Etat actuel

| Metrique | Valeur |
|----------|--------|
| Features totales | 0 |
| Terminees | 0 |
| En cours | 0 |
| Backlog | 0 |

---

## Regles de gestion

### Structure

```
FEATURES/
├── FEATURES.md          ← Ce fichier (index)
├── BACKLOG/             ← Features a implementer
│   └── FEAT-XXX.md
└── COMPLETED/           ← Features terminees
    └── FEAT-XXX.md
```

### Workflow

1. **Nouvelle feature**: Creer `FEAT-XXX.md` dans `BACKLOG/` + ajouter au tableau
2. **Feature en cours**: Mettre a jour le statut dans le tableau
3. **Feature terminee**: Deplacer vers `COMPLETED/`, noter le commit
4. **Reprise conversation**: Lire ce fichier + le fichier de la feature en cours

### Conventions

- **Nommage**: `FEAT-XXX.md` (XXX = numero a 3 chiffres)
- **Priorites**: P0 (critique) > P1 (urgent) > P2 (normal) > P3 (backlog)
- **Statuts**: A faire | En cours | Review | Termine | Bloque
- **Commits**: Format `feat(scope): description`

---

## Index des features

### Phase 1: Setup & Core

| ID | Titre | Priorite | Statut | Commit | Details |
|----|-------|----------|--------|--------|---------|
| FEAT-001 | Setup projet Flutter | P0 | A faire | - | [Fiche](./BACKLOG/FEAT-001.md) |
| FEAT-002 | Theme et Design System | P0 | A faire | - | [Fiche](./BACKLOG/FEAT-002.md) |
| FEAT-003 | Navigation (go_router) | P0 | A faire | - | [Fiche](./BACKLOG/FEAT-003.md) |
| FEAT-004 | Composants UI de base | P1 | A faire | - | [Fiche](./BACKLOG/FEAT-004.md) |

### Phase 2: Ecrans principaux

| ID | Titre | Priorite | Statut | Commit | Details |
|----|-------|----------|--------|--------|---------|
| FEAT-010 | Ecran Home | P1 | A faire | - | [Fiche](./BACKLOG/FEAT-010.md) |
| FEAT-011 | Bottom Navigation | P1 | A faire | - | [Fiche](./BACKLOG/FEAT-011.md) |
| FEAT-012 | Ecran Exercises | P1 | A faire | - | [Fiche](./BACKLOG/FEAT-012.md) |
| FEAT-013 | Ecran Learn | P1 | A faire | - | [Fiche](./BACKLOG/FEAT-013.md) |
| FEAT-014 | Ecran Profile | P1 | A faire | - | [Fiche](./BACKLOG/FEAT-014.md) |

### Phase 3: Quiz & Exercices

| ID | Titre | Priorite | Statut | Commit | Details |
|----|-------|----------|--------|--------|---------|
| FEAT-020 | Ecran Quiz | P1 | A faire | - | [Fiche](./BACKLOG/FEAT-020.md) |
| FEAT-021 | Quiz Timer | P1 | A faire | - | [Fiche](./BACKLOG/FEAT-021.md) |
| FEAT-022 | Quiz Result | P1 | A faire | - | [Fiche](./BACKLOG/FEAT-022.md) |
| FEAT-023 | Review Quiz (erreurs) | P2 | A faire | - | [Fiche](./BACKLOG/FEAT-023.md) |
| FEAT-024 | Daily Problem | P2 | A faire | - | [Fiche](./BACKLOG/FEAT-024.md) |

### Phase 4: Apprentissage

| ID | Titre | Priorite | Statut | Commit | Details |
|----|-------|----------|--------|--------|---------|
| FEAT-030 | Ecran Subject | P2 | A faire | - | [Fiche](./BACKLOG/FEAT-030.md) |
| FEAT-031 | Course Content | P2 | A faire | - | [Fiche](./BACKLOG/FEAT-031.md) |
| FEAT-032 | Agent Chat | P3 | A faire | - | [Fiche](./BACKLOG/FEAT-032.md) |

### Phase 5: Social & Gamification

| ID | Titre | Priorite | Statut | Commit | Details |
|----|-------|----------|--------|--------|---------|
| FEAT-040 | Ecran Badges | P2 | A faire | - | [Fiche](./BACKLOG/FEAT-040.md) |
| FEAT-041 | Ecran Leaderboard | P3 | A faire | - | [Fiche](./BACKLOG/FEAT-041.md) |
| FEAT-042 | Duel | P3 | A faire | - | [Fiche](./BACKLOG/FEAT-042.md) |
| FEAT-043 | Social | P3 | A faire | - | [Fiche](./BACKLOG/FEAT-043.md) |

### Phase 6: Settings & Misc

| ID | Titre | Priorite | Statut | Commit | Details |
|----|-------|----------|--------|--------|---------|
| FEAT-050 | Ecran Settings | P2 | A faire | - | [Fiche](./BACKLOG/FEAT-050.md) |
| FEAT-051 | Shop & Cart | P3 | A faire | - | [Fiche](./BACKLOG/FEAT-051.md) |
| FEAT-052 | Planning | P3 | A faire | - | [Fiche](./BACKLOG/FEAT-052.md) |

---

## Statistiques

| Phase | Total | Termine | En cours | A faire |
|-------|-------|---------|----------|---------|
| Phase 1: Setup | 4 | 0 | 0 | 4 |
| Phase 2: Ecrans | 5 | 0 | 0 | 5 |
| Phase 3: Quiz | 5 | 0 | 0 | 5 |
| Phase 4: Learn | 3 | 0 | 0 | 3 |
| Phase 5: Social | 4 | 0 | 0 | 4 |
| Phase 6: Misc | 3 | 0 | 0 | 3 |
| **TOTAL** | **24** | **0** | **0** | **24** |

---

## Progression

```
Phase 1: [                                        ] 0%
Phase 2: [                                        ] 0%
Phase 3: [                                        ] 0%
Phase 4: [                                        ] 0%
Phase 5: [                                        ] 0%
Phase 6: [                                        ] 0%
Global:  [                                        ] 0%
```

---

## Template de fiche

Voir `BACKLOG/FEAT-001.md` pour un exemple complet.

---

## Liens

- [FLUTTER_SPECS.md](../FLUTTER_SPECS.md) - Specifications design
- [TESTING.md](../TESTING/TESTING.md) - Index des tests
- [ROADMAP.md](../../docs/ROADMAP.md) - Vision macro
