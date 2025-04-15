import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_auth/src/featured/root/root_screen.dart';
import 'package:supabase_auth/src/routes/routes.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();

final goRouteProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/',
    debugLogDiagnostics: true,
    navigatorKey: rootNavigatorKey,
    observers: <NavigatorObserver>[],
    routes: <RouteBase>[
      GoRoute(
        name: Routes.initialRoute,
        path: '/',
        builder: (context, state) => RootScreen(),
        routes: <RouteBase>[],
      ),
    ],
    redirect: (BuildContext context, GoRouterState state) {
      return null;
    },
  );
});
