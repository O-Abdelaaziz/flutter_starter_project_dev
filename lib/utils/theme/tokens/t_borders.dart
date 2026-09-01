import 'package:flutter/material.dart';

/// Design Tokens: Borders
/// TBorders defines all stroke widths and border styles used across the app.
/// Organized by scale, semantic usage, and accessibility variants.
class TBorders {
  TBorders._();

  // Scale (stroke widths in logical pixels)
  static const double hairline = 0.5;
  static const double thin = 1.0;
  static const double medium = 2.0;
  static const double thick = 4.0;
  static const double extraThick = 6.0;

  // Semantic Borders
  static const Border divider = Border(
    bottom: BorderSide(width: thin, color: Colors.grey),
  );

  static final Border card = Border.all(
    width: thin,
    color: Colors.grey.shade300,
  );

  static final Border inputField = Border.all(
    width: medium,
    color: Colors.grey.shade400,
  );

  static final Border button = Border.all(width: medium, color: Colors.blue);

  static final Border chip = Border.all(
    width: thin,
    color: Colors.grey.shade400,
  );

  static final Border dialog = Border.all(width: thick, color: Colors.black12);

  // Dashed / Dotted Styles (using BorderSide style)
  static final BorderSide dashed = BorderSide(
    width: medium,
    color: Colors.grey,
    style: BorderStyle.solid, // Flutter doesn’t support dashed natively
  );

  static final BorderSide dotted = BorderSide(
    width: medium,
    color: Colors.grey,
    style: BorderStyle.solid, // placeholder for custom painter
  );

  // Focus / Error States
  static final Border inputFocused = Border.all(
    width: medium,
    color: Colors.blueAccent,
  );

  static final Border inputError = Border.all(
    width: medium,
    color: Colors.redAccent,
  );

  // Accessibility Variants (thicker borders for visibility)
  static final Border accessibleDivider = Border(
    bottom: BorderSide(width: medium, color: Colors.black),
  );

  static final Border accessibleCard = Border.all(
    width: thick,
    color: Colors.black,
  );

  static final Border accessibleInputField = Border.all(
    width: thick,
    color: Colors.black,
  );

  // Utility
  static const Border none = Border();

  // Map for dynamic usage
  static const Map<String, double> widths = {
    'hairline': hairline,
    'thin': thin,
    'medium': medium,
    'thick': thick,
    'extraThick': extraThick,
  };
}

///
/// --- Usage Example ---
///
/// To use border tokens in your widgets:
///
/// ```dart
/// Container(
///   decoration: BoxDecoration(
///     border: TBorders.card,
///   ),
/// )
/// ```
///
/// This ensures consistent border widths and styles across the app.
///
