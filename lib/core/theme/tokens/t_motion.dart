import 'package:flutter/animation.dart';

/// Design Tokens: Motion
/// TMotion defines all motion-related tokens used across the app.
/// Organized by durations, easing curves, delays, and semantic usage.
class TMotion {
  TMotion._();

  // Durations (in milliseconds)
  static const Duration durationXs = Duration(milliseconds: 100);
  static const Duration durationSm = Duration(milliseconds: 200);
  static const Duration durationMd = Duration(milliseconds: 300);
  static const Duration durationLg = Duration(milliseconds: 400);
  static const Duration durationXl = Duration(milliseconds: 600);
  static const Duration duration2xl = Duration(milliseconds: 800);
  static const Duration duration3xl = Duration(milliseconds: 1000);

  // Delays
  static const Duration delayShort = Duration(milliseconds: 150);
  static const Duration delayMedium = Duration(milliseconds: 300);
  static const Duration delayLong = Duration(milliseconds: 600);

  // Easing Curves
  static const Curve easeIn = Curves.easeIn;
  static const Curve easeOut = Curves.easeOut;
  static const Curve easeInOut = Curves.easeInOut;

  static const Curve linear = Curves.linear;
  static const Curve fastOutSlowIn = Curves.fastOutSlowIn;
  static const Curve bounceIn = Curves.bounceIn;
  static const Curve bounceOut = Curves.bounceOut;
  static const Curve bounceInOut = Curves.bounceInOut;

  static const Curve elasticIn = Curves.elasticIn;
  static const Curve elasticOut = Curves.elasticOut;
  static const Curve elasticInOut = Curves.elasticInOut;

  static const Curve decelerate = Curves.decelerate;
  static const Curve accelerate = Curves.easeInCubic;

  // Semantic Motion Styles
  static const Duration buttonPressDuration = durationSm;
  static const Curve buttonPressCurve = easeOut;

  static const Duration modalTransitionDuration = durationLg;
  static const Curve modalTransitionCurve = fastOutSlowIn;

  static const Duration tooltipFadeDuration = durationSm;
  static const Curve tooltipFadeCurve = easeInOut;

  static const Duration snackbarSlideDuration = durationMd;
  static const Curve snackbarSlideCurve = easeOut;

  static const Duration pageTransitionDuration = durationXl;
  static const Curve pageTransitionCurve = fastOutSlowIn;

  static const Duration drawerTransitionDuration = durationLg;
  static const Curve drawerTransitionCurve = easeInOut;

  static const Duration tabSwitchDuration = durationMd;
  static const Curve tabSwitchCurve = easeInOut;

  // Accessibility Variants (slower motion for reduced motion preference)
  static const Duration accessibleDurationSm = Duration(milliseconds: 400);
  static const Duration accessibleDurationMd = Duration(milliseconds: 600);
  static const Duration accessibleDurationLg = Duration(milliseconds: 1000);

  static const Curve accessibleCurve = linear;

  // Utility Motion
  static const Duration instant = Duration(milliseconds: 0);
  static const Curve none = Curves.linear;
}

///
/// --- Usage Example ---
///
/// To use motion tokens in your animations:
///
/// ```dart
/// AnimatedContainer(
///   duration: TMotion.durationMd,
///   curve: TMotion.easeInOut,
///   child: const Text("Hello"),
/// )
/// ```
///
/// This ensures consistent motion across the app.
///
