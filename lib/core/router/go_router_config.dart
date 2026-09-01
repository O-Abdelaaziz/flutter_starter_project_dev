import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/authentication/presentation/screens/login_screen.dart';
import '../../features/authentication/presentation/screens/onboarding_screen.dart';
import '../../features/authentication/presentation/screens/register_screen.dart';
import 'app_routes.dart';

/// Central GoRouter configuration with dynamic redirects and global key setup.
/// Option 1: GoRouter Implementation (Official & Recommended)
//  GoRouter is fully declarative, supports deep linking,
//  nested shell routes, and integrates natively with Flutter's Router API without code generation.
abstract final class GoRouterConfig {
  const GoRouterConfig._();

  static final GlobalKey<NavigatorState> rootNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'root');

  static final GoRouter router = GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: AppRoutes.login,
    debugLogDiagnostics: true,

    // Global redirect logic (e.g., Auth Guards)
    redirect: (BuildContext context, GoRouterState state) {
      const bool isAuthenticated =
          false; // Replace with your Auth Controller state check
      final bool isLoggingIn = state.matchedLocation == AppRoutes.login;

      if (!isAuthenticated && !isLoggingIn) {
        return AppRoutes.login;
      }
      if (isAuthenticated && isLoggingIn) {
        return AppRoutes.dashboard;
      }
      return null; // No redirect needed
    },

    routes: <RouteBase>[
      GoRoute(
        path: AppRoutes.login,
        name: AppRoutes.loginName,
        builder: (BuildContext context, GoRouterState state) =>
            const LoginScreen(),
      ),
      GoRoute(
        path: AppRoutes.register,
        name: AppRoutes.registerName,
        builder: (BuildContext context, GoRouterState state) =>
            const RegisterScreen(),
      ),
      GoRoute(
        path: AppRoutes.onboarding,
        name: AppRoutes.onboardingName,
        builder: (BuildContext context, GoRouterState state) =>
            const OnboardingScreen(),
      ),
    ],

    // Global Error Screen for 404 / Unknown routes
    errorBuilder: (BuildContext context, GoRouterState state) => Scaffold(
      body: Center(child: Text('Route not found: ${state.error?.message}')),
    ),
  );
}
