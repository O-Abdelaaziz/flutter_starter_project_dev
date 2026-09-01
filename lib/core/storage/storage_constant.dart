/// Central key registry for local persistence options (Key-Value, Secure Storage, Hive Boxes).
abstract final class StorageConstants {
  const StorageConstants._();

  // Shared Preferences Keys
  static const String keyIsFirstLaunch = 'app_is_first_launch';
  static const String keyAppThemeMode = 'app_theme_mode';
  static const String keyUserLanguage = 'app_user_language';

  // Secure Storage Keys (Sensitive Data)
  static const String keyAuthToken = 'secure_auth_token';
  static const String keyRefreshToken = 'secure_refresh_token';
  static const String keyUserId = 'secure_user_id';

  // Hive Box Names
  static const String boxUserCache = 'user_cache_box';
  static const String boxSettings = 'settings_box';
}
