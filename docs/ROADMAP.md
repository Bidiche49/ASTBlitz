# ROADMAP - AST Blitz Flutter

> Vision macro du projet et phases d'implementation.

---

## Vision

Creer une application mobile cross-platform (iOS/Android) de preparation au TAGE MAGE / AST,
basee sur le design et les fonctionnalites de la webapp React existante.

---

## Phases

### Phase 1: Foundation (Semaine 1-2)

**Objectif**: Projet Flutter fonctionnel avec architecture et design system.

| Tache | Priorite | Status |
|-------|----------|--------|
| Setup projet Flutter | P0 | A faire |
| Architecture Clean | P0 | A faire |
| Theme (couleurs, typo, spacing) | P0 | A faire |
| Composants UI de base | P1 | A faire |
| Navigation (go_router) | P0 | A faire |
| Bottom Navigation | P1 | A faire |

**Livrable**: App qui demarre avec navigation entre ecrans vides.

---

### Phase 2: Ecrans Principaux (Semaine 2-3)

**Objectif**: Les 5 ecrans principaux accessibles depuis la bottom nav.

| Tache | Priorite | Status |
|-------|----------|--------|
| Home Screen | P1 | A faire |
| Exercises Screen | P1 | A faire |
| Learn Screen | P1 | A faire |
| Shop Screen | P2 | A faire |
| Profile Screen | P1 | A faire |

**Livrable**: Navigation complete, ecrans avec layout et contenu statique.

---

### Phase 3: Quiz & Exercices (Semaine 3-4)

**Objectif**: Fonctionnalite coeur de l'app - les quiz.

| Tache | Priorite | Status |
|-------|----------|--------|
| Quiz Screen | P0 | A faire |
| Timer Quiz | P0 | A faire |
| Quiz Result | P0 | A faire |
| Review Quiz (erreurs) | P1 | A faire |
| Daily Problem | P1 | A faire |
| Exercise Mode | P1 | A faire |

**Livrable**: Utilisateur peut faire un quiz complet avec resultats.

---

### Phase 4: Apprentissage (Semaine 4-5)

**Objectif**: Section cours et contenu educatif.

| Tache | Priorite | Status |
|-------|----------|--------|
| Subject Screen | P1 | A faire |
| Course Content (Markdown) | P1 | A faire |
| Progress tracking | P2 | A faire |
| Agent Chat (optionnel) | P3 | A faire |

**Livrable**: Utilisateur peut parcourir et lire les cours.

---

### Phase 5: Gamification & Social (Semaine 5-6)

**Objectif**: Elements de motivation et aspects sociaux.

| Tache | Priorite | Status |
|-------|----------|--------|
| Badges Screen | P2 | A faire |
| Leaderboard | P2 | A faire |
| Streak tracking | P2 | A faire |
| Stats screens | P2 | A faire |
| Duel (optionnel) | P3 | A faire |
| Social (optionnel) | P3 | A faire |

**Livrable**: Systeme de badges et classement fonctionnels.

---

### Phase 6: Backend & Auth (Semaine 6-7)

**Objectif**: Persistence des donnees et authentification.

| Tache | Priorite | Status |
|-------|----------|--------|
| Firebase setup | P0 | A faire |
| Authentication | P0 | A faire |
| User data sync | P0 | A faire |
| Progress persistence | P1 | A faire |
| Offline mode (optionnel) | P3 | A faire |

**Livrable**: Donnees persistees, utilisateur peut se connecter.

---

### Phase 7: Polish & Release (Semaine 7-8)

**Objectif**: Finalisation et preparation au lancement.

| Tache | Priorite | Status |
|-------|----------|--------|
| Animations polish | P2 | A faire |
| Performance optimization | P1 | A faire |
| Error handling global | P1 | A faire |
| Tests coverage 70%+ | P1 | A faire |
| App Store assets | P1 | A faire |
| Beta testing | P1 | A faire |

**Livrable**: App prete pour soumission aux stores.

---

## Metriques de succes

| Metrique | Cible |
|----------|-------|
| Couverture tests | > 70% |
| FPS moyen | 60 fps stable |
| Taux crash | < 0.1% |
| Temps lancement | < 2s |
| Taille APK | < 30 MB |

---

## Risques identifies

| Risque | Impact | Mitigation |
|--------|--------|------------|
| Complexite quiz timer | Eleve | Prototype early |
| Performance animations | Moyen | Profile regulierement |
| Integration Firebase | Moyen | Setup early en Phase 6 |
| Contenu cours volumineux | Faible | Lazy loading |

---

## Decisions techniques

| Decision | Choix | Raison |
|----------|-------|--------|
| State Management | Riverpod | Scalable, testable |
| Navigation | go_router | Declaratif, type-safe |
| Backend | Firebase | Rapidite dev, temps reel |
| Icons | lucide_icons | Coherence avec React |
| Animations | flutter_animate | API simple, performant |

---

## Liens

- [FLUTTER_SPECS.md](../.claude/FLUTTER_SPECS.md) - Specifications design completes
- [FEATURES.md](../.claude/FEATURES/FEATURES.md) - Index des features
- [TESTING.md](../.claude/TESTING/TESTING.md) - Strategie de tests
