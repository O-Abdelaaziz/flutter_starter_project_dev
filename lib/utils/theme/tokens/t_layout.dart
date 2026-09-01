import 'package:flutter/material.dart';

/// Design Tokens: Layout
/// TLayout defines all grid, container widths, and layout tokens used across the app.
/// Organized by scale, semantic usage, and accessibility variants.
class TLayout {
  TLayout._();

  // Base Grid System
  static const int gridColumns = 12;
  static const double gridGutter = 16.0;
  static const double gridMargin = 24.0;

  // Container Widths (responsive)
  static const double containerMobile = 360.0;
  static const double containerTablet = 720.0;
  static const double containerDesktop = 1200.0;
  static const double containerWidescreen = 1440.0;

  // Semantic Layouts
  static const double contentMaxWidth = containerDesktop;
  static const double contentMinWidth = containerMobile;

  static const double sidebarWidthSm = 240.0;
  static const double sidebarWidthMd = 320.0;
  static const double sidebarWidthLg = 400.0;

  static const double drawerWidth = 300.0;
  static const double navBarHeight = 56.0;
  static const double appBarHeight = 64.0;
  static const double footerHeight = 48.0;

  // Section Spacing
  static const double sectionPadding = 32.0;
  static const double sectionMargin = 48.0;

  // Card Layout
  static const double cardMaxWidth = 400.0;
  static const double cardMinWidth = 280.0;

  // Dialog Layout
  static const double dialogMaxWidth = 600.0;
  static const double dialogMinWidth = 320.0;

  // Breakpoint-based Layouts
  static const double mobileBreakpoint = 600.0;
  static const double tabletBreakpoint = 1024.0;
  static const double desktopBreakpoint = 1440.0;

  // Accessibility Variants (larger containers for readability)
  static const double accessibleContainerMobile = 400.0;
  static const double accessibleContainerTablet = 800.0;
  static const double accessibleContainerDesktop = 1400.0;

  // Utility
  static const double fullWidth = double.infinity;
  static const double auto = double.infinity;

  // Map for dynamic usage
  static const Map<String, double> containers = {
    'mobile': containerMobile,
    'tablet': containerTablet,
    'desktop': containerDesktop,
    'widescreen': containerWidescreen,
  };

  static const Map<String, double> sidebars = {
    'sm': sidebarWidthSm,
    'md': sidebarWidthMd,
    'lg': sidebarWidthLg,
  };
}

///
/// --- Usage Example ---
///
/// To use layout tokens in your widgets:
///
/// ```dart
/// Container(
///   constraints: BoxConstraints(
///     maxWidth: TLayout.contentMaxWidth,
///   ),
///   child: const Text("Responsive Content"),
/// )
/// ```
///
/// This ensures consistent container sizing and layout behavior across the app.
///
