import 'package:flutter/material.dart';

import '../tokens/t_colors.dart';
import '../tokens/t_typography.dart';
import '../tokens/t_radius.dart';
import '../tokens/t_spacing.dart';
import '../tokens/t_borders.dart';

/// Chip Theme (Light & Dark)
class AppChipTheme {
  AppChipTheme._();

  /// Light Theme
  static ChipThemeData light = ChipThemeData(
    backgroundColor: TColors.gray100,
    disabledColor: TColors.disabled,
    selectedColor: TColors.primaryLight,
    secondarySelectedColor: TColors.secondaryLight,
    padding: EdgeInsets.symmetric(
      horizontal: TSpacing.sm,
      vertical: TSpacing.xs,
    ),
    labelStyle: TTypography.body2.copyWith(color: TColors.black),
    secondaryLabelStyle: TTypography.body2.copyWith(color: TColors.white),
    shape: RoundedRectangleBorder(
      borderRadius: TRadius.chip,
      side: BorderSide(color: TColors.gray300, width: TBorders.thin),
    ),
    brightness: Brightness.light,
  );

  /// Dark Theme
  static ChipThemeData dark = ChipThemeData(
    backgroundColor: TColors.gray800,
    disabledColor: TColors.gray600,
    selectedColor: TColors.darkModePrimary,
    secondarySelectedColor: TColors.darkModeSecondary,
    padding: EdgeInsets.symmetric(
      horizontal: TSpacing.sm,
      vertical: TSpacing.xs,
    ),
    labelStyle: TTypography.body2.copyWith(color: TColors.white),
    secondaryLabelStyle: TTypography.body2.copyWith(color: TColors.black),
    shape: RoundedRectangleBorder(
      borderRadius: TRadius.chip,
      side: BorderSide(color: TColors.gray700, width: TBorders.thin),
    ),
    brightness: Brightness.dark,
  );
}
