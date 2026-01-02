# Workflow de Developpement - AST Blitz Flutter

## REGLES OBLIGATOIRES - A APPLIQUER SYSTEMATIQUEMENT

Ces regles s'appliquent a CHAQUE avancee, sans exception.

---

## 1. CYCLE DE DEVELOPPEMENT

Chaque tache suit ce cycle strict :

```
PLAN → CODE → COMPILE → TEST → DOC → COMMIT
```

### Etape 1: PLAN

- [ ] Lire la fiche FEAT-XXX correspondante
- [ ] Consulter FLUTTER_SPECS.md pour le design
- [ ] Identifier les fichiers a modifier/creer
- [ ] Estimer la complexite (voir section Estimation)
- [ ] Lister les tests a ecrire

### Etape 2: CODE

- [ ] Implementer la fonctionnalite
- [ ] Respecter l'architecture Clean (core/data/presentation)
- [ ] Suivre les conventions de FLUTTER_SPECS.md
- [ ] Ajouter les tests unitaires EN MEME TEMPS

### Etape 3: COMPILE

```bash
flutter analyze
```

- [ ] 0 erreur
- [ ] 0 warning (sauf justification)
- [ ] Si code generation: `dart run build_runner build --delete-conflicting-outputs`

### Etape 4: TEST

```bash
flutter test
```

1. **Tests automatiques**: Tous doivent passer
2. **Tests manuels**: Liste precise des scenarios
3. **Tests de regression**: Verifier que l'existant fonctionne

### Etape 5: DOC

Mettre a jour la fiche FEAT-XXX avec:

```markdown
## [YYYY-MM-DD] - [Action effectuee]

### Fichiers modifies
- `lib/xxx.dart` - Description

### Tests effectues
- [ ] Test manuel 1: OK/KO
- [ ] Test manuel 2: OK/KO

### Tests unitaires ajoutes
- `test/xxx_test.dart` - X tests

### Prochaine etape
- ...
```

### Etape 6: COMMIT

- [ ] Proposer message de commit a l'utilisateur
- [ ] Attendre validation
- [ ] Commit atomique (1 feature = 1 commit)
- [ ] Mettre a jour la fiche avec le hash du commit

---

## 2. DEFINITION OF DONE

Une tache est **terminee** quand TOUS ces criteres sont remplis:

| Critere | Verification |
|---------|--------------|
| Code compile | `flutter analyze` = 0 erreur |
| Tests passent | `flutter test` = 100% pass |
| Tests manuels OK | Documentes dans la fiche |
| Documentation | Fiche FEAT-XXX a jour |
| Commit valide | Hash note dans la fiche |
| Fiche deplacee | BACKLOG/ → COMPLETED/ |

---

## 3. ESTIMATION

Avant chaque tache, estimer la complexite:

| Complexite | Temps estime | Exemple |
|------------|--------------|---------|
| **Simple** | < 30 min | Fix typo, ajout icone |
| **Moyenne** | 30 min - 2h | Nouveau widget, provider |
| **Complexe** | 2h - 1 jour | Nouvel ecran complet |
| **Majeure** | > 1 jour | **Decouper en sous-taches** |

### Si tache majeure

1. Creer des sous-fiches FEAT-XXX-A, FEAT-XXX-B, etc.
2. Chaque sous-fiche = 1 session max
3. Documenter les dependances

---

## 4. GESTION DES BLOCAGES

### Si bloque

1. **Documenter** le blocage dans la fiche:
   ```markdown
   ### BLOCAGE
   - **Probleme**: Description
   - **Cause**: Analyse
   - **Options**: A, B, C
   ```

2. **Proposer** des alternatives a l'utilisateur

3. **Ne PAS contourner** sans validation

4. **Si workaround temporaire**:
   - Obtenir validation utilisateur
   - Creer entree dans `TECH_DEBT.md`
   - Mettre un TODO dans le code

### Types de blocages courants

| Type | Action |
|------|--------|
| Dependance manquante | Ajouter au pubspec.yaml, documenter |
| API non definie | Proposer structure, valider |
| Design ambigu | Consulter FLUTTER_SPECS.md, demander |
| Bug externe | Documenter, chercher workaround |

---

## 5. WORKFLOW HOTFIX

Pour correction urgente (bug critique en prod):

```
1. Creer branche: hotfix/description-courte
2. Fix minimal (PAS de refactor)
3. Test de non-regression uniquement
4. Commit avec prefix: fix(urgent):
5. Merge rapide
6. Documenter apres coup dans TECH_DEBT.md si dette creee
```

---

## 6. PARALLELISATION

### Peut etre fait en parallele

- Fichiers independants (ex: 2 widgets differents)
- Tests et documentation
- Analyse statique pendant dev

### JAMAIS en parallele

- Modifications du meme fichier
- Dependances entre features
- Refactoring + nouvelle feature

---

## 7. TESTS OBLIGATOIRES

### Avant chaque commit

```bash
# 1. Analyse statique
flutter analyze

# 2. Tests unitaires
flutter test

# 3. Build check (optionnel mais recommande)
flutter build apk --debug
```

### Tests unitaires requis

Pour chaque nouvelle fonctionnalite:
- `test/unit/[feature]_test.dart` - Logique metier
- `test/widget/[widget]_test.dart` - Si nouveau widget

**Minimum: 1 test par fonction publique**

### Tests manuels documentes

```markdown
### Tests manuels a effectuer
1. [ ] Scenario X: Etapes detaillees → Resultat attendu
2. [ ] Scenario Y: Etapes detaillees → Resultat attendu
3. [ ] Regression: Verifier que Z fonctionne toujours
```

---

## 8. STRUCTURE DES COMMITS

### Format

```
type(scope): description courte

- Detail 1
- Detail 2

Tests: flutter test OK
Compile: flutter analyze OK
```

### Types

| Type | Usage |
|------|-------|
| `feat` | Nouvelle fonctionnalite |
| `fix` | Correction de bug |
| `refactor` | Refactoring sans changement fonctionnel |
| `test` | Ajout/modification de tests |
| `docs` | Documentation uniquement |
| `chore` | Maintenance (deps, config) |
| `style` | Formatage, sans changement logique |

### Exemple

```
feat(quiz): ajoute ecran Quiz avec timer

- Cree lib/presentation/screens/quiz/quiz_screen.dart
- Ajoute QuizProvider avec gestion du temps
- Implemente animations de transition
- 12 tests unitaires

Tests: flutter test OK (45/45)
Compile: flutter analyze OK
```

---

## 9. ANTI-REGRESSION

### Avant chaque modification

1. `flutter test` - noter le nombre de tests
2. Apres modification - meme nombre doit passer
3. Si test echoue - corriger AVANT de continuer

### Fichiers critiques (attention)

- `lib/main.dart` - Point d'entree
- `lib/core/router/` - Navigation
- `lib/core/theme/` - Theme global
- `lib/presentation/providers/` - State management

---

## 10. HANDOFF (FIN DE CONTEXTE)

### Declencheur

Quand le contexte atteint **~90%** d'utilisation.

### Procedure

1. **Terminer proprement** l'action en cours (ou noter l'etat)
2. **Executer** le template HANDOFF.md
3. **Creer** `handoffs/HANDOFF-YYYY-MM-DD-HHMM.md`
4. **Generer** le prompt de reprise pour l'utilisateur

### Contenu obligatoire

- Tache en cours + etat
- Fichiers modifies (avec etat)
- Ce qui reste a faire
- Blocages eventuels
- Commande de verification
- **Prompt de reprise** pret a copier

---

## 11. CHECKLIST PRE-COMMIT

```markdown
## Checklist avant commit

### Code
- [ ] `flutter analyze` = 0 erreur
- [ ] `flutter test` = tous passent
- [ ] Pas de print() ou debugPrint() oublies
- [ ] Pas de TODO non documente

### Tests
- [ ] Tests unitaires ajoutes pour nouveau code
- [ ] Tests manuels effectues et documentes
- [ ] Regression verifiee

### Documentation
- [ ] Fiche FEAT-XXX mise a jour
- [ ] FLUTTER_SPECS.md respecte

### Git
- [ ] Message de commit valide par l'utilisateur
- [ ] Commit atomique (1 feature)
- [ ] Pas de fichiers non voulus (build/, .dart_tool/)
```

---

## RESUME

**Chaque avancee = PLAN + CODE + COMPILE + TEST + DOC + COMMIT**

Pas d'exception. Pas de raccourci.
