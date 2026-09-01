import 'package:auto_route/auto_route.dart';

import 'app_routes.dart';

// Import auto-generated routes (created by running: flutter pub run build_runner build)
// Option 2: AutoRoute Implementation (Strongly Typed & Code Generated)
// AutoRoute uses code generation (build_runner) to create strongly typed routes,
// automatically passing route arguments safely without string keys.
import 'auto_route_config.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page|Screen,Route')
class AppAutoRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType => const RouteType.material();

  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: LoginRoute.page, path: AppRoutes.login, initial: true),
    AutoRoute(page: RegisterRoute.page, path: AppRoutes.register),
    AutoRoute(page: OnboardingRoute.page, path: AppRoutes.onboarding),
  ];
}

/// Global Auth Guard for AutoRoute
class AuthGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    const bool isAuthenticated = false; // Replace with Auth State check

    if (isAuthenticated) {
      resolver.next(true);
    } else {
      router.push(const LoginRoute());
    }
  }
}
