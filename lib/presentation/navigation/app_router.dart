import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/auth_repository.dart';
import '../screens/auth/login_screen.dart';
import '../screens/auth/register_screen.dart';
import '../screens/home/home_screen.dart';
import '../screens/exercises/exercises_screen.dart';
import '../screens/learn/learn_screen.dart';
import '../screens/profile/profile_screen.dart';

// Routes constants
class AppRoutes {
  AppRoutes._();

  // Main tabs
  static const String home = '/';
  static const String learn = '/learn';
  static const String exercises = '/exercises';
  static const String shop = '/shop';
  static const String profile = '/profile';

  // Auth
  static const String login = '/login';
  static const String register = '/register';

  // Quiz flow
  static const String exerciseMode = '/exercise-mode';
  static const String quiz = '/quiz';
  static const String quizResult = '/quiz-result';
  static const String reviewQuiz = '/review-quiz';

  // Learn flow
  static const String subject = '/subject';
  static const String courseContent = '/course-content';

  // Profile
  static const String settings = '/settings';
  static const String badges = '/badges';
  static const String stats = '/stats';

  // Social
  static const String social = '/social';
  static const String duel = '/duel';
  static const String realtimeDuel = '/realtime-duel';

  // Misc
  static const String dailyProblem = '/daily-problem';
  static const String agentChat = '/agent-chat';
  static const String planning = '/planning';
  static const String leaderboard = '/leaderboard';
}

// Navigation zones for bottom nav highlighting
final navigationZones = {
  'home': [AppRoutes.home, AppRoutes.dailyProblem, AppRoutes.leaderboard],
  'learn': [AppRoutes.learn, AppRoutes.subject, AppRoutes.courseContent],
  'exercises': [
    AppRoutes.exercises,
    AppRoutes.exerciseMode,
    AppRoutes.quiz,
    AppRoutes.reviewQuiz,
  ],
  'shop': [AppRoutes.shop],
  'profile': [
    AppRoutes.profile,
    AppRoutes.settings,
    AppRoutes.badges,
    AppRoutes.stats,
  ],
};

// Pages where bottom nav should be hidden
const hiddenNavPages = [
  AppRoutes.quiz,
  AppRoutes.quizResult,
  AppRoutes.realtimeDuel,
];

// Router provider
final routerProvider = Provider<GoRouter>((ref) {
  final isAuthenticated = ref.watch(isAuthenticatedProvider);

  return GoRouter(
    initialLocation: AppRoutes.home,
    debugLogDiagnostics: true,
    redirect: (context, state) {
      final isAuthRoute = state.matchedLocation == AppRoutes.login ||
          state.matchedLocation == AppRoutes.register;

      // Non authentifie → redirige vers login
      if (!isAuthenticated && !isAuthRoute) {
        return AppRoutes.login;
      }

      // Authentifie sur page auth → redirige vers home
      if (isAuthenticated && isAuthRoute) {
        return AppRoutes.home;
      }

      return null;
    },
    routes: [
      // Auth routes (sans bottom nav)
      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: AppRoutes.register,
        builder: (context, state) => const RegisterScreen(),
      ),

      // Main shell with bottom navigation
      ShellRoute(
        builder: (context, state, child) {
          return ScaffoldWithBottomNav(
            currentPath: state.matchedLocation,
            child: child,
          );
        },
        routes: [
          GoRoute(
            path: AppRoutes.home,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: HomeScreen(),
            ),
          ),
          GoRoute(
            path: AppRoutes.learn,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: LearnScreen(),
            ),
          ),
          GoRoute(
            path: AppRoutes.exercises,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: ExercisesScreen(),
            ),
          ),
          GoRoute(
            path: AppRoutes.shop,
            pageBuilder: (context, state) => NoTransitionPage(
              child: _PlaceholderScreen(title: 'Boutique'),
            ),
          ),
          GoRoute(
            path: AppRoutes.profile,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: ProfileScreen(),
            ),
          ),
        ],
      ),

      // Full screen routes (no bottom nav)
      GoRoute(
        path: AppRoutes.quiz,
        builder: (context, state) => _PlaceholderScreen(title: 'Quiz'),
      ),
      GoRoute(
        path: AppRoutes.quizResult,
        builder: (context, state) => _PlaceholderScreen(title: 'Résultat'),
      ),
      GoRoute(
        path: AppRoutes.realtimeDuel,
        builder: (context, state) => _PlaceholderScreen(title: 'Duel'),
      ),
    ],
  );
});

// Scaffold with Bottom Navigation
class ScaffoldWithBottomNav extends StatelessWidget {
  final Widget child;
  final String currentPath;

  const ScaffoldWithBottomNav({
    super.key,
    required this.child,
    required this.currentPath,
  });

  int _getSelectedIndex() {
    if (navigationZones['home']!.contains(currentPath)) return 0;
    if (navigationZones['learn']!.contains(currentPath)) return 1;
    if (navigationZones['exercises']!.contains(currentPath)) return 2;
    if (navigationZones['shop']!.contains(currentPath)) return 3;
    if (navigationZones['profile']!.contains(currentPath)) return 4;
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    // Hide bottom nav on certain pages
    if (hiddenNavPages.contains(currentPath)) {
      return child;
    }

    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _getSelectedIndex(),
        onTap: (index) {
          switch (index) {
            case 0:
              context.go(AppRoutes.home);
              break;
            case 1:
              context.go(AppRoutes.learn);
              break;
            case 2:
              context.go(AppRoutes.exercises);
              break;
            case 3:
              context.go(AppRoutes.shop);
              break;
            case 4:
              context.go(AppRoutes.profile);
              break;
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Accueil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book_outlined),
            activeIcon: Icon(Icons.menu_book),
            label: 'Apprendre',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bolt_outlined),
            activeIcon: Icon(Icons.bolt),
            label: 'Exercices',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined),
            activeIcon: Icon(Icons.shopping_cart),
            label: 'Boutique',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}

// Placeholder screen for routes not yet implemented
class _PlaceholderScreen extends StatelessWidget {
  final String title;

  const _PlaceholderScreen({required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Text(
          '$title\n(En construction)',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
    );
  }
}
