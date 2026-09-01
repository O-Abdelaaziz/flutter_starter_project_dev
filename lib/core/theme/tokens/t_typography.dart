import 'package:flutter/material.dart';

/// Design Tokens: Typography
/// TTypography defines all text-related tokens used across the app.
/// Organized by font families, weights, sizes, line heights, and semantic styles.
class TTypography {
  TTypography._();

  // Font Families
  static const String fontFamilyPrimary = 'Roboto';
  static const String fontFamilySecondary = 'OpenSans';
  static const String fontFamilyMonospace = 'SourceCodePro';

  // Font Weights
  static const FontWeight weightThin = FontWeight.w100;
  static const FontWeight weightExtraLight = FontWeight.w200;
  static const FontWeight weightLight = FontWeight.w300;
  static const FontWeight weightRegular = FontWeight.w400;
  static const FontWeight weightMedium = FontWeight.w500;
  static const FontWeight weightSemiBold = FontWeight.w600;
  static const FontWeight weightBold = FontWeight.w700;
  static const FontWeight weightExtraBold = FontWeight.w800;
  static const FontWeight weightBlack = FontWeight.w900;

  // Font Sizes
  static const double sizeXs = 10.0;
  static const double sizeSm = 12.0;
  static const double sizeMd = 14.0;
  static const double sizeLg = 16.0;
  static const double sizeXl = 18.0;
  static const double size2xl = 20.0;
  static const double size3xl = 24.0;
  static const double size4xl = 28.0;
  static const double size5xl = 32.0;
  static const double size6xl = 40.0;
  static const double size7xl = 48.0;
  static const double size8xl = 56.0;
  static const double size9xl = 64.0;

  // Line Heights
  static const double lineHeightTight = 1.1;
  static const double lineHeightSnug = 1.25;
  static const double lineHeightNormal = 1.5;
  static const double lineHeightRelaxed = 1.75;
  static const double lineHeightLoose = 2.0;

  // Letter Spacing
  static const double letterSpacingTight = -0.5;
  static const double letterSpacingNormal = 0.0;
  static const double letterSpacingWide = 0.5;
  static const double letterSpacingWider = 1.0;
  static const double letterSpacingUltraWide = 2.0;

  // Semantic Styles
  static const TextStyle heading1 = TextStyle(
    fontFamily: fontFamilyPrimary,
    fontWeight: weightBold,
    fontSize: size6xl,
    height: lineHeightTight,
    letterSpacing: letterSpacingTight,
  );

  static const TextStyle heading2 = TextStyle(
    fontFamily: fontFamilyPrimary,
    fontWeight: weightBold,
    fontSize: size5xl,
    height: lineHeightSnug,
    letterSpacing: letterSpacingNormal,
  );

  static const TextStyle heading3 = TextStyle(
    fontFamily: fontFamilyPrimary,
    fontWeight: weightSemiBold,
    fontSize: size4xl,
    height: lineHeightNormal,
    letterSpacing: letterSpacingNormal,
  );

  static const TextStyle heading4 = TextStyle(
    fontFamily: fontFamilyPrimary,
    fontWeight: weightSemiBold,
    fontSize: size3xl,
    height: lineHeightNormal,
    letterSpacing: letterSpacingWide,
  );

  static const TextStyle heading5 = TextStyle(
    fontFamily: fontFamilyPrimary,
    fontWeight: weightMedium,
    fontSize: size2xl,
    height: lineHeightRelaxed,
    letterSpacing: letterSpacingNormal,
  );

  static const TextStyle heading6 = TextStyle(
    fontFamily: fontFamilyPrimary,
    fontWeight: weightMedium,
    fontSize: sizeXl,
    height: lineHeightRelaxed,
    letterSpacing: letterSpacingWide,
  );

  static const TextStyle subtitle1 = TextStyle(
    fontFamily: fontFamilySecondary,
    fontWeight: weightRegular,
    fontSize: sizeLg,
    height: lineHeightNormal,
    letterSpacing: letterSpacingNormal,
  );

  static const TextStyle subtitle2 = TextStyle(
    fontFamily: fontFamilySecondary,
    fontWeight: weightMedium,
    fontSize: sizeMd,
    height: lineHeightNormal,
    letterSpacing: letterSpacingWide,
  );

  static const TextStyle body1 = TextStyle(
    fontFamily: fontFamilySecondary,
    fontWeight: weightRegular,
    fontSize: sizeMd,
    height: lineHeightRelaxed,
    letterSpacing: letterSpacingNormal,
  );

  static const TextStyle body2 = TextStyle(
    fontFamily: fontFamilySecondary,
    fontWeight: weightRegular,
    fontSize: sizeSm,
    height: lineHeightRelaxed,
    letterSpacing: letterSpacingNormal,
  );

  static const TextStyle caption = TextStyle(
    fontFamily: fontFamilySecondary,
    fontWeight: weightLight,
    fontSize: sizeSm,
    height: lineHeightNormal,
    letterSpacing: letterSpacingWide,
  );

  static const TextStyle overline = TextStyle(
    fontFamily: fontFamilySecondary,
    fontWeight: weightMedium,
    fontSize: sizeXs,
    height: lineHeightNormal,
    letterSpacing: letterSpacingUltraWide,
  );

  static const TextStyle button = TextStyle(
    fontFamily: fontFamilyPrimary,
    fontWeight: weightSemiBold,
    fontSize: sizeMd,
    height: lineHeightSnug,
    letterSpacing: letterSpacingWide,
  );

  static const TextStyle code = TextStyle(
    fontFamily: fontFamilyMonospace,
    fontWeight: weightRegular,
    fontSize: sizeSm,
    height: lineHeightNormal,
    letterSpacing: letterSpacingNormal,
  );

  // Accessibility Variants
  static const TextStyle heading1HighContrast = TextStyle(
    fontFamily: fontFamilyPrimary,
    fontWeight: weightBlack,
    fontSize: size7xl,
    height: lineHeightTight,
    letterSpacing: letterSpacingTight,
  );

  static const TextStyle body1LargeText = TextStyle(
    fontFamily: fontFamilySecondary,
    fontWeight: weightRegular,
    fontSize: sizeLg,
    height: lineHeightLoose,
    letterSpacing: letterSpacingNormal,
  );

  static const TextStyle tooltip = TextStyle(
    color: Colors.white,
    fontSize: 14.0,
  );

  // static const TextStyle tooltipBackground = TextStyle(
  //   color: Colors.white,
  //   backgroundColor: Colors.black,
  //   fontSize: 14.0,
  // );
}

///
/// --- Usage Example ---
///
/// To use typography tokens in your widgets:
///
/// ```dart
/// Text(
///   "Hello",
///   style: TTypography.heading1,
/// )
/// ```
///
/// This ensures consistent typography across the app.
