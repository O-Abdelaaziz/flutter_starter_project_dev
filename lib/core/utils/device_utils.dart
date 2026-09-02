import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Pure utility class providing device hardware, screen dimension,
/// system UI, keyboard, and platform capability helpers.
abstract final class DeviceUtils {
  const DeviceUtils._();

  // ===========================================================================
  // 1. KEYBOARD & INPUT HELPERS
  // ===========================================================================

  /// Dismisses the soft keyboard if currently visible.
  static void hideKeyboard(BuildContext context) {
    final currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }

  /// Checks if the soft keyboard is currently open on screen.
  static bool isKeyboardVisible(BuildContext context) {
    return MediaQuery.viewInsetsOf(context).bottom > 0;
  }

  /// Calculates the current height of the soft keyboard in logical pixels.
  static double getKeyboardHeight(BuildContext context) {
    return MediaQuery.viewInsetsOf(context).bottom;
  }

  // ===========================================================================
  // 2. SCREEN RESOLUTION & BREAKPOINTS
  // ===========================================================================

  /// Returns total screen width in logical pixels.
  static double getScreenWidth(BuildContext context) {
    return MediaQuery.sizeOf(context).width;
  }

  /// Returns total screen height in logical pixels.
  static double getScreenHeight(BuildContext context) {
    return MediaQuery.sizeOf(context).height;
  }

  /// Returns screen pixel ratio (DPI scale factor).
  static double getPixelRatio(BuildContext context) {
    return MediaQuery.devicePixelRatioOf(context);
  }

  /// Top status bar height (inset notch padding).
  static double getStatusBarHeight(BuildContext context) {
    return MediaQuery.paddingOf(context).top;
  }

  /// Bottom safe area inset height (home indicator padding).
  static double getBottomSafeAreaHeight(BuildContext context) {
    return MediaQuery.paddingOf(context).bottom;
  }

  /// Checks if current device orientation is portrait.
  static bool isPortrait(BuildContext context) {
    return MediaQuery.orientationOf(context) == Orientation.portrait;
  }

  /// Checks if current device orientation is landscape.
  static bool isLandscape(BuildContext context) {
    return MediaQuery.orientationOf(context) == Orientation.landscape;
  }

  /// Breakpoint check: Phone screen width (< 600dp).
  static bool isMobile(BuildContext context) {
    return getScreenWidth(context) < 600;
  }

  /// Breakpoint check: Tablet screen width (600dp - 1024dp).
  static bool isTablet(BuildContext context) {
    final width = getScreenWidth(context);
    return width >= 600 && width <= 1024;
  }

  /// Breakpoint check: Desktop or large web screen width (> 1024dp).
  static bool isDesktopScreen(BuildContext context) {
    return getScreenWidth(context) > 1024;
  }

  // ===========================================================================
  // 3. SYSTEM ORIENTATION & OVERLAYS
  // ===========================================================================

  /// Locks device orientation to portrait mode only.
  static Future<void> setPortraitOnly() async {
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  /// Unlocks orientations allowing full 4-way rotation.
  static Future<void> allowAllOrientations() async {
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  /// Sets status bar style (light icons for dark background, or dark icons for light background).
  static void setSystemStatusBarStyle({required Brightness iconBrightness}) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: iconBrightness,
        statusBarBrightness: iconBrightness == Brightness.dark
            ? Brightness.light
            : Brightness.dark,
      ),
    );
  }

  // ===========================================================================
  // 4. PLATFORM & OS CHECKS
  // ===========================================================================

  /// True if running on iOS.
  static bool get isIOS => !kIsWeb && Platform.isIOS;

  /// True if running on Android.
  static bool get isAndroid => !kIsWeb && Platform.isAndroid;

  /// True if running on macOS.
  static bool get isMacOS => !kIsWeb && Platform.isMacOS;

  /// True if running on Windows.
  static bool get isWindows => !kIsWeb && Platform.isWindows;

  /// True if running on Linux.
  static bool get isLinux => !kIsWeb && Platform.isLinux;

  /// True if compiled/running on Web platform.
  static bool get isWeb => kIsWeb;

  /// True if running on mobile OS (iOS or Android).
  static bool get isMobilePlatform =>
      !kIsWeb && (Platform.isIOS || Platform.isAndroid);

  /// True if running on desktop OS (macOS, Windows, or Linux).
  static bool get isDesktopPlatform =>
      !kIsWeb && (Platform.isMacOS || Platform.isWindows || Platform.isLinux);

  // ===========================================================================
  // 5. HAPTICS & VIBRATION FEEDBACK
  // ===========================================================================

  /// Triggers a subtle haptic feedback response (ideal for button presses).
  static Future<void> lightHaptic() async {
    await HapticFeedback.lightImpact();
  }

  /// Triggers a medium haptic feedback response (ideal for selection changes).
  static Future<void> mediumHaptic() async {
    await HapticFeedback.mediumImpact();
  }

  /// Triggers a strong haptic feedback response (ideal for warnings/deletions).
  static Future<void> heavyHaptic() async {
    await HapticFeedback.heavyImpact();
  }
}
