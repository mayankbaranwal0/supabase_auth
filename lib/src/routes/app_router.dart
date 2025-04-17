import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../features/auth/presentation/login_screen.dart';
import '../features/auth/presentation/register_screen.dart';
import '../features/home/presentation/home_screen.dart';
import '../features/onboarding/onboarding_screen.dart';
import '../features/root/root_screen.dart';
import 'routes.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();
// final _shellNavigatorKey = GlobalKey<NavigatorState>();

final goRouteProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/',
    debugLogDiagnostics: true,
    navigatorKey: rootNavigatorKey,
    observers: <NavigatorObserver>[],
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        name: Routes.initialRoute,
        builder: (context, state) => const RootScreen(),
      ),
      GoRoute(
        path: Routes.onboardingScreenRoute,
        name: Routes.onboardingScreenRoute,
        builder: (context, state) => OnboardingScreen(),
        routes: [
          GoRoute(
            path: Routes.loginScreenRoute,
            name: Routes.loginScreenRoute,
            builder: (context, state) => const LoginScreen(),
          ),
          GoRoute(
            path: Routes.registerScreenRoute,
            name: Routes.registerScreenRoute,
            builder: (context, state) => const RegisterScreen(),
          ),
        ],
      ),
      GoRoute(
        path: Routes.homeScreenRoute,
        name: Routes.homeScreenRoute,
        builder: (context, state) => HomeScreen(),
      ),
    ],
    redirect: (BuildContext context, GoRouterState state) {
      return null;
    },
  );
});
