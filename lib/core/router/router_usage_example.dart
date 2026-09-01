import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'app_routes.dart';
import 'go_router_config.dart';

// =============================================================================
// STEP 1: Main Application Setup (main.dart)
// =============================================================================
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. If using GoRouter:
    return MaterialApp.router(
      title: 'Flutter Starter',
      routerConfig: GoRouterConfig.router,
    );

    // 2. If using AutoRoute:
    // final _autoRouter = AppAutoRouter();
    // return MaterialApp.router(
    //   routerConfig: _autoRouter.config(),
    // );
  }
}

// =============================================================================
// STEP 2: Declarative Navigation inside Feature Screens
// =============================================================================
class NavigationExampleWidget extends StatelessWidget {
  const NavigationExampleWidget({super.key});

  void navigateWithGoRouter(BuildContext context) {
    // Navigate by Path
    context.go(AppRoutes.register);

    // Push screen onto stack (keeps back button)
    context.pushNamed(AppRoutes.registerName);

    // Pass Path Parameters or Query Parameters
    context.go('${AppRoutes.profile}?userId=123');
  }

  // void navigateWithAutoRoute(BuildContext context) {
  //   // Strongly-typed navigation (Generated Class)
  //   context.router.push(const RegisterRoute());
  // }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => navigateWithGoRouter(context),
      child: const Text('Go to Register'),
    );
  }
}
