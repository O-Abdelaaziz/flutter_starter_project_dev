import 'package:flutter/animation.dart';

/// Design Tokens: Durations
/// TDurations defines all timing values used across the app.
/// Organized by scale, semantic usage, and accessibility variants.
class TDurations {
  TDurations._();

  // Scale (in milliseconds)
  static const Duration xs = Duration(milliseconds: 100);
  static const Duration sm = Duration(milliseconds: 200);
  static const Duration md = Duration(milliseconds: 300);
  static const Duration lg = Duration(milliseconds: 400);
  static const Duration xl = Duration(milliseconds: 600);
  static const Duration xxl = Duration(milliseconds: 800);
  static const Duration xxxl = Duration(milliseconds: 1000);
  static const Duration huge = Duration(milliseconds: 1500);
  static const Duration gigantic = Duration(milliseconds: 2000);

  // Semantic Durations
  static const Duration buttonPress = sm;
  static const Duration buttonRelease = xs;

  static const Duration modalOpen = lg;
  static const Duration modalClose = md;

  static const Duration tooltipFadeIn = sm;
  static const Duration tooltipFadeOut = sm;

  static const Duration snackbarSlideIn = md;
  static const Duration snackbarSlideOut = md;

  static const Duration pageTransition = xl;
  static const Duration drawerTransition = lg;
  static const Duration tabSwitch = md;

  static const Duration listItemExpand = lg;
  static const Duration listItemCollapse = md;

  static const Duration dialogOpen = lg;
  static const Duration dialogClose = md;

  // Delays
  static const Duration delayShort = Duration(milliseconds: 150);
  static const Duration delayMedium = Duration(milliseconds: 300);
  static const Duration delayLong = Duration(milliseconds: 600);

  // Accessibility Variants (slower motion for reduced motion preference)
  static const Duration accessibleSm = Duration(milliseconds: 400);
  static const Duration accessibleMd = Duration(milliseconds: 600);
  static const Duration accessibleLg = Duration(milliseconds: 1000);
  static const Duration accessibleXl = Duration(milliseconds: 1500);

  // Utility
  static const Duration instant = Duration(milliseconds: 0);

  // Map for dynamic usage
  static const Map<String, Duration> values = {
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
/// To use duration tokens in your animations:
///
/// ```dart
/// AnimatedOpacity(
///   duration: TDurations.md,
///   opacity: 1.0,
///   child: const Text("Hello"),
/// )
/// ```
///
/// This ensures consistent timing values across the app.
///
