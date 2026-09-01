/// Centralized asset path registry for images, icons, and graphics.
abstract final class AssetConstants {
  const AssetConstants._();

  // Base Path
  static const String _imageBase = 'assets/images';

  // General Assets
  static const String appIcon = '$_imageBase/app_icon.png';
  static const String appLogo = '$_imageBase/app_logo.png';
  static const String appSplash = '$_imageBase/app_splash.png';

  // Light Theme Assets
  static const String appIconLight = '$_imageBase/app_icon_light.png';
  static const String appLogoLight = '$_imageBase/app_logo_light.png';
  static const String appSplashLight = '$_imageBase/app_splash_light.png';

  // Dark Theme Assets
  static const String appIconDark = '$_imageBase/app_icon_dark.png';
  static const String appLogoDark = '$_imageBase/app_logo_dark.png';
  static const String appSplashDark = '$_imageBase/app_splash_dark.png';
}
