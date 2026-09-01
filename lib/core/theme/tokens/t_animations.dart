import 'package:flutter/animation.dart';

/// Design Tokens: Animations
/// TAnimations defines reusable animation configurations (duration + curve).
/// Organized by semantic usage, accessibility variants, and utility presets.
class TAnimations {
  TAnimations._();

  // Basic Presets
  static const AnimationConfig fadeInFast = AnimationConfig(
    duration: Duration(milliseconds: 200),
    curve: Curves.easeIn,
  );

  static const AnimationConfig fadeOutFast = AnimationConfig(
    duration: Duration(milliseconds: 200),
    curve: Curves.easeOut,
  );

  static const AnimationConfig fadeInSlow = AnimationConfig(
    duration: Duration(milliseconds: 600),
    curve: Curves.easeIn,
  );

  static const AnimationConfig fadeOutSlow = AnimationConfig(
    duration: Duration(milliseconds: 600),
    curve: Curves.easeOut,
  );

  // Semantic Animations
  static const AnimationConfig buttonPress = AnimationConfig(
    duration: Duration(milliseconds: 150),
    curve: Curves.easeOut,
  );

  static const AnimationConfig modalTransition = AnimationConfig(
    duration: Duration(milliseconds: 400),
    curve: Curves.fastOutSlowIn,
  );

  static const AnimationConfig tooltipFade = AnimationConfig(
    duration: Duration(milliseconds: 200),
    curve: Curves.easeInOut,
  );

  static const AnimationConfig snackbarSlide = AnimationConfig(
    duration: Duration(milliseconds: 300),
    curve: Curves.easeOut,
  );

  static const AnimationConfig pageTransition = AnimationConfig(
    duration: Duration(milliseconds: 600),
    curve: Curves.fastOutSlowIn,
  );

  static const AnimationConfig drawerTransition = AnimationConfig(
    duration: Duration(milliseconds: 400),
    curve: Curves.easeInOut,
  );

  static const AnimationConfig tabSwitch = AnimationConfig(
    duration: Duration(milliseconds: 300),
    curve: Curves.easeInOut,
  );

  static const AnimationConfig listItemExpand = AnimationConfig(
    duration: Duration(milliseconds: 400),
    curve: Curves.easeOut,
  );

  static const AnimationConfig listItemCollapse = AnimationConfig(
    duration: Duration(milliseconds: 300),
    curve: Curves.easeIn,
  );

  static const AnimationConfig dialogOpen = AnimationConfig(
    duration: Duration(milliseconds: 400),
    curve: Curves.fastOutSlowIn,
  );

  static const AnimationConfig dialogClose = AnimationConfig(
    duration: Duration(milliseconds: 300),
    curve: Curves.easeInOut,
  );

  // Accessibility Variants (slower, linear motion)
  static const AnimationConfig accessibleFade = AnimationConfig(
    duration: Duration(milliseconds: 800),
    curve: Curves.linear,
  );

  static const AnimationConfig accessibleTransition = AnimationConfig(
    duration: Duration(milliseconds: 1000),
    curve: Curves.linear,
  );

  // Utility
  static const AnimationConfig instant = AnimationConfig(
    duration: Duration(milliseconds: 0),
    curve: Curves.linear,
  );
}

///
/// Helper Class: AnimationConfig
/// Combines duration and curve into a single reusable object.
class AnimationConfig {
  final Duration duration;
  final Curve curve;

  const AnimationConfig({required this.duration, required this.curve});
}

///
/// --- Usage Example ---
///
/// To use animation tokens in your widgets:
///
/// ```dart
/// AnimatedOpacity(
///   duration: TAnimations.fadeInFast.duration,
///   curve: TAnimations.fadeInFast.curve,
///   opacity: 1.0,
///   child: const Text("Hello"),
/// )
/// ```
///
/// This ensures consistent animation definitions across the app.
///
