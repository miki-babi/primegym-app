import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

import '../screens/activity/activity_screen.dart';
import '../screens/community/community_screens.dart';
import '../screens/community/friend_detail_screens.dart';
import '../screens/community/progress_post_screen.dart';
import '../screens/explore/exercise_detail_screen.dart';
import '../screens/explore/explore_catalog_screens.dart';
import '../screens/explore/explore_screen.dart';
import '../screens/explore/explore_workouts_screen.dart';
import '../screens/gym/gym_screens.dart';
import '../screens/home/home_screen.dart';
import '../screens/onboarding/onboarding_flow.dart';
import '../screens/profile/profile_screen.dart';
import '../screens/shop/checkout_screen.dart';
import '../screens/shop/order_detail_screen.dart';
import '../screens/shop/orders_screen.dart';
import '../screens/shop/shop_screen.dart';
import '../screens/workout/active_workout_screen.dart';
import '../screens/workout/workout_complete_screen.dart';
import '../screens/workout/workout_detail_screen.dart';
import '../screens/workout/workout_start_screen.dart';
import '../widgets/main_shell.dart';

final GlobalKey<NavigatorState> _rootKey = GlobalKey<NavigatorState>();

class _PopHapticObserver extends NavigatorObserver {
  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    HapticFeedback.selectionClick();
  }
}

CustomTransitionPage<void> _fadeSlidePage({
  required LocalKey key,
  required Widget child,
}) {
  return CustomTransitionPage<void>(
    key: key,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final curved = CurvedAnimation(
        parent: animation,
        curve: Curves.easeOutCubic,
      );
      return FadeTransition(
        opacity: curved,
        child: SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 0.04),
            end: Offset.zero,
          ).animate(curved),
          child: child,
        ),
      );
    },
  );
}

CupertinoPage<void> _stackPage({
  required LocalKey key,
  required Widget child,
  bool fullscreenDialog = false,
}) {
  return CupertinoPage<void>(
    key: key,
    child: child,
    fullscreenDialog: fullscreenDialog,
  );
}

GoRouter createRouter() {
  return GoRouter(
    navigatorKey: _rootKey,
    initialLocation: '/onboarding',
    observers: [_PopHapticObserver()],
    routes: [
      GoRoute(
        path: '/onboarding',
        pageBuilder: (context, state) => _fadeSlidePage(
          key: state.pageKey,
          child: const OnboardingFlow(),
        ),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MainShell(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/home',
                builder: (context, state) => const HomeScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/explore',
                builder: (context, state) => const ExploreScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/community',
                builder: (context, state) => const CommunityScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/activity',
                builder: (context, state) => const ActivityScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/profile',
                builder: (context, state) => const ProfileScreen(),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: '/workout/start',
        pageBuilder: (context, state) => _stackPage(
          key: state.pageKey,
          child: const WorkoutStartScreen(),
        ),
      ),
      GoRoute(
        path: '/workout/:id',
        pageBuilder: (context, state) => _stackPage(
          key: state.pageKey,
          child: WorkoutDetailScreen(
            workoutId: state.pathParameters['id']!,
          ),
        ),
        routes: [
          GoRoute(
            path: 'active',
            pageBuilder: (context, state) => _stackPage(
              key: state.pageKey,
              child: ActiveWorkoutScreen(
                workoutId: state.pathParameters['id']!,
              ),
            ),
          ),
          GoRoute(
            path: 'complete',
            pageBuilder: (context, state) => _stackPage(
              key: state.pageKey,
              child: WorkoutCompleteScreen(
                workoutId: state.pathParameters['id']!,
              ),
              fullscreenDialog: true,
            ),
          ),
        ],
      ),
      GoRoute(
        path: '/gym/:id',
        pageBuilder: (context, state) => _stackPage(
          key: state.pageKey,
          child: GymDetailScreen(
            gymId: state.pathParameters['id']!,
          ),
        ),
        routes: [
          GoRoute(
            path: 'check-in',
            pageBuilder: (context, state) => _stackPage(
              key: state.pageKey,
              child: GymCheckInScreen(
                gymId: state.pathParameters['id']!,
              ),
              fullscreenDialog: true,
            ),
          ),
        ],
      ),
      GoRoute(
        path: '/explore/workouts',
        pageBuilder: (context, state) => _stackPage(
          key: state.pageKey,
          child: const ExploreWorkoutsScreen(),
        ),
      ),
      GoRoute(
        path: '/shop',
        pageBuilder: (context, state) => _stackPage(
          key: state.pageKey,
          child: const ShopScreen(),
        ),
      ),
      GoRoute(
        path: '/checkout/:productId',
        pageBuilder: (context, state) => _stackPage(
          key: state.pageKey,
          child: CheckoutScreen(
            productId: state.pathParameters['productId']!,
          ),
        ),
      ),
      GoRoute(
        path: '/orders',
        pageBuilder: (context, state) => _stackPage(
          key: state.pageKey,
          child: const OrdersScreen(),
        ),
      ),
      GoRoute(
        path: '/orders/:id',
        pageBuilder: (context, state) => _stackPage(
          key: state.pageKey,
          child: OrderDetailScreen(
            orderId: state.pathParameters['id']!,
          ),
        ),
      ),
      GoRoute(
        path: '/gyms',
        pageBuilder: (context, state) => _stackPage(
          key: state.pageKey,
          child: const GymListScreen(),
        ),
      ),
      GoRoute(
        path: '/post-progress',
        pageBuilder: (context, state) => _stackPage(
          key: state.pageKey,
          child: const ProgressPostScreen(),
        ),
      ),
      GoRoute(
        path: '/progress/:postId',
        pageBuilder: (context, state) => _stackPage(
          key: state.pageKey,
          child: ProgressPostDetailScreen(
            postId: state.pathParameters['postId']!,
          ),
        ),
      ),
      GoRoute(
        path: '/friend/:name',
        pageBuilder: (context, state) => _stackPage(
          key: state.pageKey,
          child: FriendProfileScreen(
            friendName: state.pathParameters['name']!,
          ),
        ),
      ),
      GoRoute(
        path: '/trainers',
        pageBuilder: (context, state) => _stackPage(
          key: state.pageKey,
          child: const TrainersListScreen(),
        ),
      ),
      GoRoute(
        path: '/trainer/:id',
        pageBuilder: (context, state) => _stackPage(
          key: state.pageKey,
          child: TrainerDetailScreen(
            trainerId: state.pathParameters['id']!,
          ),
        ),
      ),
      GoRoute(
        path: '/events',
        pageBuilder: (context, state) => _stackPage(
          key: state.pageKey,
          child: const EventsListScreen(),
        ),
      ),
      GoRoute(
        path: '/event/:id',
        pageBuilder: (context, state) => _stackPage(
          key: state.pageKey,
          child: EventDetailScreen(
            eventId: state.pathParameters['id']!,
          ),
        ),
      ),
      GoRoute(
        path: '/challenges',
        pageBuilder: (context, state) => _stackPage(
          key: state.pageKey,
          child: const ChallengesListScreen(),
        ),
      ),
      GoRoute(
        path: '/exercise/:id',
        pageBuilder: (context, state) => _stackPage(
          key: state.pageKey,
          child: ExerciseDetailScreen(
            exerciseId: state.pathParameters['id']!,
          ),
        ),
      ),
      GoRoute(
        path: '/challenge/:id',
        pageBuilder: (context, state) => _stackPage(
          key: state.pageKey,
          child: ChallengeDetailScreen(
            challengeId: state.pathParameters['id']!,
          ),
        ),
        routes: [
          GoRoute(
            path: 'leaderboard',
            pageBuilder: (context, state) => _stackPage(
              key: state.pageKey,
              child: ChallengeLeaderboardScreen(
                challengeId: state.pathParameters['id']!,
              ),
            ),
          ),
        ],
      ),
    ],
  );
}
