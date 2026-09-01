/// Static string identifiers for all routes across the app.
abstract final class AppRoutes {
  const AppRoutes._();

  // Root & Auth Paths
  static const String root = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String onboarding = '/onboarding';

  // Feature Paths
  static const String dashboard = '/dashboard';
  static const String profile = '/profile';

  // Route Names (Used for named navigation)
  static const String loginName = 'login';
  static const String registerName = 'register';
  static const String onboardingName = 'onboarding';
  static const String dashboardName = 'dashboard';
  static const String profileName = 'profile';
}
