import 'package:flutter/material.dart';

/// Design Tokens: Colors
/// TColors defines all color tokens used across the app.
/// Organized by semantic usage, brand, states, and utilities.
class TColors {
  TColors._();

  // Brand Palette
  static const Color primary = Color(0xFF0066FF);
  static const Color primaryLight = Color(0xFF3385FF);
  static const Color primaryDark = Color(0xFF0044AA);

  static const Color secondary = Color(0xFFFF6600);
  static const Color secondaryLight = Color(0xFFFF884D);
  static const Color secondaryDark = Color(0xFFAA4400);

  // Neutral Palette
  static const Color black = Color(0xFF000000);
  static const Color white = Color(0xFFFFFFFF);

  static const Color gray50 = Color(0xFFFAFAFA);
  static const Color gray100 = Color(0xFFF5F5F5);
  static const Color gray200 = Color(0xFFEEEEEE);
  static const Color gray300 = Color(0xFFE0E0E0);
  static const Color gray400 = Color(0xFFBDBDBD);
  static const Color gray500 = Color(0xFF9E9E9E);
  static const Color gray600 = Color(0xFF757575);
  static const Color gray700 = Color(0xFF616161);
  static const Color gray800 = Color(0xFF424242);
  static const Color gray900 = Color(0xFF212121);

  // Semantic Colors
  static const Color success = Color(0xFF4CAF50);
  static const Color successLight = Color(0xFF81C784);
  static const Color successDark = Color(0xFF2E7D32);

  static const Color warning = Color(0xFFFFC107);
  static const Color warningLight = Color(0xFFFFD54F);
  static const Color warningDark = Color(0xFFFFA000);

  static const Color error = Color(0xFFF44336);
  static const Color errorLight = Color(0xFFE57373);
  static const Color errorDark = Color(0xFFD32F2F);

  static const Color info = Color(0xFF2196F3);
  static const Color infoLight = Color(0xFF64B5F6);
  static const Color infoDark = Color(0xFF1976D2);

  // On-Colors (Text/Icon colors on top of backgrounds) ─────────────
  static const Color onPrimary = white; // text/icons on primary
  static const Color onSecondary = white; // text/icons on secondary
  static const Color onError = white; // text/icons on error
  static const Color onSuccess = white; // text/icons on success
  static const Color onWarning = black; // text/icons on warning
  static const Color onInfo = white; // text/icons on info

  static const Color onBackgroundLight = black;
  static const Color onBackgroundDark = white;

  static const Color onSurfaceLight = black;
  static const Color onSurfaceDark = white;

  // Dark mode specific
  static const Color onDarkPrimary = black; // text/icons on darkModePrimary
  static const Color onDarkSecondary = black; // text/icons on darkModeSecondary

  // Backgrounds
  static const Color backgroundLight = Color(0xFFFFFFFF);
  static const Color backgroundDark = Color(0xFF121212);

  static const Color surfaceLight = Color(0xFFFDFDFD);
  static const Color surfaceDark = Color(0xFF1E1E1E);

  // States
  static const Color hover = Color(0xFFE0E0E0);
  static const Color focus = Color(0xFFBBDEFB);
  static const Color pressed = Color(0xFF90CAF9);
  static const Color disabled = Color(0xFFBDBDBD);

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primaryLight, primary],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient secondaryGradient = LinearGradient(
    colors: [secondaryLight, secondary],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Overlay Colors
  static const Color overlayLight = Color(0x80FFFFFF); // 50% white
  static const Color overlayDark = Color(0x80000000); // 50% black

  // Accessibility Variants
  static const Color highContrastPrimary = Color(0xFF0000FF);
  static const Color highContrastSecondary = Color(0xFFFF0000);

  // Utility Colors
  static const Color transparent = Colors.transparent;
  static const Color shadow = Color(0x1F000000); // 12% black
  static const Color divider = Color(0xFFBDBDBD);

  // Brand Variants (example for multiple brands)
  static const Color brandXPrimary = Color(0xFF8E24AA);
  static const Color brandYPrimary = Color(0xFF43A047);

  // Dark Mode Adjustments
  static const Color darkModePrimary = Color(0xFF82B1FF);
  static const Color darkModeSecondary = Color(0xFFFFAB91);

  // Light Mode Adjustments
  static const Color lightModePrimary = Color(0xFF2962FF);
  static const Color lightModeSecondary = Color(0xFFFF7043);

  // Tooltip
  static const Color tooltipBackground = Colors.black;

  // ── Tone Escalation (Stark Industrial Tones) ───────────
  // Instead of playful vibrant colors, we use raw warning colors:
  static const accent = Color(0xFFFAFAFA);
  static const toneSafe = Color(0xFFA1A1AA); // Gray/Silver
  static const toneDeeper = Color(0xFFEAB308); // Raw caution yellow
  static const toneSecretive = Color(
    0xFF7C3AED,
  ); // High voltage purple (or solid sharp white)
  static const toneFreaky = Color(0xFFDC2626); // Danger red

  // ── Glow helpers ───────────────────────────────────────
  static Color glowAccent([double opacity = 0.25]) =>
      accent.withValues(alpha: opacity);

  static Color glowTone(String tone, [double opacity = 0.2]) {
    switch (tone) {
      case 'deeper':
        return toneDeeper.withValues(alpha: opacity);
      case 'secretive':
        return toneSecretive.withValues(alpha: opacity);
      case 'freaky':
        return toneFreaky.withValues(alpha: opacity);
      default:
        return toneSafe.withValues(alpha: opacity);
    }
  }

  // ── Escalation Background Tints ────────────────────────
  static Color escalationBackground(String tone) {
    switch (tone) {
      case 'deeper':
        return const Color(0xFF0A0800); // faint yellow tint
      case 'secretive':
        return const Color(0xFF070010); // faint purple tint
      case 'freaky':
        return const Color(0xFF0A0000); // very faint red tint
      default:
        return const Color(0xFF000000); // Absolute black
    }
  }
}

///
/// --- Usage Example ---
///
/// To use color tokens in your widgets:
///
/// ```dart
/// Container(
///   color: TColors.primary,
///   child: const Text("Hello"),
/// )
/// ```
///
/// This ensures consistent color usage across the app.
