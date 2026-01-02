# Regles Git - AST Blitz Flutter

## REGLES STRICTES - A RESPECTER SYSTEMATIQUEMENT

### 1. Demander Avant de Committer

- **TOUJOURS** demander la permission a l'utilisateur avant de creer un commit
- Ne JAMAIS committer automatiquement, meme si c'est logique
- Proposer un message de commit et attendre validation

### 2. Messages de Commit

- **JAMAIS** mentionner Claude, AI, ou "Generated with Claude Code"
- **JAMAIS** ajouter "Co-Authored-By: Claude"
- Messages simples, clairs et professionnels
- En francais pour ce projet
- Format: Type + scope + description

### 3. Frequence des Commits

- Committer regulierement a chaque avancee validee
- Petits commits atomiques plutot qu'un gros commit
- Chaque fonctionnalite/fix = 1 commit

---

## FORMAT DE COMMIT

### Structure

```
type(scope): description courte (max 50 chars)

- Detail 1
- Detail 2

Tests: flutter test OK
Compile: flutter analyze OK
```

### Types disponibles

| Type | Usage | Exemple |
|------|-------|---------|
| `feat` | Nouvelle fonctionnalite | `feat(quiz): ajoute timer countdown` |
| `fix` | Correction de bug | `fix(auth): corrige crash au login` |
| `refactor` | Refactoring | `refactor(providers): simplifie QuizProvider` |
| `test` | Tests | `test(quiz): ajoute tests QuizProvider` |
| `docs` | Documentation | `docs: met a jour README` |
| `chore` | Maintenance | `chore: upgrade dependencies` |
| `style` | Formatage | `style: applique dart format` |

### Scopes courants

| Scope | Concerne |
|-------|----------|
| `quiz` | Fonctionnalites quiz |
| `learn` | Section apprentissage |
| `profile` | Profil utilisateur |
| `auth` | Authentification |
| `ui` | Composants UI generiques |
| `nav` | Navigation |
| `providers` | State management |
| `theme` | Theme et styles |

---

## EXEMPLES

### BON commit

```
feat(quiz): implemente ecran Quiz avec animations

- Cree QuizScreen avec timer countdown
- Ajoute animations de transition entre questions
- Implemente feedback visuel (correct/incorrect)
- Gestion du state via QuizProvider

Tests: 12/12 passent
Compile: flutter analyze OK
```

### MAUVAIS commit (A EVITER)

```
Add quiz screen

Generated with Claude Code
Co-Authored-By: Claude <noreply@anthropic.com>
```

---

## WORKFLOW GIT

### Avant de proposer un commit

1. **Verifier** que le code compile: `flutter analyze`
2. **Verifier** que les tests passent: `flutter test`
3. **Verifier** les fichiers a committer: `git status`
4. **Exclure** les fichiers non voulus (build/, .dart_tool/)

### Proposition a l'utilisateur

```
Je peux creer un commit avec ce message:

---
feat(scope): description

- Detail 1
- Detail 2

Tests: flutter test OK
Compile: flutter analyze OK
---

Ca te convient ?
```

### Apres validation

1. `git add` des fichiers pertinents
2. `git commit` avec le message valide
3. Mettre a jour la fiche FEAT-XXX avec le hash

---

## BRANCHES

### Convention de nommage

| Type | Format | Exemple |
|------|--------|---------|
| Feature | `feature/description` | `feature/quiz-screen` |
| Fix | `fix/description` | `fix/timer-crash` |
| Hotfix | `hotfix/description` | `hotfix/login-urgent` |
| Refactor | `refactor/description` | `refactor/providers` |

### Workflow branches

```
main
  └── feature/xxx
        ├── commit 1
        ├── commit 2
        └── merge → main
```

---

## CHECKLIST AVANT COMMIT

- [ ] `flutter analyze` = 0 erreur
- [ ] `flutter test` = tous passent
- [ ] Message de commit propose a l'utilisateur
- [ ] Utilisateur a approuve le commit
- [ ] Message ne mentionne PAS Claude/AI
- [ ] Fichiers pertinents uniquement
- [ ] Fiche FEAT-XXX mise a jour avec hash

---

## FICHIERS A NE JAMAIS COMMITTER

```gitignore
# Build
build/
.dart_tool/
*.iml

# IDE
.idea/
.vscode/
*.swp

# Dependencies
.packages
.pub-cache/
pubspec.lock  # Selon projet

# OS
.DS_Store
Thumbs.db

# Secrets
*.env
*.key
firebase_options.dart  # Si contient secrets
```
