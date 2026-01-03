# FEATURES - Index des Fonctionnalites

> Ce fichier centralise toutes les features a implementer.
> Les details de chaque feature se trouvent dans les fichiers individuels.

---

## Vue d'ensemble

### Objectif

Implementer l'application AST Blitz Flutter basee sur les specs de `FLUTTER_SPECS.md`.

### Etat actuel

| Metrique | Valeur |
|----------|--------|
| Features totales | 26 |
| Terminees | 10 |
| En cours | 0 |
| Backlog | 16 |

---

## Regles de gestion

### Structure

```
FEATURES/
├── FEATURES.md          ← Ce fichier (index)
├── BACKLOG/             ← Features a implementer
│   └── PX-XXX.md
└── COMPLETED/           ← Features terminees
    └── PX-XXX.md
```

### Conventions de nommage

**Format: `PX-XXX`**
- `P` = Prefixe phase (P1, P2, P3...)
- `X` = Numero de phase (1-99)
- `XXX` = Numero de feature dans la phase (001-999)

**Exemples:**
- `P1-001` = Phase 1, feature 1
- `P2-015` = Phase 2, feature 15
- `P12-003` = Phase 12, feature 3

**Avantages:**
- Phases illimitees (P1 a P99)
- Features illimitees par phase (001 a 999)
- Groupement logique par domaine

### Workflow

1. **Nouvelle feature**: Creer `PX-XXX.md` dans `BACKLOG/` + ajouter au tableau
2. **Feature en cours**: Mettre a jour le statut dans le tableau
3. **Feature terminee**: Deplacer vers `COMPLETED/`, noter le commit
4. **Reprise conversation**: Lire ce fichier + le fichier de la feature en cours

### Priorites et Statuts

- **Priorites**: P0 (critique) > P1 (urgent) > P2 (normal) > P3 (backlog)
- **Statuts**: A faire | En cours | Review | Termine | Bloque
- **Commits**: Format `feat(scope): description`

---

## Index des features

### Phase 1: Setup & Core

| ID | Titre | Priorite | Statut | Commit | Details |
|----|-------|----------|--------|--------|---------|
| P1-001 | Setup projet Flutter | P0 | Termine | f440273 | [Fiche](./COMPLETED/P1-001.md) |
| P1-002 | Theme et Design System | P0 | Termine | f440273 | [Fiche](./COMPLETED/P1-002.md) |
| P1-003 | Navigation (go_router) | P0 | Termine | f440273 | [Fiche](./COMPLETED/P1-003.md) |
| P1-004 | Composants UI de base | P1 | Termine | 7e2ad30 | [Fiche](./COMPLETED/P1-004.md) |
| P1-005 | Authentification | P0 | Termine | 419854a | [Fiche](./COMPLETED/P1-005.md) |
| P1-006 | Configuration Apple Sign-In | P2 | A faire | - | [Fiche](./BACKLOG/P1-006.md) |

### Phase 2: Ecrans principaux

| ID | Titre | Priorite | Statut | Commit | Details |
|----|-------|----------|--------|--------|---------|
| P2-001 | Ecran Home | P1 | Termine | f440273 | [Fiche](./COMPLETED/P2-001.md) |
| P2-002 | Bottom Navigation | P1 | Termine | f440273 | [Fiche](./COMPLETED/P2-002.md) |
| P2-003 | Ecran Exercises | P1 | Termine | - | [Fiche](./BACKLOG/P2-003.md) |
| P2-004 | Ecran Learn | P1 | Termine | - | [Fiche](./BACKLOG/P2-004.md) |
| P2-005 | Ecran Profile | P1 | Termine | - | [Fiche](./BACKLOG/P2-005.md) |

### Phase 3: Quiz & Exercices

| ID | Titre | Priorite | Statut | Commit | Details |
|----|-------|----------|--------|--------|---------|
| P3-001 | Ecran Quiz | P1 | A faire | - | [Fiche](./BACKLOG/P3-001.md) |
| P3-002 | Quiz Timer | P1 | A faire | - | [Fiche](./BACKLOG/P3-002.md) |
| P3-003 | Quiz Result | P1 | A faire | - | [Fiche](./BACKLOG/P3-003.md) |
| P3-004 | Review Quiz (erreurs) | P2 | A faire | - | [Fiche](./BACKLOG/P3-004.md) |
| P3-005 | Daily Problem | P2 | A faire | - | [Fiche](./BACKLOG/P3-005.md) |

### Phase 4: Apprentissage

| ID | Titre | Priorite | Statut | Commit | Details |
|----|-------|----------|--------|--------|---------|
| P4-001 | Ecran Subject | P2 | A faire | - | [Fiche](./BACKLOG/P4-001.md) |
| P4-002 | Course Content | P2 | A faire | - | [Fiche](./BACKLOG/P4-002.md) |
| P4-003 | Agent Chat | P3 | A faire | - | [Fiche](./BACKLOG/P4-003.md) |

### Phase 5: Social & Gamification

| ID | Titre | Priorite | Statut | Commit | Details |
|----|-------|----------|--------|--------|---------|
| P5-001 | Ecran Badges | P2 | A faire | - | [Fiche](./BACKLOG/P5-001.md) |
| P5-002 | Ecran Leaderboard | P3 | A faire | - | [Fiche](./BACKLOG/P5-002.md) |
| P5-003 | Duel | P3 | A faire | - | [Fiche](./BACKLOG/P5-003.md) |
| P5-004 | Social | P3 | A faire | - | [Fiche](./BACKLOG/P5-004.md) |

### Phase 6: Settings & Misc

| ID | Titre | Priorite | Statut | Commit | Details |
|----|-------|----------|--------|--------|---------|
| P6-001 | Ecran Settings | P2 | A faire | - | [Fiche](./BACKLOG/P6-001.md) |
| P6-002 | Shop & Cart | P3 | A faire | - | [Fiche](./BACKLOG/P6-002.md) |
| P6-003 | Planning | P3 | A faire | - | [Fiche](./BACKLOG/P6-003.md) |

---

## Statistiques

| Phase | Total | Termine | En cours | A faire |
|-------|-------|---------|----------|---------|
| Phase 1: Setup | 6 | 5 | 0 | 1 |
| Phase 2: Ecrans | 5 | 5 | 0 | 0 |
| Phase 3: Quiz | 5 | 0 | 0 | 5 |
| Phase 4: Learn | 3 | 0 | 0 | 3 |
| Phase 5: Social | 4 | 0 | 0 | 4 |
| Phase 6: Misc | 3 | 0 | 0 | 3 |
| **TOTAL** | **26** | **10** | **0** | **16** |

---

## Progression

```
Phase 1: [#######################################-] 83%
Phase 2: [########################################] 100%
Phase 3: [                                        ] 0%
Phase 4: [                                        ] 0%
Phase 5: [                                        ] 0%
Phase 6: [                                        ] 0%
Global:  [################                        ] 38%
```

---

## Template de fiche

Voir `COMPLETED/P1-001.md` pour un exemple complet.

---

## Liens

- [FLUTTER_SPECS.md](../FLUTTER_SPECS.md) - Specifications design
- [TESTING.md](../TESTING/TESTING.md) - Index des tests
- [ROADMAP.md](../../docs/ROADMAP.md) - Vision macro
