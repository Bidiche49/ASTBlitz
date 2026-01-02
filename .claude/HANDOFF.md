# HANDOFF - Template de Passation de Contexte

## QUAND UTILISER CE TEMPLATE

**Declencheur**: Quand le contexte de conversation atteint ~90% d'utilisation.

**Objectif**: Permettre une reprise fluide dans une nouvelle conversation.

---

## PROCEDURE

### 1. Detecter le besoin de handoff

Signes que le contexte arrive a sa fin:
- Conversation tres longue
- Beaucoup de fichiers lus/modifies
- Claude mentionne des limites

### 2. Arreter proprement

- Terminer l'action atomique en cours (ou noter son etat)
- Ne PAS commencer de nouvelle action
- Sauvegarder tout travail en cours

### 3. Creer le fichier handoff

Creer: `.claude/handoffs/HANDOFF-YYYY-MM-DD-HHMM.md`

### 4. Remplir le template ci-dessous

### 5. Generer le prompt de reprise

---

## TEMPLATE DE HANDOFF

```markdown
# HANDOFF - [Date] [Heure]

## Tache en cours

**ID**: FEAT-XXX
**Titre**: [Titre de la feature]
**Statut**: [En cours / Bloque / Pret a commit]

## Etat actuel

### Termine cette session
- [x] Fichier X cree et fonctionnel
- [x] Fichier Y modifie

### En cours (non termine)
- [ ] Fichier Z: [etat actuel, ligne XX]
- [ ] Integration: [ce qui reste]

### Non commence
- [ ] Tests unitaires
- [ ] Documentation

## Fichiers modifies

| Fichier | Etat | Notes |
|---------|------|-------|
| `lib/xxx.dart` | Complet | Pret |
| `lib/yyy.dart` | Partiel | Manque fonction ABC |
| `test/xxx_test.dart` | Non cree | A faire |

## Blocages / Points d'attention

- [Decrire tout blocage ou point d'attention]
- [Decisions prises et pourquoi]

## Verification

```bash
# Commandes pour verifier l'etat
flutter analyze   # Resultat: X erreurs / OK
flutter test      # Resultat: X/Y passent
```

## Prochaines actions

1. [Action immediate a faire]
2. [Action suivante]
3. [...]

---

## PROMPT DE REPRISE

Copier-coller ce prompt dans une nouvelle conversation:

---

Je reprends le travail sur AST Blitz Flutter.

**Contexte**:
- Tache en cours: FEAT-XXX - [Titre]
- Derniere session: [Date]

**Etat actuel**:
- [Resume de ce qui est fait]
- [Resume de ce qui reste]

**Prochaine action**:
[Action precise a effectuer]

**Fichiers a consulter**:
1. `.claude/CLAUDE.md` - Regles du projet
2. `.claude/handoffs/HANDOFF-YYYY-MM-DD-HHMM.md` - Dernier handoff
3. `.claude/FEATURES/BACKLOG/FEAT-XXX.md` - Fiche de la tache

**Verification**:
```bash
flutter analyze && flutter test
```

Merci de lire ces fichiers et de continuer le travail.

---

```

---

## EXEMPLE CONCRET

```markdown
# HANDOFF - 2025-01-02 16:30

## Tache en cours

**ID**: FEAT-003
**Titre**: Ecran Quiz avec timer
**Statut**: En cours

## Etat actuel

### Termine cette session
- [x] quiz_screen.dart cree (structure de base)
- [x] quiz_provider.dart cree (state management)
- [x] Animations d'entree implementees

### En cours (non termine)
- [ ] quiz_screen.dart: Animation de transition entre questions (ligne 145)
- [ ] Feedback visuel correct/incorrect

### Non commence
- [ ] Tests unitaires quiz_provider
- [ ] Tests widget quiz_screen

## Fichiers modifies

| Fichier | Etat | Notes |
|---------|------|-------|
| `lib/presentation/screens/quiz/quiz_screen.dart` | 80% | Manque transitions |
| `lib/presentation/providers/quiz_provider.dart` | Complet | Pret |
| `test/unit/providers/quiz_provider_test.dart` | Non cree | A faire |

## Blocages / Points d'attention

- Animation de transition: hesitation entre SlideTransition et FadeTransition
- Consulter FLUTTER_SPECS.md section 4.2 pour les specs d'animation

## Verification

```bash
flutter analyze   # OK
flutter test      # 23/23 passent (pas encore de tests quiz)
```

## Prochaines actions

1. Terminer les animations de transition (quiz_screen.dart:145)
2. Ajouter feedback visuel correct/incorrect
3. Ecrire tests quiz_provider
4. Commit

---

## PROMPT DE REPRISE

Je reprends le travail sur AST Blitz Flutter.

**Contexte**:
- Tache en cours: FEAT-003 - Ecran Quiz avec timer
- Derniere session: 2025-01-02 16:30

**Etat actuel**:
- quiz_screen.dart et quiz_provider.dart crees
- Animations d'entree OK
- Manque: transitions entre questions + feedback visuel

**Prochaine action**:
Terminer les animations de transition dans quiz_screen.dart ligne 145.
Consulter FLUTTER_SPECS.md section 4.2 pour les specs.

**Fichiers a consulter**:
1. `.claude/CLAUDE.md`
2. `.claude/handoffs/HANDOFF-2025-01-02-1630.md`
3. `.claude/FEATURES/BACKLOG/FEAT-003.md`
4. `.claude/FLUTTER_SPECS.md` (section 4.2)

**Verification**:
```bash
flutter analyze && flutter test
```

Merci de lire ces fichiers et de continuer le travail.

---

```

---

## NOTES

### Quand NE PAS faire de handoff

- Tache terminee et committee → Pas besoin
- Juste une question/reponse → Pas besoin
- Contexte encore largement disponible → Attendre

### Bonnes pratiques

- Etre precis sur les numeros de ligne
- Toujours inclure les commandes de verification
- Le prompt de reprise doit etre auto-suffisant
- Archiver les handoffs (ne pas supprimer)
