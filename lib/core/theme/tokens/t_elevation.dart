import 'package:flutter/material.dart';

/// Design Tokens: Elevation (Z-Index)
/// TElevation defines all layering tokens used across the app.
/// Organized by scale, semantic usage, and accessibility variants.
class TElevation {
  TElevation._();

  // Scale (base z-index values)
  static const int level0 = 0; // background
  static const int level1 = 1; // base content
  static const int level2 = 10; // raised elements
  static const int level3 = 50; // floating elements
  static const int level4 = 100; // overlays
  static const int level5 = 200; // modals
  static const int level6 = 300; // drawers
  static const int level7 = 400; // tooltips
  static const int level8 = 500; // popovers
  static const int level9 = 600; // dropdowns
  static const int level10 = 1000; // highest priority

  // Semantic Elevation
  static const int appBar = level2;
  static const int navBar = level2;
  static const int card = level2;
  static const int buttonFloating = level3;
  static const int modal = level5;
  static const int drawer = level6;
  static const int tooltip = level7;
  static const int popover = level8;
  static const int dropdown = level9;
  static const int snackbar = level4;
  static const int dialog = level4;

  // Accessibility Variants (higher values for clearer layering)
  static const int accessibleModal = level10;
  static const int accessibleTooltip = level10;
  static const int accessibleDrawer = level10;

  // Utility
  static const int none = level0;
  static const int max = level10;

  // Map for dynamic usage
  static const Map<String, int> values = {
    'level0': level0,
    'level1': level1,
    'level2': level2,
    'level3': level3,
    'level4': level4,
    'level5': level5,
    'level6': level6,
    'level7': level7,
    'level8': level8,
    'level9': level9,
    'level10': level10,
  };
}

///
/// --- Usage Example ---
///
/// To use elevation tokens in your widgets:
///
/// ```dart
/// Stack(
///   children: [
///     Positioned(
///       top: 0,
///       child: Container(
///         color: Colors.white,
///         child: const Text("Modal"),
///       ),
///     ),
///   ],
/// )
/// // Assign z-index using TElevation.modal
/// ```
///
/// This ensures consistent layering and stacking order across the app.
///
