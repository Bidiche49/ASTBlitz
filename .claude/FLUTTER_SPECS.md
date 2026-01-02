# AST BLITZ - Cahier des Charges Flutter

> Application de préparation au TAGE MAGE / AST
> Spécifications complètes pour migration React → Flutter

---

## 1. DESIGN SYSTEM

### 1.1 Palette de Couleurs

```dart
class AppColors {
  // === COULEURS PRIMAIRES ===
  static const Color primaryDark = Color(0xFF1E293B);      // slate-800
  static const Color primaryBlue = Color(0xFF3730A3);      // indigo-700
  static const Color accentCyan = Color(0xFF22D3EE);       // cyan-400

  // === BACKGROUNDS ===
  static const Color background = Color(0xFFFFFFFF);       // white
  static const Color backgroundAlt = Color(0xFFF8FAFC);    // slate-50
  static const Color backgroundGradientStart = Color(0xFFF8FAFC); // slate-50
  static const Color backgroundGradientEnd = Color(0xFFDBEAFE);   // blue-100/50

  // === FOREGROUNDS ===
  static const Color foreground = Color(0xFF0A0A0A);       // near-black
  static const Color foregroundMuted = Color(0xFF737373);  // gray-500

  // === CARDS ===
  static const Color card = Color(0xFFFFFFFF);
  static const Color cardForeground = Color(0xFF0A0A0A);

  // === BORDERS ===
  static const Color border = Color(0xFFE5E5E5);           // gray-200
  static const Color borderLight = Color(0xFFF1F5F9);      // slate-100

  // === ÉTATS ===
  static const Color destructive = Color(0xFFEF4444);      // red-500
  static const Color success = Color(0xFF22C55E);          // green-500
  static const Color warning = Color(0xFFF59E0B);          // amber-500

  // === CHARTS ===
  static const Color chart1 = Color(0xFFEA580C);           // orange-600
  static const Color chart2 = Color(0xFF0D9488);           // teal-600
  static const Color chart3 = Color(0xFF1E3A5F);           // dark blue
  static const Color chart4 = Color(0xFFEAB308);           // yellow-500
  static const Color chart5 = Color(0xFFF97316);           // orange-500

  // === GRADIENTS SPÉCIFIQUES ===
  // Module Cards
  static const List<Color> gradientSlate = [Color(0xFF334155), Color(0xFF0F172A)];
  static const List<Color> gradientAmberOrange = [Color(0xFFFBBF24), Color(0xFFF97316)];
  static const List<Color> gradientBlueIndigo = [Color(0xFF1E40AF), Color(0xFF312E81)];

  // Quiz du Jour
  static const List<Color> gradientOrangeRed = [Color(0xFFF97316), Color(0xFFDC2626)];
  static const List<Color> gradientTealGreen = [Color(0xFF14B8A6), Color(0xFF16A34A)];

  // BlitzCoin
  static const List<Color> gradientYellowOrange = [Color(0xFFFACC15), Color(0xFFF97316)];

  // Progress Circle
  static const List<Color> gradientProgress = [Color(0xFF1E293B), Color(0xFF475569)];
}
```

### 1.2 Typographie

```dart
class AppTypography {
  // Font Family: System default (Inter recommandé pour Flutter)
  static const String fontFamily = 'Inter';

  // === TITRES ===
  static const TextStyle h1 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    height: 1.2,
    letterSpacing: -0.5,
  );

  static const TextStyle h2 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    height: 1.3,
  );

  static const TextStyle h3 = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    height: 1.4,
  );

  static const TextStyle h4 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    height: 1.4,
  );

  // === BODY ===
  static const TextStyle bodyLarge = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1.5,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.5,
  );

  static const TextStyle bodySmall = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 1.5,
  );

  // === LABELS ===
  static const TextStyle labelLarge = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    height: 1.4,
  );

  static const TextStyle labelSmall = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w600,
    height: 1.4,
  );

  // === BOUTONS ===
  static const TextStyle button = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    height: 1.4,
  );
}
```

### 1.3 Espacements & Rayons

```dart
class AppSpacing {
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 20;
  static const double xxl = 24;
  static const double xxxl = 32;
}

class AppRadius {
  static const double sm = 4;
  static const double md = 8;
  static const double lg = 12;
  static const double xl = 16;
  static const double xxl = 24;
  static const double full = 9999;
}

class AppShadows {
  static const BoxShadow sm = BoxShadow(
    color: Color(0x0D000000),
    blurRadius: 4,
    offset: Offset(0, 1),
  );

  static const BoxShadow md = BoxShadow(
    color: Color(0x1A000000),
    blurRadius: 8,
    offset: Offset(0, 4),
  );

  static const BoxShadow lg = BoxShadow(
    color: Color(0x1A000000),
    blurRadius: 16,
    offset: Offset(0, 8),
  );

  static const BoxShadow xl = BoxShadow(
    color: Color(0x26000000),
    blurRadius: 24,
    offset: Offset(0, 12),
  );
}
```

---

## 2. ICÔNES

### 2.1 Liste Complète (Lucide Icons → Flutter Icons/Lucide)

Utiliser le package `lucide_icons` pour Flutter.

```dart
// pub.dev: lucide_icons

import 'package:lucide_icons/lucide_icons.dart';

class AppIcons {
  // Navigation
  static const home = LucideIcons.home;
  static const bookOpen = LucideIcons.bookOpen;
  static const zap = LucideIcons.zap;
  static const shoppingCart = LucideIcons.shoppingCart;
  static const user = LucideIcons.user;

  // Actions
  static const arrowLeft = LucideIcons.arrowLeft;
  static const arrowRight = LucideIcons.arrowRight;
  static const check = LucideIcons.check;
  static const checkCircle = LucideIcons.checkCircle;
  static const checkCircle2 = LucideIcons.checkCircle2;
  static const x = LucideIcons.x;
  static const xCircle = LucideIcons.xCircle;
  static const copy = LucideIcons.copy;
  static const download = LucideIcons.download;
  static const edit = LucideIcons.edit;
  static const send = LucideIcons.send;
  static const search = LucideIcons.search;
  static const plus = LucideIcons.plus;
  static const minus = LucideIcons.minus;
  static const refreshCw = LucideIcons.refreshCw;

  // UI Elements
  static const menu = LucideIcons.menu;
  static const settings = LucideIcons.settings;
  static const bell = LucideIcons.bell;
  static const chevronDown = LucideIcons.chevronDown;
  static const chevronRight = LucideIcons.chevronRight;
  static const chevronLeft = LucideIcons.chevronLeft;
  static const moreHorizontal = LucideIcons.moreHorizontal;
  static const panelLeft = LucideIcons.panelLeft;
  static const gripVertical = LucideIcons.gripVertical;

  // Content Types
  static const fileText = LucideIcons.fileText;
  static const penTool = LucideIcons.penTool;
  static const pencil = LucideIcons.pencil;
  static const calculator = LucideIcons.calculator;
  static const calendar = LucideIcons.calendar;

  // Gamification
  static const trophy = LucideIcons.trophy;
  static const award = LucideIcons.award;
  static const star = LucideIcons.star;
  static const crown = LucideIcons.crown;
  static const gem = LucideIcons.gem;
  static const flame = LucideIcons.flame;
  static const target = LucideIcons.target;
  static const coins = LucideIcons.coins;
  static const swords = LucideIcons.swords;

  // Learning
  static const brain = LucideIcons.brain;
  static const brainCircuit = LucideIcons.brainCircuit;
  static const lightbulb = LucideIcons.lightbulb;
  static const sparkles = LucideIcons.sparkles;
  static const bot = LucideIcons.bot;

  // Stats & Charts
  static const barChart = LucideIcons.barChart;
  static const barChart2 = LucideIcons.barChart2;
  static const barChart3 = LucideIcons.barChart3;
  static const trendingUp = LucideIcons.trendingUp;
  static const trendingDown = LucideIcons.trendingDown;

  // Time
  static const clock = LucideIcons.clock;
  static const timer = LucideIcons.timer;
  static const play = LucideIcons.play;

  // Social
  static const users = LucideIcons.users;
  static const messageCircle = LucideIcons.messageCircle;
  static const messageSquare = LucideIcons.messageSquare;
  static const globe = LucideIcons.globe;
  static const hash = LucideIcons.hash;

  // Status
  static const alertCircle = LucideIcons.alertCircle;
  static const alertTriangle = LucideIcons.alertTriangle;
  static const info = LucideIcons.info;
  static const helpCircle = LucideIcons.helpCircle;
  static const loader = LucideIcons.loader;
  static const loader2 = LucideIcons.loader2;
  static const lock = LucideIcons.lock;
  static const shield = LucideIcons.shield;

  // Commerce
  static const creditCard = LucideIcons.creditCard;
  static const mail = LucideIcons.mail;
  static const scale = LucideIcons.scale;

  // Misc
  static const footprints = LucideIcons.footprints;
  static const circle = LucideIcons.circle;
}
```

---

## 3. COMPOSANTS UI

### 3.1 Button

```dart
enum ButtonVariant { primary, secondary, destructive, outline, ghost, link }
enum ButtonSize { sm, md, lg, icon }

class AppButton extends StatelessWidget {
  final String? label;
  final IconData? icon;
  final ButtonVariant variant;
  final ButtonSize size;
  final VoidCallback? onPressed;
  final bool isLoading;

  // Variants:
  // primary: bg-primary text-white shadow hover:bg-primary/90
  // secondary: bg-secondary text-secondary-foreground shadow-sm
  // destructive: bg-destructive text-white shadow-sm
  // outline: border border-input bg-background shadow-sm hover:bg-accent
  // ghost: hover:bg-accent hover:text-accent-foreground
  // link: text-primary underline-offset-4 hover:underline

  // Sizes:
  // sm: h-8 px-3 text-xs rounded-md
  // md: h-9 px-4 py-2 text-sm rounded-md (default)
  // lg: h-10 px-8 text-sm rounded-md
  // icon: h-9 w-9 rounded-md
}
```

### 3.2 Card

```dart
class AppCard extends StatelessWidget {
  // Container: rounded-xl border bg-card shadow
  // Header: flex flex-col space-y-1.5 p-6
  // Title: font-semibold leading-none tracking-tight
  // Description: text-sm text-muted-foreground
  // Content: p-6 pt-0
  // Footer: flex items-center p-6 pt-0
}
```

### 3.3 ModuleCard (Custom)

```dart
class ModuleCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final List<Color> gradient;
  final VoidCallback? onTap;

  // Structure:
  // - Container avec gradient (from-slate-800 to-slate-900 par défaut)
  // - Cercle décoratif semi-transparent en haut à droite
  // - Icône (24-32px)
  // - Titre en bas (semibold, blanc)
  // - Height: 112-128px
  // - Animation: whileHover scale 1.05, y -5
  // - Animation: whileTap scale 0.95
}
```

### 3.4 BlitzCoinIcon

```dart
class BlitzCoinIcon extends StatelessWidget {
  final Size size; // sm: 24, md: 48, lg: 64

  // Structure:
  // - Container carré avec rounded-2xl
  // - Gradient: yellow-400 to orange-500
  // - Icon Zap centré (blanc)
  // - Shadow lg
}
```

### 3.5 ProgressCircle (SVG → CustomPainter)

```dart
class ProgressCircle extends StatelessWidget {
  final int current;
  final int max;
  final double size;

  // Structure:
  // - SVG circle avec stroke-dasharray
  // - Gradient: slate-800 to slate-500
  // - Texte central: current / max
  // - Animation: transition 500ms ease-out
}
```

### 3.6 ScorePredictor

```dart
class ScorePredictor extends StatelessWidget {
  final int currentScore;
  final int maxScore;
  final int predictedScore;
  final String progressionTrend; // 'up', 'down', 'stable'

  // Structure complexe:
  // - Semicircle progress (SVG)
  // - Score actuel centré
  // - Icône tendance (TrendingUp/Down/Minus)
  // - Objectif affiché
  // - Animation: strokeDashoffset 1.5s ease-out
  // - Bouton edit pour modifier l'objectif
}
```

---

## 4. ANIMATIONS

### 4.1 Transitions Standards (Durées)

```dart
class AppDurations {
  static const Duration fast = Duration(milliseconds: 200);
  static const Duration normal = Duration(milliseconds: 300);
  static const Duration slow = Duration(milliseconds: 500);
  static const Duration slower = Duration(milliseconds: 800);
  static const Duration slowest = Duration(milliseconds: 1200);
}

class AppCurves {
  static const Curve easeOut = Curves.easeOut;
  static const Curve easeInOut = Curves.easeInOut;
  static const Curve linear = Curves.linear;
  static const Curve spring = Curves.elasticOut;
}
```

### 4.2 Animations d'Entrée (Page/Component)

```dart
// Pattern 1: Fade + Slide Y
// initial: opacity 0, translateY -20
// animate: opacity 1, translateY 0
// duration: 300-500ms, easeOut

// Pattern 2: Fade + Scale
// initial: opacity 0, scale 0.9
// animate: opacity 1, scale 1
// duration: 300ms, easeOut

// Pattern 3: Staggered List
// Chaque item avec delay: index * 50-100ms
// initial: opacity 0, translateY 20
// animate: opacity 1, translateY 0
```

### 4.3 Animations Interactives

```dart
// Hover (Desktop) / Press (Mobile)
// whileHover: scale 1.02-1.05
// whileTap: scale 0.95-0.98

// ModuleCard spécifique:
// whileHover: scale 1.05, translateY -5
// whileTap: scale 0.95

// Badge Icon:
// whileHover: scale 1.1, rotate 5deg
```

### 4.4 Animations de Progress

```dart
// Progress Bar Width
// initial: width 0
// animate: width percentage%
// duration: 1000-1500ms, easeOut

// Circular Progress (strokeDashoffset)
// duration: 800-1500ms, easeOut

// Score Reveal
// duration: 1200ms avec delay cascade
```

### 4.5 Animations Continues (Décoratives)

```dart
// Rotation infinie (décors)
// rotate: 0 -> 360
// duration: 20s, linear, repeat infinite

// Pulse/Breathing
// scale: [1, 1.1, 1]
// duration: 4s, easeInOut, repeat infinite

// Float
// translateY: [0, -20, 0]
// duration: 3s, easeInOut, repeat infinite
```

---

## 5. ÉCRANS & TEXTES

### 5.1 Navigation Principale (Bottom Nav)

| ID | Titre | Icône | Route |
|----|-------|-------|-------|
| home | Accueil | Home | / |
| learn | Apprendre | BookOpen | /learn |
| exercises | Exercices | Zap | /exercises |
| shop | Boutique | ShoppingCart | /shop |
| profile | Profil | User | /profile |

### 5.2 Home (Accueil)

**Header:**
- Titre: "AST BLITZ"
- Menu burger avec items: Social, Classement, Paramètres

**Score Predictor:**
- Score actuel / max
- Objectif
- Tendance (icône)

**Quiz du Jour (Card):**
- État non complété:
  - Titre: "Quiz du Jour"
  - Sous-titre: "3 questions pour bien démarrer"
  - Description: "Testez vos connaissances avec le défi quotidien !"
  - Gradient: orange → red
- État complété:
  - Titre: "Quiz Terminé !"
  - Sous-titre: "Reviens demain"
  - Description: "Excellent travail pour aujourd'hui !"
  - Gradient: teal → green

**Modules (Grid 2x2):**
| Module | Icône | Gradient |
|--------|-------|----------|
| Blitz | Zap | slate-800 → slate-900 |
| Cours | BookOpen | slate-800 → slate-900 |
| Mon Professeur | Sparkles | amber-400 → orange-500 |
| Duel | Users | blue-800 → indigo-900 |

### 5.3 Exercises (Exercices)

**Header:**
- Titre: "EXERCICES"
- Intro: "Prêt à t'entraîner ?" / "Choisis ton mode de préparation."

**Personnalisation:**
- Bouton: "Choisir quel sous-test réviser"
- Info: "{n} sur {total} actifs"
- CTA: "Personnaliser"

**Modes:**
- Mode Blitz: "Questions rapides"
- Examen Blanc: "Conditions réelles"

**Mode Classique:**
- Titre: "Mode Classique"
- Description: "Entraînement complet à votre rythme."
- Options: "20 min", "40 min", "1 h"

**Entraînement Ciblé:**
- Calcul: "Entraînement calcul mental"
- Rang des lettres: "Maîtrise de l'alphabet"

**Modal Sous-tests:**
- Titre: "Personnaliser vos exercices"
- Description: "Sélectionnez les sous-tests à inclure dans vos entraînements."
- Options: Compréhension, Calcul, Raisonnement, Conditions Minimales, Expression, Logique
- Boutons: "Tout sélectionner", "Valider"

### 5.4 Learn (Apprendre)

**Header:**
- Titre: "APPRENDRE"
- Onglets: "Cours" / "Fiches"

**Section Continue:**
- Titre: "Reprendre"
- Info: "Cours/Fiche X sur Y"

**Explorer:**
- Titre: "Explorer les matières"

**Matières:**
| Matière | Description | Icône |
|---------|-------------|-------|
| Aptitude Numérique | "Maîtrisez chiffres et formules." | Calculator |
| Raisonnement Logique | (8 leçons) | Brain |
| Aptitude Verbale | (5 leçons) | BookOpen |

### 5.5 Quiz

**Header:**
- Timer: "{mm:ss}"
- Progress: "Question {n} sur {total}"

**États:**
- Loading: "Chargement du quiz..."
- Vide: "Aucune question disponible" + astuce
- En cours: Question + 4-5 options (A, B, C, D, E)

**Feedback Réponse:**
- Correct: Vert + Checkmark
- Incorrect: Rouge + X

**Boutons:**
- "Suivant" / "Terminer"

### 5.6 Quiz Result

**Score Display:**
- Grand nombre: "{correct}/{total}"
- Pourcentage: "{%}%"

**Messages par score:**
- ≥90%: "Incroyable !"
- ≥70%: "Excellent !"
- <70%: "Bon effort !"

**Boutons:**
- "Revoir les erreurs"
- "Recommencer"
- "Retour à l'accueil"

### 5.7 Profile (Profil)

**Header:**
- Avatar (sélectionnable)
- Nom: "{full_name}"
- Titre: "{selected_title}"
- Badge Premium (si applicable)

**Niveau:**
- "Niveau {n}"
- XP Bar: "{current} / {required} XP"
- "Prochain niveau: {remaining} XP"

**Stats Cards:**
| Stat | Label |
|------|-------|
| Score | "Score actuel" |
| Temps | "Temps d'étude (semaine)" |
| Exercices | "Exercices (semaine)" |
| Streak | "Série actuelle" |

**Moyennes par matière:**
- Aptitude Numérique: {%}%
- Raisonnement Logique: {%}%
- Aptitude Verbale: {%}%

**Code Parrainage:**
- Titre: "Mon code de parrainage"
- Sous-titre: "Partage ton code"
- Code: "{referral_code}"
- Bouton copier

### 5.8 Settings (Paramètres)

**Liens:**
| Label | Route |
|-------|-------|
| Informations Personnelles | /personal-info |
| Boutique | /shop |
| Centre d'Aide | /help-center |
| Nous Contacter | /contact |
| Politique de Confidentialité | /privacy-policy |
| Conditions d'Utilisation | /terms-of-service |
| Télécharger mes Données | /data-download |
| Déconnexion | (action) |

### 5.9 Agent Chat (Mon Professeur)

**Header:**
- Titre: "Mon Professeur"
- Status: "En ligne • Expert TAGE MAGE"

**Message d'accueil:**
- "Bienvenue ! Je suis ton professeur TAGE MAGE"
- Capacités:
  - "Explications de cours" - "Pose-moi tes questions sur les concepts du TAGE MAGE"
  - "Conseils stratégiques" - "Astuces et méthodes pour réussir l'examen"
  - "Correction d'exercices" - "Je t'aide à résoudre tes exercices pas à pas"
- Astuce: "Sois précis dans tes questions pour obtenir les meilleures réponses !"

**Input:**
- Placeholder: "Posez votre question au professeur..."

### 5.10 Autres Pages

**Daily Problem:**
- Titre: "QUIZ DU JOUR"
- Timer avec warning (rouge si ≤30s)
- 4 options colorées (Orange, Red, Pink, Purple)
- Résultat: "{score}/{total}" + pourcentage

**Duel:**
- Créer un duel
- Rejoindre avec code
- En attente: "Attente de l'adversaire..."

**Real Time Duel:**
- Scores côte à côte (Vous vs Adversaire)
- Progression: "Q{n}/{total}"
- Résultat: Victoire / Défaite / Égalité

**Badges:**
- Titre: "Mes Badges"
- Sous-titre: "Collectionnez-les tous !"
- Progress: "{earned} sur {total} badges obtenus"
- Grid de badges (locked/unlocked)

**Planning:**
- Titre: "MON PLAN D'ÉTUDE"
- Slider objectif: 300-600
- Jours: L, M, M, J, V, S, D
- Rappels switch
- Bouton: "Générer mon plan"

**Social:**
- Onglets: Amis, Demandes, Rechercher
- Cards utilisateurs avec niveau et score
- Actions: Ajouter, Accepter, Rejeter

---

## 6. NAVIGATION & FLOWS

### 6.1 Structure de Navigation

```
┌─────────────────────────────────────────────────────────┐
│                         HOME                             │
└─────────────────────────────────────────────────────────┘
         │              │              │              │
    ┌────▼────┐   ┌────▼────┐   ┌────▼────┐   ┌────▼────┐
    │  LEARN  │   │EXERCISES│   │   DUEL  │   │ PROFILE │
    └────┬────┘   └────┬────┘   └────┬────┘   └────┬────┘
         │              │              │              │
    ┌────▼────┐   ┌────▼────┐   ┌────▼────┐   ┌────▼────┐
    │ SUBJECT │   │EXERCISE │   │REALTIME │   │SETTINGS │
    └────┬────┘   │  MODE   │   │  DUEL   │   └────┬────┘
         │        └────┬────┘   └─────────┘        │
    ┌────▼────┐   ┌────▼────┐              ┌───────┴───────┐
    │ COURSE  │   │   QUIZ  │              │ STATS, BADGES │
    │ CONTENT │   └────┬────┘              │ HELP, etc.    │
    └─────────┘   ┌────▼────┐              └───────────────┘
                  │  QUIZ   │
                  │ RESULT  │
                  └────┬────┘
                  ┌────▼────┐
                  │ REVIEW  │
                  │  QUIZ   │
                  └─────────┘
```

### 6.2 Paramètres de Route

```dart
// Quiz/Exercise
// ?mode={blitz|classique|mock|daily}
// ?time={20|40|60|90}
// ?subtests={calcul,comprehension,...}

// Subject/Course
// ?subject={maths|logique|langues}
// ?type={cours|fiches}
// ?id={courseId}

// Duel
// ?duel={duelId}

// Exercise (targeted)
// ?type={calcul|lettres}
```

### 6.3 Zones de Navigation (Bottom Nav Highlight)

```dart
final navigationZones = {
  'home': ['/', '/home', '/dailyproblem', '/leaderboard'],
  'learn': ['/learn', '/subject', '/coursecontent'],
  'exercises': ['/exercises', '/exercisemode', '/quiz', '/reviewquiz', '/mockexam', '/exercise'],
  'shop': ['/shop', '/cart'],
  'profile': ['/profile', '/settings', '/badges', '/planning', '/stats', '/personalinfo', '/privacypolicy', '/termsofservice'],
};
```

### 6.4 Pages avec Navigation Cachée

```dart
final hiddenNavPages = ['/quiz', '/quizresult'];
```

---

## 7. MODÈLES DE DONNÉES

### 7.1 User

```dart
class User {
  final String id;
  final String email;
  final String fullName;
  final int blitzCoins;
  final int streak;
  final int streakDays;
  final int totalQuestionsAnswered;
  final String? selectedTitle;
  final String? selectedAvatar;
  final int? targetScore;
  final int? currentScore;
  final int? maxScore;
  final int? level;
  final int? xp;
  final int? xpTotal;
  final String? referralCode;
  final String? progressionTrend; // 'up', 'down', 'stable'
  final bool? isPremium;
}
```

### 7.2 Exercise/Question

```dart
class Question {
  final String id;
  final String title;
  final String? content;
  final List<String> options; // A, B, C, D, E
  final int correctAnswer; // index 0-4
  final String? explanation;
  final String category; // calcul, comprehension, raisonnement, etc.
  final String? difficulty; // easy, medium, hard
}
```

### 7.3 Course

```dart
class Course {
  final String id;
  final String title;
  final String subject; // maths, logique, langues
  final String type; // cours, fiches
  final String content; // markdown
  final int lessonNumber;
  final int totalLessons;
  final bool isCompleted;
}
```

### 7.4 Badge

```dart
class Badge {
  final String id;
  final String name;
  final String description;
  final String iconType; // footprints, gem, swords, flame, brain, trophy, award
  final String color;
  final bool isEarned;
  final DateTime? earnedAt;
  final int? progress;
  final int? maxProgress;
}
```

### 7.5 DuelSession

```dart
class DuelSession {
  final String id;
  final String status; // waiting, active, completed
  final String creatorId;
  final String? opponentId;
  final List<Question> questions;
  final int creatorScore;
  final int opponentScore;
  final int currentQuestion;
}
```

### 7.6 QuizResult (SessionStorage equivalent)

```dart
class QuizResult {
  final int correctAnswers;
  final int totalQuestions;
  final String mode;
  final int? time;
  final bool isTimedOut;
  final List<Question> incorrectQuestions;
}
```

---

## 8. PACKAGES FLUTTER RECOMMANDÉS

```yaml
dependencies:
  # UI
  lucide_icons: ^0.260.0          # Icônes
  flutter_svg: ^2.0.0              # SVG support
  cached_network_image: ^3.3.0     # Images
  shimmer: ^3.0.0                  # Loading skeletons

  # Animations
  flutter_animate: ^4.3.0          # Animations simplifiées
  lottie: ^2.7.0                   # Animations Lottie (optionnel)

  # State Management
  flutter_riverpod: ^2.4.0         # Ou provider/bloc selon préférence

  # Navigation
  go_router: ^12.0.0               # Navigation déclarative

  # Storage
  shared_preferences: ^2.2.0       # LocalStorage equivalent
  hive: ^2.2.0                     # NoSQL local DB

  # Networking
  dio: ^5.4.0                      # HTTP client

  # Forms
  flutter_form_builder: ^9.1.0     # Forms

  # Charts
  fl_chart: ^0.65.0                # Charts

  # Markdown
  flutter_markdown: ^0.6.0         # Markdown rendering

  # Utils
  intl: ^0.18.0                    # i18n, date formatting
  uuid: ^4.2.0                     # UUID generation
```

---

## 9. STRUCTURE DE PROJET FLUTTER

```
lib/
├── main.dart
├── app.dart
│
├── core/
│   ├── theme/
│   │   ├── app_colors.dart
│   │   ├── app_typography.dart
│   │   ├── app_spacing.dart
│   │   └── app_theme.dart
│   ├── constants/
│   │   ├── app_icons.dart
│   │   └── app_strings.dart
│   ├── utils/
│   │   ├── formatters.dart
│   │   └── validators.dart
│   └── animations/
│       ├── app_animations.dart
│       └── page_transitions.dart
│
├── data/
│   ├── models/
│   │   ├── user.dart
│   │   ├── question.dart
│   │   ├── course.dart
│   │   ├── badge.dart
│   │   └── duel_session.dart
│   ├── repositories/
│   │   ├── auth_repository.dart
│   │   ├── quiz_repository.dart
│   │   ├── course_repository.dart
│   │   └── user_repository.dart
│   └── services/
│       ├── api_service.dart
│       └── storage_service.dart
│
├── presentation/
│   ├── widgets/
│   │   ├── common/
│   │   │   ├── app_button.dart
│   │   │   ├── app_card.dart
│   │   │   ├── module_card.dart
│   │   │   ├── blitz_coin_icon.dart
│   │   │   ├── progress_circle.dart
│   │   │   └── score_predictor.dart
│   │   ├── quiz/
│   │   │   ├── question_card.dart
│   │   │   ├── option_button.dart
│   │   │   └── quiz_timer.dart
│   │   └── profile/
│   │       ├── avatar_selector.dart
│   │       └── title_selector.dart
│   │
│   ├── screens/
│   │   ├── home/
│   │   │   └── home_screen.dart
│   │   ├── learn/
│   │   │   ├── learn_screen.dart
│   │   │   ├── subject_screen.dart
│   │   │   └── course_content_screen.dart
│   │   ├── exercises/
│   │   │   ├── exercises_screen.dart
│   │   │   ├── exercise_mode_screen.dart
│   │   │   ├── quiz_screen.dart
│   │   │   ├── quiz_result_screen.dart
│   │   │   └── review_quiz_screen.dart
│   │   ├── profile/
│   │   │   ├── profile_screen.dart
│   │   │   ├── settings_screen.dart
│   │   │   ├── badges_screen.dart
│   │   │   └── stats_screens/
│   │   ├── shop/
│   │   │   ├── shop_screen.dart
│   │   │   └── cart_screen.dart
│   │   ├── social/
│   │   │   ├── social_screen.dart
│   │   │   ├── duel_screen.dart
│   │   │   └── realtime_duel_screen.dart
│   │   └── misc/
│   │       ├── daily_problem_screen.dart
│   │       ├── agent_chat_screen.dart
│   │       └── planning_screen.dart
│   │
│   └── navigation/
│       ├── app_router.dart
│       └── bottom_nav_shell.dart
│
└── providers/
    ├── auth_provider.dart
    ├── user_provider.dart
    ├── quiz_provider.dart
    └── theme_provider.dart
```

---

## 10. CHECKLIST D'IMPLÉMENTATION

### Phase 1: Setup & Core
- [ ] Créer le projet Flutter
- [ ] Configurer le thème (couleurs, typo, spacing)
- [ ] Ajouter les packages
- [ ] Créer les modèles de données
- [ ] Configurer la navigation (go_router)

### Phase 2: Components
- [ ] AppButton (toutes variantes)
- [ ] AppCard
- [ ] ModuleCard
- [ ] BlitzCoinIcon
- [ ] ProgressCircle
- [ ] ScorePredictor
- [ ] Bottom Navigation

### Phase 3: Screens - Core
- [ ] Home
- [ ] Exercises
- [ ] ExerciseMode
- [ ] Quiz
- [ ] QuizResult
- [ ] ReviewQuiz

### Phase 4: Screens - Learn
- [ ] Learn
- [ ] Subject
- [ ] CourseContent

### Phase 5: Screens - Profile
- [ ] Profile
- [ ] Settings
- [ ] Badges
- [ ] Stats (4 screens)
- [ ] PersonalInfo

### Phase 6: Screens - Social
- [ ] Social
- [ ] Duel
- [ ] RealTimeDuel

### Phase 7: Screens - Misc
- [ ] Shop
- [ ] Cart
- [ ] DailyProblem
- [ ] AgentChat
- [ ] Planning
- [ ] MockExam
- [ ] Help/Legal pages

### Phase 8: Animations
- [ ] Page transitions
- [ ] Component animations (hover/tap)
- [ ] Progress animations
- [ ] Staggered lists
- [ ] Decorative animations

### Phase 9: Polish
- [ ] Responsive (tablet)
- [ ] Dark mode (optionnel)
- [ ] Loading states
- [ ] Error states
- [ ] Empty states

---

*Document généré le 2 janvier 2026*
*Source: ASTBlitz MVP-WEB (React + Vite + Tailwind)*
