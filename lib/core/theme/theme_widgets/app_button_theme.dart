import 'package:flutter/material.dart';

import '../tokens/t_colors.dart';
import '../tokens/t_typography.dart';
import '../tokens/t_radius.dart';
import '../tokens/t_spacing.dart';
import '../tokens/t_durations.dart';

/// Button Theme (Light & Dark)
class AppButtonTheme {
  AppButtonTheme._();

  /// Light Theme
  static ElevatedButtonThemeData light = ElevatedButtonThemeData(
    style: ButtonStyle(
      textStyle: WidgetStateProperty.all(TTypography.button),
      backgroundColor: WidgetStateProperty.all(TColors.primary),
      foregroundColor: WidgetStateProperty.all(TColors.onPrimary),
      padding: WidgetStateProperty.all(
        EdgeInsets.symmetric(
          horizontal: TSpacing.buttonPaddingHorizontal,
          vertical: TSpacing.buttonPaddingVertical,
        ),
      ),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(borderRadius: TRadius.button),
      ),
      elevation: WidgetStateProperty.all(2),
      animationDuration: TDurations.sm,
    ),
  );

  /// Dark Theme
  static ElevatedButtonThemeData dark = ElevatedButtonThemeData(
    style: ButtonStyle(
      textStyle: WidgetStateProperty.all(TTypography.button),
      backgroundColor: WidgetStateProperty.all(TColors.darkModePrimary),
      foregroundColor: WidgetStateProperty.all(TColors.onDarkPrimary),
      padding: WidgetStateProperty.all(
        EdgeInsets.symmetric(
          horizontal: TSpacing.buttonPaddingHorizontal,
          vertical: TSpacing.buttonPaddingVertical,
        ),
      ),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(borderRadius: TRadius.button),
      ),
      elevation: WidgetStateProperty.all(2),
      animationDuration: TDurations.sm,
    ),
  );
}
