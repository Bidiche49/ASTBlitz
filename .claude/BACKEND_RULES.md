# BACKEND_RULES.md - AST Blitz Firebase

> **Règles strictes d'utilisation Firebase pour optimiser les coûts et performances.**
> Lire avant toute implémentation backend.

---

## 1. Architecture Résumé

| Donnée | Service | Raison |
|--------|---------|--------|
| Users, Progression, Badges | Firestore | Queries complexes, offline |
| Questions | Firestore → SQLite local | Sync delta, quiz 100% offline |
| Quiz Results | Firestore | Historique, analytics |
| Duels | **RTDB** | Temps réel critique |
| Matchmaking | **RTDB** | Queue temps réel |
| Leaderboard | Firestore + cache 5min | Refresh périodique OK |
| Cours | **App bundle** | Statique, 0 coût |
| Médias questions | Firebase Storage | Images, schémas |

---

## 2. Règles Lectures (OBLIGATOIRES)

### R1. Questions = SQLite Local

```dart
// ✅ CORRECT
final questions = await _localDb.getRandomQuestions(categoryId: 'logique', count: 10);

// ❌ INTERDIT pendant un quiz
final questions = await _firestore.collection('questions').get();
```

### R2. Sync Delta Uniquement

```dart
// ✅ CORRECT - sync uniquement les nouvelles questions
final snapshot = await _firestore
    .collection('questions')
    .where('updatedAt', isGreaterThan: lastSyncTimestamp)
    .get();

// ❌ INTERDIT - sync complète à chaque fois
final snapshot = await _firestore.collection('questions').get();
```

### R3. `.get()` par Défaut

```dart
// ✅ CORRECT - lecture unique
final doc = await _firestore.collection('users').doc(uid).get();

// ❌ INTERDIT sauf pour duels/leaderboard live
_firestore.collection('users').doc(uid).snapshots();
```

### R4. Pagination Obligatoire

```dart
// ✅ CORRECT
final snapshot = await _firestore
    .collection('quizSessions')
    .where('userId', isEqualTo: uid)
    .orderBy('completedAt', descending: true)
    .limit(20) // ← OBLIGATOIRE
    .get();

// ❌ INTERDIT
final snapshot = await _firestore
    .collection('quizSessions')
    .where('userId', isEqualTo: uid)
    .get(); // Sans limit = danger
```

### R5. Cache Local Avant Réseau

```dart
// ✅ CORRECT
Future<UserProfile> getProfile(String uid) async {
  // 1. Check cache
  final cached = _cache.get<UserProfile>('profile_$uid');
  if (cached != null) return cached;

  // 2. Firestore seulement si pas en cache
  final doc = await _firestore.collection('users').doc(uid).get();
  final profile = UserProfile.fromFirestore(doc);

  // 3. Mettre en cache
  _cache.set('profile_$uid', profile, ttl: Duration(minutes: 10));
  return profile;
}
```

---

## 3. Règles Écritures (OBLIGATOIRES)

### W1. Batch Writes

```dart
// ✅ CORRECT - batch pour opérations multiples
final batch = _firestore.batch();
batch.update(userRef, {'stats.xp': FieldValue.increment(100)});
batch.set(badgeRef, {'unlockedAt': FieldValue.serverTimestamp()});
await batch.commit();

// ❌ INTERDIT - writes séparés
await userRef.update({'stats.xp': FieldValue.increment(100)});
await badgeRef.set({'unlockedAt': FieldValue.serverTimestamp()});
```

### W2. Debounce Stats

```dart
// ✅ CORRECT - debounce 30 secondes minimum
Timer? _statsDebounce;

void updateStats(Map<String, dynamic> updates) {
  _pendingUpdates.addAll(updates);
  _statsDebounce?.cancel();
  _statsDebounce = Timer(Duration(seconds: 30), _flushStats);
}

// ❌ INTERDIT - update à chaque action
void onQuestionAnswered() {
  _firestore.collection('users').doc(uid).update({...}); // Chaque réponse!
}
```

### W3. Queue Offline

```dart
// ✅ CORRECT
Future<void> saveQuizResult(QuizSession session) async {
  try {
    await _firestore.collection('quizSessions').add(session.toFirestore());
  } catch (e) {
    await _offlineQueue.enqueue(type: 'quiz_result', data: session.toJson());
  }
}
```

---

## 4. Règles Listeners (OBLIGATOIRES)

### L1. Toujours Cancel

```dart
class DuelScreen extends ConsumerStatefulWidget {
  // ...
}

class _DuelScreenState extends ConsumerState<DuelScreen> {
  StreamSubscription? _duelSubscription;

  @override
  void dispose() {
    _duelSubscription?.cancel(); // ← OBLIGATOIRE
    super.dispose();
  }
}
```

### L2. Un Listener Max par Écran

```dart
// ✅ CORRECT - 1 listener pour tout le duel
_duelSubscription = _rtdb.ref('duels/$duelId').onValue.listen((event) {
  // Traiter tout le duel
});

// ❌ INTERDIT - listeners multiples
_rtdb.ref('duels/$duelId/players').onValue.listen(...);
_rtdb.ref('duels/$duelId/questions').onValue.listen(...);
_rtdb.ref('duels/$duelId/status').onValue.listen(...);
```

### L3. Cleanup RTDB OnDisconnect

```dart
// ✅ CORRECT
await _rtdb.ref('matchmaking/queue/$uid').onDisconnect().remove();
await _rtdb.ref('presence/$uid/online').onDisconnect().set(false);
```

---

## 5. Structure Documents

### S1. Max 2 Niveaux de Profondeur

```
✅ CORRECT
users/{uid}
users/{uid}/badges/{badgeId}

❌ INTERDIT
users/{uid}/progress/{categoryId}/modules/{moduleId}/attempts/{attemptId}
```

### S2. Documents < 1 Mo

Si un document risque de dépasser 1 Mo, découper en subcollection.

### S3. Pas d'Arrays Modifiables

```dart
// ✅ CORRECT - Map pour données modifiables
{
  "progress": {
    "modules": {
      "module_1": {"score": 85, "attempts": 3},
      "module_2": {"score": 92, "attempts": 1}
    }
  }
}

// ❌ INTERDIT - Array qu'on modifie
{
  "completedModules": ["module_1", "module_2"] // arrayUnion coûteux
}
```

---

## 6. Durées de Cache

| Donnée | Storage | TTL |
|--------|---------|-----|
| Questions | SQLite | 24h (sync delta) |
| User Profile | SharedPrefs | 10 min |
| Subscription | SecureStorage | 48h grace |
| Leaderboard | Memory | 5 min |
| Badges définitions | Memory | 1h |
| Quiz en cours | Memory | Session |

---

## 7. Estimations Coûts

### Par Palier Utilisateurs

| Palier | Firestore | RTDB | Total |
|--------|-----------|------|-------|
| 1K DAU | ~$2 | ~$0.15 | **~$3/mois** |
| 10K DAU | ~$18 | ~$1.50 | **~$20/mois** |
| 50K DAU | ~$90 | ~$7.50 | **~$100/mois** |

### Hypothèses

- 20 quiz/jour/user
- 1 duel/jour/user
- Sync questions 1x/24h
- Questions en SQLite local

### Budget Alert

Configurer alertes Firebase à :
- $20/mois (warning)
- $40/mois (critique)
- $80/mois (urgence)

---

## 8. Anti-Patterns INTERDITS

| # | Anti-Pattern | Conséquence |
|---|--------------|-------------|
| 1 | Listener sans cancel | Memory leak, reads infinis |
| 2 | 1 read/question pendant quiz | 200 reads/quiz = $$$$ |
| 3 | `.snapshots()` partout | Listeners permanents |
| 4 | Pas de pagination | Explosion mémoire et coûts |
| 5 | Sync complète questions | 3000 reads à chaque sync |
| 6 | Write à chaque keystroke | 100 writes pour 1 réponse |
| 7 | Duel sur Firestore | Latence 200-500ms |
| 8 | Pas de cache local | Reads répétés inutiles |
| 9 | Cloud Functions partout | Cold start + coût + complexité |
| 10 | Document > 1 Mo | Write fail |

---

## 9. Patterns Obligatoires

### Quiz Flow

```
1. App start → QuestionSyncService.syncIfNeeded()
2. User lance quiz → _localDb.getRandomQuestions() ← 0 read Firestore
3. User répond → stockage mémoire
4. Quiz terminé → _firestore.collection('quizSessions').add()
5. Offline? → OfflineQueue.enqueue()
```

### Duel Flow

```
1. User cherche duel → RTDB matchmaking/queue/{uid}
2. Match trouvé → RTDB matchmaking/matches/{uid} = duelId
3. Duel créé → RTDB duels/{duelId}
4. Gameplay → RTDB updates temps réel
5. Fin → Résultat copié vers Firestore (historique)
```

### Subscription Check

```
1. Check local SecureStorage
2. Si valide (+ 48h grace) → return true
3. Sinon fetch Firestore
4. Update local cache
5. Return subscription.isActive
```

---

## 10. Checklist Pré-Implémentation

### Firebase Console

- [ ] Projet Firebase créé (Blaze plan)
- [ ] Firestore activé (europe-west1)
- [ ] RTDB activé (europe-west1)
- [ ] Firebase Auth activé (Email, Google, Apple)
- [ ] Firebase Storage activé
- [ ] Budget alerts configurés ($20, $40, $80)

### Security Rules

- [ ] Firestore rules écrites et testées
- [ ] RTDB rules écrites et testées
- [ ] Storage rules écrites et testées

### Indexes Firestore

- [ ] `questions(categoryId, difficulty)`
- [ ] `questions(moduleId, createdAt DESC)`
- [ ] `questions(updatedAt ASC)`
- [ ] `quizSessions(userId, completedAt DESC)`
- [ ] `leaderboards/{cat}/weekly(score DESC)`

### Code

- [ ] SQLite setup (drift ou sqflite)
- [ ] QuestionLocalDatabase
- [ ] QuestionSyncService
- [ ] OfflineQueueService
- [ ] SubscriptionService
- [ ] DuelService (RTDB)
- [ ] LeaderboardRepository (cache)

### Tests

- [ ] Émulateur Firebase configuré
- [ ] Tests sync questions
- [ ] Tests offline queue
- [ ] Tests subscription validation
- [ ] Tests duel temps réel

---

## 11. Commandes Utiles

```bash
# Installer FlutterFire CLI
dart pub global activate flutterfire_cli

# Configurer Firebase
flutterfire configure

# Lancer émulateur Firebase
firebase emulators:start

# Déployer Security Rules
firebase deploy --only firestore:rules
firebase deploy --only database

# Voir usage Firebase
firebase projects:list
```

---

## 12. Références

- [Firestore Pricing](https://firebase.google.com/pricing)
- [Firestore Best Practices](https://firebase.google.com/docs/firestore/best-practices)
- [RTDB Structure](https://firebase.google.com/docs/database/web/structure-data)
- [FlutterFire Docs](https://firebase.flutter.dev/)

---

**Dernière mise à jour**: 2026-01-02
**Version**: 1.0
