import 'package:flutter/material.dart';

import 'device_utils.dart';

/// Standard layout breakpoints based on device logical pixel widths.
enum DeviceType {
  mobile,
  tablet,
  desktop;

  bool get isMobile => this == DeviceType.mobile;
  bool get isTablet => this == DeviceType.tablet;
  bool get isDesktop => this == DeviceType.desktop;
}

/// Utility class for responsive layout calculations, adaptive value resolution,
/// fluid typography/spacing scaling, and grid column determinations.
abstract final class ResponsiveUtils {
  const ResponsiveUtils._();

  // Reference design dimensions (Standard mobile baseline: 375x812)
  static const double _designWidth = 375.0;
  static const double _designHeight = 812.0;

  // ===========================================================================
  // 1. DEVICE CLASSIFICATION & BREAKPOINTS
  // ===========================================================================

  /// Returns the current [DeviceType] based on viewport width boundaries.
  /// - Mobile: < 600dp
  /// - Tablet: 600dp - 1024dp
  /// - Desktop: > 1024dp
  static DeviceType getDeviceType(BuildContext context) {
    final width = DeviceUtils.getScreenWidth(context);
    if (width < 600) return DeviceType.mobile;
    if (width <= 1024) return DeviceType.tablet;
    return DeviceType.desktop;
  }

  // ===========================================================================
  // 2. ADAPTIVE VALUE RESOLUTION
  // ===========================================================================

  /// Selects and returns a value based on the current screen size.
  /// [mobile] is required as the default fallback.
  ///
  /// Example:
  /// ```dart
  /// final padding = ResponsiveUtils.value(
  ///   context,
  ///   mobile: 16.0,
  ///   tablet: 24.0,
  ///   desktop: 32.0,
  /// );
  /// ```
  static T value<T>(
    BuildContext context, {
    required T mobile,
    T? tablet,
    T? desktop,
  }) {
    final deviceType = getDeviceType(context);

    switch (deviceType) {
      case DeviceType.desktop:
        return desktop ?? tablet ?? mobile;
      case DeviceType.tablet:
        return tablet ?? mobile;
      case DeviceType.mobile:
        return mobile;
    }
  }

  // ===========================================================================
  // 3. FLUID SCALING CALCULATIONS
  // ===========================================================================

  /// Scales a horizontal dimension relative to the reference design width (375dp).
  /// Useful for preserving relative component proportions across phones.
  static double scaleWidth(BuildContext context, double size) {
    final screenWidth = DeviceUtils.getScreenWidth(context);
    return (screenWidth / _designWidth) * size;
  }

  /// Scales a vertical dimension relative to the reference design height (812dp).
  static double scaleHeight(BuildContext context, double size) {
    final screenHeight = DeviceUtils.getScreenHeight(context);
    return (screenHeight / _designHeight) * size;
  }

  /// Scaled font size with min/max safety boundaries to prevent layout breakage
  /// when system font accessibility scaling is active.
  static double fontSize(
    BuildContext context,
    double size, {
    double minScale = 0.85,
    double maxScale = 1.3,
  }) {
    final scaleFactor = MediaQuery.textScalerOf(context).scale(1.0);
    final clampedScale = scaleFactor.clamp(minScale, maxScale);
    return size * clampedScale;
  }

  // ===========================================================================
  // 4. GRID & CONTAINER HELPERS
  // ===========================================================================

  /// Calculates optimal grid column counts dynamically based on available width.
  /// Example: `gridColumns(context, itemMinWidth: 180)`
  static int gridColumns(
    BuildContext context, {
    double itemMinWidth = 160.0,
    int maxColumns = 6,
  }) {
    final screenWidth = DeviceUtils.getScreenWidth(context);
    final calculatedColumns = (screenWidth / itemMinWidth).floor();
    return calculatedColumns.clamp(1, maxColumns);
  }

  /// Calculates content padding margins based on screen width to avoid full-width stretch on large screens.
  static EdgeInsets pagePadding(BuildContext context) {
    final horizontalPadding = value<double>(
      context,
      mobile: 16.0,
      tablet: 32.0,
      desktop: 64.0,
    );
    return EdgeInsets.symmetric(horizontal: horizontalPadding);
  }
}
