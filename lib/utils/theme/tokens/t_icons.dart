import 'package:flutter/material.dart';

/// Design Tokens: Icons
/// TIcons defines all standardized icon sizes used across the app.
/// Organized by scale, semantic usage, and accessibility variants.
class TIcons {
  TIcons._();

  // Scale (in logical pixels)
  static const double xs = 12.0;
  static const double sm = 16.0;
  static const double md = 20.0;
  static const double lg = 24.0;
  static const double xl = 32.0;
  static const double xxl = 40.0;
  static const double xxxl = 48.0;
  static const double huge = 64.0;
  static const double gigantic = 96.0;

  // Semantic Usage
  static const double buttonIcon = md; // icons inside buttons
  static const double appBarIcon = lg; // icons in app bar
  static const double navBarIcon = xl; // icons in bottom navigation
  static const double drawerIcon = lg; // icons in drawer menu
  static const double listItemIcon = md; // icons in list tiles
  static const double chipIcon = sm; // icons in chips/tags
  static const double tooltipIcon = xs; // small icons in tooltips
  static const double dialogIcon = xl; // icons in dialogs
  static const double cardIcon = lg; // icons in cards

  // Accessibility Variants (larger icons for readability)
  static const double accessibleSm = lg; // replaces sm with lg
  static const double accessibleMd = xl; // replaces md with xl
  static const double accessibleLg = xxl; // replaces lg with xxl
  static const double accessibleXl = xxxl; // replaces xl with xxxl

  // Utility
  static const double none = 0.0;

  // Map for dynamic usage
  static const Map<String, double> values = {
    'xs': xs,
    'sm': sm,
    'md': md,
    'lg': lg,
    'xl': xl,
    'xxl': xxl,
    'xxxl': xxxl,
    'huge': huge,
    'gigantic': gigantic,
  };
}

///
/// --- Usage Example ---
///
/// To use icon tokens in your widgets:
///
/// ```dart
/// Icon(
///   Icons.settings,
///   size: TIcons.appBarIcon,
/// )
/// ```
///
/// This ensures consistent icon sizing across the app.
///
