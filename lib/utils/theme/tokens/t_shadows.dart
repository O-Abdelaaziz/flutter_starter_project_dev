import 'package:flutter/material.dart';

/// Design Tokens: Shadows
/// TShadows defines all shadow tokens used across the app.
/// Organized by elevation levels, semantic usage, overlays, and accessibility variants.
class TShadows {
  TShadows._();

  // Elevation Levels (Material-style)
  static const List<BoxShadow> elevation1 = [
    BoxShadow(
      color: Color(0x1F000000), // 12% black
      offset: Offset(0, 1),
      blurRadius: 3,
      spreadRadius: 0,
    ),
  ];

  static const List<BoxShadow> elevation2 = [
    BoxShadow(
      color: Color(0x24000000), // 14% black
      offset: Offset(0, 2),
      blurRadius: 6,
      spreadRadius: 0,
    ),
  ];

  static const List<BoxShadow> elevation3 = [
    BoxShadow(
      color: Color(0x33000000), // 20% black
      offset: Offset(0, 4),
      blurRadius: 8,
      spreadRadius: 0,
    ),
  ];

  static const List<BoxShadow> elevation4 = [
    BoxShadow(
      color: Color(0x40000000), // 25% black
      offset: Offset(0, 6),
      blurRadius: 10,
      spreadRadius: 0,
    ),
  ];

  static const List<BoxShadow> elevation5 = [
    BoxShadow(
      color: Color(0x4D000000), // 30% black
      offset: Offset(0, 8),
      blurRadius: 12,
      spreadRadius: 0,
    ),
  ];

  static const List<BoxShadow> elevation6 = [
    BoxShadow(
      color: Color(0x59000000), // 35% black
      offset: Offset(0, 10),
      blurRadius: 16,
      spreadRadius: 0,
    ),
  ];

  static const List<BoxShadow> elevation7 = [
    BoxShadow(
      color: Color(0x66000000), // 40% black
      offset: Offset(0, 12),
      blurRadius: 20,
      spreadRadius: 0,
    ),
  ];

  static const List<BoxShadow> elevation8 = [
    BoxShadow(
      color: Color(0x73000000), // 45% black
      offset: Offset(0, 14),
      blurRadius: 24,
      spreadRadius: 0,
    ),
  ];

  static const List<BoxShadow> elevation9 = [
    BoxShadow(
      color: Color(0x80000000), // 50% black
      offset: Offset(0, 16),
      blurRadius: 28,
      spreadRadius: 0,
    ),
  ];

  static const List<BoxShadow> elevation10 = [
    BoxShadow(
      color: Color(0x99000000), // 60% black
      offset: Offset(0, 20),
      blurRadius: 32,
      spreadRadius: 0,
    ),
  ];

  // Semantic Shadows
  static const List<BoxShadow> cardShadow = elevation2;
  static const List<BoxShadow> buttonShadow = elevation1;
  static const List<BoxShadow> modalShadow = elevation8;
  static const List<BoxShadow> tooltipShadow = elevation3;
  static const List<BoxShadow> dropdownShadow = elevation4;

  // Soft Shadows (lighter intensity)
  static const List<BoxShadow> softShadowSm = [
    BoxShadow(
      color: Color(0x14000000), // 8% black
      offset: Offset(0, 1),
      blurRadius: 2,
    ),
  ];

  static const List<BoxShadow> softShadowMd = [
    BoxShadow(
      color: Color(0x1F000000), // 12% black
      offset: Offset(0, 2),
      blurRadius: 4,
    ),
  ];

  static const List<BoxShadow> softShadowLg = [
    BoxShadow(
      color: Color(0x24000000), // 14% black
      offset: Offset(0, 4),
      blurRadius: 6,
    ),
  ];

  // Hard Shadows (stronger intensity)
  static const List<BoxShadow> hardShadowSm = [
    BoxShadow(
      color: Color(0x40000000), // 25% black
      offset: Offset(0, 2),
      blurRadius: 2,
    ),
  ];

  static const List<BoxShadow> hardShadowMd = [
    BoxShadow(
      color: Color(0x59000000), // 35% black
      offset: Offset(0, 4),
      blurRadius: 4,
    ),
  ];

  static const List<BoxShadow> hardShadowLg = [
    BoxShadow(
      color: Color(0x73000000), // 45% black
      offset: Offset(0, 6),
      blurRadius: 6,
    ),
  ];

  // Overlays
  static const Color overlayLight = Color(0x80FFFFFF); // 50% white
  static const Color overlayDark = Color(0x80000000); // 50% black

  // Accessibility Variants (stronger shadows for better depth perception)
  static const List<BoxShadow> accessibleShadowSm = [
    BoxShadow(
      color: Color(0x66000000), // 40% black
      offset: Offset(0, 2),
      blurRadius: 4,
    ),
  ];

  static const List<BoxShadow> accessibleShadowMd = [
    BoxShadow(
      color: Color(0x80000000), // 50% black
      offset: Offset(0, 4),
      blurRadius: 8,
    ),
  ];

  static const List<BoxShadow> accessibleShadowLg = [
    BoxShadow(
      color: Color(0x99000000), // 60% black
      offset: Offset(0, 6),
      blurRadius: 12,
    ),
  ];

  // Utility Shadows
  static const List<BoxShadow> none = [];
}

///
/// --- Usage Example ---
///
/// To use shadow tokens in your widgets:
///
/// ```dart
/// Container(
///   decoration: BoxDecoration(
///     color: Colors.white,
///     boxShadow: TShadows.shadowMd,
///   ),
/// )
/// ```
///
/// This ensures consistent shadowing across the app.
///
