import 'package:flutter/material.dart';

import '../tokens/t_colors.dart';
import '../tokens/t_typography.dart';
import '../tokens/t_radius.dart';
import '../tokens/t_borders.dart';
import '../tokens/t_spacing.dart';

/// Input Theme (Light & Dark)
class AppInputTheme {
  AppInputTheme._();

  /// Light Theme
  static InputDecorationTheme light = InputDecorationTheme(
    filled: true,
    fillColor: TColors.surfaceLight,
    contentPadding: EdgeInsets.symmetric(
      horizontal: TSpacing.md,
      vertical: TSpacing.sm,
    ),
    hintStyle: TTypography.body2.copyWith(color: TColors.gray500),
    labelStyle: TTypography.body1.copyWith(color: TColors.gray700),
    enabledBorder: OutlineInputBorder(
      borderRadius: TRadius.inputField,
      borderSide: BorderSide(color: TColors.gray300, width: TBorders.thin),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: TRadius.inputField,
      borderSide: BorderSide(color: TColors.primary, width: TBorders.medium),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: TRadius.inputField,
      borderSide: BorderSide(color: TColors.error, width: TBorders.medium),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: TRadius.inputField,
      borderSide: BorderSide(color: TColors.errorDark, width: TBorders.medium),
    ),
  );

  /// Dark Theme
  static InputDecorationTheme dark = InputDecorationTheme(
    filled: true,
    fillColor: TColors.surfaceDark,
    contentPadding: EdgeInsets.symmetric(
      horizontal: TSpacing.md,
      vertical: TSpacing.sm,
    ),
    hintStyle: TTypography.body2.copyWith(color: TColors.gray400),
    labelStyle: TTypography.body1.copyWith(color: TColors.gray200),
    enabledBorder: OutlineInputBorder(
      borderRadius: TRadius.inputField,
      borderSide: BorderSide(color: TColors.gray600, width: TBorders.thin),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: TRadius.inputField,
      borderSide: BorderSide(
        color: TColors.darkModePrimary,
        width: TBorders.medium,
      ),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: TRadius.inputField,
      borderSide: BorderSide(color: TColors.errorLight, width: TBorders.medium),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: TRadius.inputField,
      borderSide: BorderSide(color: TColors.error, width: TBorders.medium),
    ),
  );
}
