import 'package:flutter/material.dart';

/// Design Tokens: Opacity
/// TOpacity defines all transparency levels used across the app.
/// Organized by scale, semantic usage, and accessibility variants.
class TOpacity {
  TOpacity._();

  // Scale (0.0 = fully transparent, 1.0 = fully opaque)
  static const double level0 = 0.0; // invisible
  static const double level10 = 0.1;
  static const double level20 = 0.2;
  static const double level30 = 0.3;
  static const double level40 = 0.4;
  static const double level50 = 0.5;
  static const double level60 = 0.6;
  static const double level70 = 0.7;
  static const double level80 = 0.8;
  static const double level90 = 0.9;
  static const double level100 = 1.0; // fully visible

  // Semantic Usage
  static const double disabled = level40; // disabled elements
  static const double hover = level80; // hover states
  static const double focus = level90; // focus states
  static const double pressed = level70; // pressed states
  static const double overlayLight = level50; // light overlay
  static const double overlayDark = level60; // dark overlay
  static const double modalBackdrop = level50; // modal background
  static const double tooltipBackground = level90; // tooltip background

  // Gradual Fade Levels
  static const double fadeInFast = level90;
  static const double fadeInSlow = level70;
  static const double fadeOutFast = level20;
  static const double fadeOutSlow = level40;

  // Accessibility Variants (stronger contrast)
  static const double accessibleDisabled = level30;
  static const double accessibleOverlay = level70;
  static const double accessibleTooltip = level100;

  // Utility
  static const double none = level0;
  static const double full = level100;

  // Tooltip
  static const double tooltipOpacity = 0.9;

  // Map for dynamic usage
  static const Map<String, double> values = {
    'level0': level0,
    'level10': level10,
    'level20': level20,
    'level30': level30,
    'level40': level40,
    'level50': level50,
    'level60': level60,
    'level70': level70,
    'level80': level80,
    'level90': level90,
    'level100': level100,
  };
}

///
/// --- Usage Example ---
///
/// To use opacity tokens in your widgets:
///
/// ```dart
/// Opacity(
///   opacity: TOpacity.disabled,
///   child: const Text("Disabled"),
/// )
/// ```
///
/// This ensures consistent transparency behavior across the app.
///
