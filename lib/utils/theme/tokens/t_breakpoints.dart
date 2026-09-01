import 'package:flutter/material.dart';

/// Design Tokens: Breakpoints
/// TBreakpoints defines all responsive thresholds used across the app.
/// Organized by device categories, semantic usage, and accessibility variants.
class TBreakpoints {
  TBreakpoints._();

  // Base Breakpoints (in logical pixels)
  static const double mobileSm = 320.0; // small phones
  static const double mobileMd = 375.0; // standard phones
  static const double mobileLg = 414.0; // large phones

  static const double tabletSm = 600.0; // small tablets
  static const double tabletMd = 768.0; // standard tablets
  static const double tabletLg = 1024.0; // large tablets

  static const double desktopSm = 1280.0; // small desktops
  static const double desktopMd = 1440.0; // standard desktops
  static const double desktopLg = 1920.0; // large desktops

  static const double widescreen = 2560.0; // ultra-wide monitors

  // Semantic Breakpoints
  static const double mobile = tabletSm - 1; // <600
  static const double tablet = desktopSm - 1; // 600–1279
  static const double desktop = widescreen - 1; // 1280–2559
  static const double largeScreen = widescreen; // >=2560

  // Orientation Thresholds
  static const double portraitMaxWidth = 480.0;
  static const double landscapeMinWidth = 481.0;

  // Accessibility Variants (larger breakpoints for scaling UI)
  static const double accessibleMobile = 400.0;
  static const double accessibleTablet = 900.0;
  static const double accessibleDesktop = 1600.0;

  // Utility Methods
  static bool isMobile(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width < tabletSm;
  }

  static bool isTablet(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width >= tabletSm && width < desktopSm;
  }

  static bool isDesktop(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width >= desktopSm && width < widescreen;
  }

  static bool isWidescreen(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width >= widescreen;
  }

  // Custom Map for dynamic usage
  static const Map<String, double> values = {
    'mobileSm': mobileSm,
    'mobileMd': mobileMd,
    'mobileLg': mobileLg,
    'tabletSm': tabletSm,
    'tabletMd': tabletMd,
    'tabletLg': tabletLg,
    'desktopSm': desktopSm,
    'desktopMd': desktopMd,
    'desktopLg': desktopLg,
    'widescreen': widescreen,
  };
}

///
/// --- Usage Example ---
///
/// To use breakpoints in your layout:
///
/// ```dart
/// if (TBreakpoints.isTablet(context)) {
///   return TabletLayout();
/// } else if (TBreakpoints.isDesktop(context)) {
///   return DesktopLayout();
/// } else {
///   return MobileLayout();
/// }
/// ```
///
/// This ensures consistent responsive behavior across devices.
///
