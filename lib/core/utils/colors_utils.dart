import 'dart:math';

import 'package:flutter/material.dart';

/// Pure utility class for Color manipulation, HEX parsing,
/// contrast calculations, and dynamic UI theme palette adjustments.
abstract final class ColorUtils {
  const ColorUtils._();

  // ===========================================================================
  // 1. HEX PARSING & FORMATTING
  // ===========================================================================

  /// Parses a HEX color string into a Flutter [Color] object.
  /// Handles #RGB, #ARGB, #RRGGBB, and #AARRGGBB formats.
  ///
  /// Examples:
  /// - `fromHex('#FF0000')` -> Opaque Red
  /// - `fromHex('80FF0000')` -> 50% Translucent Red
  /// - `fromHex('F00')` -> #FF0000
  static Color fromHex(
    String hexString, {
    Color fallback = Colors.transparent,
  }) {
    final cleanHex = hexString.trim().replaceAll('#', '').toUpperCase();

    try {
      if (cleanHex.length == 3) {
        // Expand shorthand #RGB to #RRGGBB
        final r = cleanHex[0] * 2;
        final g = cleanHex[1] * 2;
        final b = cleanHex[2] * 2;
        return Color(int.parse('FF$r$g$b', radix: 16));
      } else if (cleanHex.length == 6) {
        // #RRGGBB -> Add 100% opacity prefix
        return Color(int.parse('FF$cleanHex', radix: 16));
      } else if (cleanHex.length == 8) {
        // #AARRGGBB
        return Color(int.parse(cleanHex, radix: 16));
      }
    } catch (_) {
      return fallback;
    }

    return fallback;
  }

  /// Converts a [Color] object into a formatted HEX string.
  /// Example: `toHex(Colors.blue, includeAlpha: false)` -> '#2196F3'
  static String toHex(
    Color color, {
    bool includeAlpha = false,
    bool leadingHash = true,
  }) {
    final alpha = (color.a * 255)
        .round()
        .toRadixString(16)
        .padLeft(2, '0')
        .toUpperCase();
    final red = (color.r * 255)
        .round()
        .toRadixString(16)
        .padLeft(2, '0')
        .toUpperCase();
    final green = (color.g * 255)
        .round()
        .toRadixString(16)
        .padLeft(2, '0')
        .toUpperCase();
    final blue = (color.b * 255)
        .round()
        .toRadixString(16)
        .padLeft(2, '0')
        .toUpperCase();

    final prefix = leadingHash ? '#' : '';
    return includeAlpha
        ? '$prefix$alpha$red$green$blue'
        : '$prefix$red$green$blue';
  }

  // ===========================================================================
  // 2. CONTRAST & ACCESSIBILITY (WCAG 2.1)
  // ===========================================================================

  /// Calculates relative luminance of a color according to WCAG 2.1 specs (0.0 to 1.0).
  static double getLuminance(Color color) {
    return color.computeLuminance();
  }

  /// Calculates the contrast ratio between two colors (1.0 to 21.0).
  /// WCAG AA requires >= 4.5:1 for normal text, >= 3:1 for large text.
  static double calculateContrastRatio(Color foreground, Color background) {
    final l1 = getLuminance(foreground);
    final l2 = getLuminance(background);

    final lighter = max(l1, l2);
    final darker = min(l1, l2);

    return (lighter + 0.05) / (darker + 0.05);
  }

  /// Returns readable contrast text color (Black or White) for any background color.
  /// Example: `contrastingTextColor(Colors.black)` -> Colors.white
  static Color contrastingTextColor(Color backgroundColor) {
    final luminance = getLuminance(backgroundColor);
    return luminance > 0.5 ? Colors.black : Colors.white;
  }

  /// Checks if a background color is considered "dark".
  static bool isDark(Color color) {
    return getLuminance(color) < 0.5;
  }

  // ===========================================================================
  // 3. COLOR MANIPULATION & SHADES
  // ===========================================================================

  /// Darkens a color by a percentage (0.0 = unchanged, 1.0 = pitch black).
  /// Example: `darken(Colors.red, 0.2)`
  static Color darken(Color color, [double amount = 0.1]) {
    assert(
      amount >= 0.0 && amount <= 1.0,
      'Amount must be between 0.0 and 1.0',
    );
    final hsl = HSLColor.fromColor(color);
    final newLightness = (hsl.lightness - amount).clamp(0.0, 1.0);
    return hsl.withLightness(newLightness).toColor();
  }

  /// Lightens a color by a percentage (0.0 = unchanged, 1.0 = pure white).
  /// Example: `lighten(Colors.red, 0.2)`
  static Color lighten(Color color, [double amount = 0.1]) {
    assert(
      amount >= 0.0 && amount <= 1.0,
      'Amount must be between 0.0 and 1.0',
    );
    final hsl = HSLColor.fromColor(color);
    final newLightness = (hsl.lightness + amount).clamp(0.0, 1.0);
    return hsl.withLightness(newLightness).toColor();
  }

  /// Linearly interpolates (blends) between two colors by a factor [weight] (0.0 to 1.0).
  /// Example: `blend(Colors.red, Colors.blue, 0.5)` -> Purple
  static Color blend(Color color1, Color color2, double weight) {
    final clampedWeight = weight.clamp(0.0, 1.0);
    return Color.lerp(color1, color2, clampedWeight) ?? color1;
  }

  /// Returns a random opaque [Color] (ideal for default user avatars or tag backgrounds).
  static Color getRandomColor({int seed = 0}) {
    final random = seed == 0 ? Random() : Random(seed);
    return Color.fromARGB(
      255,
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
    );
  }
}
