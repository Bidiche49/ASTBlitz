# Architecture Backend - AST Blitz Flutter

> Ce fichier documente les choix d'architecture backend et leurs justifications.
> Pour les regles operationnelles et patterns de code, voir **[BACKEND_RULES.md](./BACKEND_RULES.md)**.

**Statut**: DEFINI
**Date**: 2026-01-02

---

## 1. Stack Retenu

| Service | Usage | Justification |
|---------|-------|---------------|
| **Firestore** | Users, questions (sync), scores, badges | Queries complexes, offline natif, structure flexible |
| **RTDB** | Duels, matchmaking, presence | Latence <100ms, updates temps reel |
| **Firebase Auth** | Authentification | Google/Apple Sign-In, gratuit 50K MAU |
| **Firebase Storage** | Medias questions | Images, schemas pour les questions |
| **SQLite local** | Cache questions | Quiz 100% offline, 0 lecture Firestore |
| **App bundle** | Cours | Contenu statique 15Mo, 0 cout reseau |

---

## 2. Decisions Cles

### Pourquoi Firestore + RTDB (et pas un seul) ?

| Critere | Firestore | RTDB | Choix AST Blitz |
|---------|-----------|------|-----------------|
| Latence | 100-300ms | 10-100ms | RTDB pour duels |
| Queries | Puissantes | Limitees | Firestore pour filtres |
| Offline | Excellent | Bon | Firestore pour cache |
| Prix | Par operation | Par bande passante | Mix optimal |
| Structure | Documents | JSON plat | Selon le cas |

**Decision** : Firestore pour 95% des donnees, RTDB uniquement pour temps reel critique (duels).

### Pourquoi SQLite local pour les questions ?

| Approche | Lectures Firestore/quiz | Cout 10K users/mois |
|----------|------------------------|---------------------|
| Direct Firestore | 10 lectures/quiz | ~$36/mois |
| **SQLite local** | 0 lectures/quiz | ~$0.50/mois |

**Decision** : Sync questions vers SQLite, quiz jouent 100% offline.

### Pourquoi bundler les cours ?

- 15-18 modules = ~15 Mo total
- Contenu statique, rarement mis a jour
- 0 lecture reseau = 0 cout + UX instantanee
- Mise a jour via update app store

**Decision** : Cours dans `assets/`, pas de telechargement.

---

## 3. Structure des Donnees

### Firestore

```
users/{uid}
  ├── profile (email, displayName, photoUrl)
  ├── subscription {plan, validUntil, platform}
  ├── stats {xp, level, streak, totalQuizzes}
  └── progress {modules: {...}, categories: {...}}

users/{uid}/badges/{badgeId}
  └── unlockedAt, notified

questions/{questionId}
  ├── categoryId, moduleId, difficulty
  ├── content, options[], correctIndex
  ├── explanation, mediaUrls[]
  └── createdAt, updatedAt

quizSessions/{sessionId}
  ├── userId, type, categoryId, moduleId
  ├── questionIds[], answers[], correct[]
  └── totalScore, xpEarned, completedAt

leaderboards/{categoryId}/weekly/{uid}
  └── userId, displayName, score, updatedAt

badges/{badgeId}
  └── name, description, iconName, condition, xpReward
```

### RTDB (Duels)

```json
{
  "duels/{duelId}": {
    "status": "waiting|playing|finished",
    "players": {
      "{uid}": {
        "displayName": "...",
        "score": 45,
        "currentQuestion": 5,
        "answers": {...}
      }
    },
    "questions": [...],
    "config": { "questionCount": 10, "timePerQuestion": 30 }
  },
  "matchmaking/queue/{uid}": {
    "displayName": "...",
    "rating": 1200,
    "category": "logique"
  }
}
```

---

## 4. Estimation des Couts

### Hypotheses

- 20 quiz/jour/user
- 1 duel/jour/user
- Questions en cache SQLite (sync 1x/24h)
- Cours bundles (0 lecture)

### Projection

| Palier | Firestore | RTDB | Auth | Storage | **Total** |
|--------|-----------|------|------|---------|-----------|
| 1K DAU | $2 | $0.15 | $0 | $0.50 | **~$3/mois** |
| 10K DAU | $18 | $1.50 | $0 | $0.50 | **~$20/mois** |
| 25K DAU | $45 | $4 | $0 | $0.50 | **~$50/mois** |
| 50K DAU | $90 | $7.50 | $0 | $0.50 | **~$100/mois** |

### Budget Alerts

- $20/mois : Warning
- $40/mois : Critique
- $80/mois : Urgence

---

## 5. Flux de Donnees

### Quiz (offline-first)

```
[App Start] → QuestionSyncService.syncIfNeeded()
                      ↓
              Firestore (delta only)
                      ↓
              SQLite local (3000 questions)
                      ↓
[User lance quiz] → SQLite.getRandomQuestions()  ← 0 Firestore read
                      ↓
[Quiz complete] → Firestore.quizSessions.add()
                      ↓
              [Offline?] → OfflineQueue.enqueue()
```

### Duel (temps reel)

**Approche** : Host deterministe + push RTDB (pas de Cloud Function)

#### Determination du Host

| Type de duel | Host | Logique |
|--------------|------|---------|
| Matchmaking aleatoire | `min(uid1, uid2)` | UID le plus petit (alphabetique) |
| Entre amis | Createur de l'invitation | Celui qui invite |

#### Flow Matchmaking

```
Joueur A rejoint queue        Joueur B rejoint queue
RTDB: matchmaking/queue/{uidA}    RTDB: matchmaking/queue/{uidB}
              ↓                              ↓
              └────────── Match trouve ──────┘
                              ↓
                    Comparaison UIDs
                    Host = min(uidA, uidB)
                              ↓
              ┌───────────────┴───────────────┐
              ↓                               ↓
        [Host]                          [Guest]
        Genere seed deterministe        Ecoute RTDB
        seed = hash(uid1_uid2_timestamp)
              ↓
        Selectionne 10 questions (SQLite local)
        avec Random(seed)
              ↓
        Push → RTDB duels/{duelId}/questions
              ↓                               ↓
              └─── Les 2 recoivent les memes questions ───┘
                              ↓
                         Gameplay
                              ↓
                    Fin → Resultat vers Firestore
```

#### Flow Duel Entre Amis

```
Joueur A invite Joueur B
              ↓
        A = Host (createur)
        A cree RTDB duels/{duelId} avec status: "waiting"
              ↓
        Notification envoyee a B
              ↓
        B rejoint le duel
              ↓
        A detecte que B a rejoint
        A genere seed = hash(uidA_uidB_timestamp)
        A selectionne questions (SQLite)
        A push questions → RTDB
              ↓
        Les 2 jouent
```

#### Seed Deterministe (anti-triche)

```dart
// Meme resultat pour les 2 joueurs, non manipulable
String generateSeed(String uid1, String uid2, int timestamp) {
  final sorted = [uid1, uid2]..sort();
  return '${sorted.join('_')}_$timestamp';
}

// Selection des questions
final seed = generateSeed(uid1, uid2, createdAt);
final random = Random(seed.hashCode);
final questions = localDb.getRandomQuestions(
  category: category,
  count: 10,
  random: random,
);
```

#### Structure RTDB Duel Complete

```json
{
  "duels/{duelId}": {
    "status": "waiting|ready|playing|finished",
    "createdBy": "{uid}",
    "createdAt": 1234567890,
    "category": "logique",
    "config": {
      "questionCount": 10,
      "timePerQuestion": 30
    },
    "players": {
      "{uid1}": {
        "displayName": "Alice",
        "photoUrl": "...",
        "ready": true,
        "connected": true,
        "currentQuestion": 5,
        "score": 45,
        "answers": {
          "0": { "answer": 2, "time": 5200, "correct": true },
          "1": { "answer": 1, "time": 8100, "correct": false }
        }
      },
      "{uid2}": { "..." }
    },
    "questions": [
      {
        "id": "q123",
        "content": "...",
        "options": ["A", "B", "C", "D"],
        "correctIndex": 2
      }
    ],
    "result": {
      "winner": "{uid1}",
      "draw": false,
      "scores": { "{uid1}": 85, "{uid2}": 70 }
    }
  },
  "matchmaking": {
    "queue/{uid}": {
      "displayName": "Alice",
      "rating": 1200,
      "category": "logique",
      "joinedAt": 1234567890
    },
    "matches/{uid}": {
      "uid1": "{uid1}",
      "uid2": "{uid2}",
      "duelId": "{duelId}",
      "matchedAt": 1234567890
    }
  }
}
```

### Subscription (grace period)

```
[Check access] → SecureStorage.subscription
                      ↓
              [Valide + 48h?] → return true
                      ↓
              [Non] → Firestore.users.subscription
                      ↓
              Update SecureStorage
                      ↓
              return subscription.isActive
```

---

## 6. Compromis Acceptes

| Compromis | Raison | Mitigation |
|-----------|--------|------------|
| 2 bases de donnees | Latence duels vs cout | Architecture claire, services separes |
| Questions en local | Cout lectures | Sync delta 24h, pas de real-time |
| Cours bundles | Simplicity | Update via app store |
| Leaderboard cache 5min | Cout reads | Acceptable pour UX |
| Grace period 48h | Offline subscription | Risque fraude minimal |

---

## 7. Ce qui n'est PAS utilise

| Service | Raison |
|---------|--------|
| Cloud Functions | Cold start, cout, complexite - logique client-side |
| Firestore pour duels | Latence trop elevee (200-500ms) |
| RTDB pour tout | Queries limitees, pas d'offline natif |
| Remote Config | Pas necessaire pour MVP |
| Analytics | A ajouter plus tard si besoin |

---

## 8. Prochaines Etapes

1. [ ] Creer projet Firebase (Blaze plan)
2. [ ] Configurer FlutterFire
3. [ ] Ecrire Security Rules
4. [ ] Implementer SQLite + QuestionSyncService
5. [ ] Implementer DuelService (RTDB)
6. [ ] Tests avec emulateur Firebase

---

## References

- **Regles operationnelles** : [BACKEND_RULES.md](./BACKEND_RULES.md)
- **Design system** : [FLUTTER_SPECS.md](./FLUTTER_SPECS.md)
- **Features** : [FEATURES/FEATURES.md](./FEATURES/FEATURES.md)
