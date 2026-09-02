import 'package:flutter/material.dart';

/// Clean extension methods on numeric types ([num], [int], [double]) for UI spacing,
/// [Duration] conversions, and [EdgeInsets] wrappers.
extension NumberX on num {
  // ===========================================================================
  // 1. LAYOUT SPACERS (SizedBox)
  // ===========================================================================

  /// Creates a vertical [SizedBox] with height equal to this number.
  /// Example: `16.boxHeight` or `16.vSpace`
  SizedBox get boxHeight => SizedBox(height: toDouble());
  SizedBox get vSpace => SizedBox(height: toDouble());

  /// Creates a horizontal [SizedBox] with width equal to this number.
  /// Example: `12.boxWidth` or `12.hSpace`
  SizedBox get boxWidth => SizedBox(width: toDouble());
  SizedBox get hSpace => SizedBox(width: toDouble());

  /// Creates a square [SizedBox] with equal width and height.
  /// Example: `24.boxSquare`
  SizedBox get boxSquare => SizedBox(width: toDouble(), height: toDouble());

  // ===========================================================================
  // 2. DURATION CONVERSIONS
  // ===========================================================================

  /// Converts number into milliseconds [Duration].
  /// Example: `300.milliseconds`
  Duration get milliseconds => Duration(milliseconds: round());

  /// Converts number into seconds [Duration].
  /// Example: `3.seconds`
  Duration get seconds => Duration(seconds: round());

  /// Converts number into minutes [Duration].
  /// Example: `5.minutes`
  Duration get minutes => Duration(minutes: round());

  /// Converts number into hours [Duration].
  /// Example: `2.hours`
  Duration get hours => Duration(hours: round());

  /// Converts number into days [Duration].
  /// Example: `1.days`
  Duration get days => Duration(days: round());

  // ===========================================================================
  // 3. EDGE INSETS WRAPPERS
  // ===========================================================================

  /// Returns [EdgeInsets] with equal padding on all sides.
  /// Example: `16.paddingAll` -> `EdgeInsets.all(16.0)`
  EdgeInsets get paddingAll => EdgeInsets.all(toDouble());

  /// Returns [EdgeInsets] with symmetric horizontal padding.
  /// Example: `16.paddingHorizontal` -> `EdgeInsets.symmetric(horizontal: 16.0)`
  EdgeInsets get paddingHorizontal =>
      EdgeInsets.symmetric(horizontal: toDouble());

  /// Returns [EdgeInsets] with symmetric vertical padding.
  /// Example: `8.paddingVertical` -> `EdgeInsets.symmetric(vertical: 8.0)`
  EdgeInsets get paddingVertical => EdgeInsets.symmetric(vertical: toDouble());
}
