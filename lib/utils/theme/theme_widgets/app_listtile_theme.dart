import 'package:flutter/material.dart';

import '../tokens/t_colors.dart';
import '../tokens/t_typography.dart';
import '../tokens/t_spacing.dart';

/// ListTile Theme (Light & Dark)
class AppListTileTheme {
  AppListTileTheme._();

  /// Light Theme
  static ListTileThemeData light = ListTileThemeData(
    tileColor: TColors.surfaceLight,
    textColor: TColors.black,
    iconColor: TColors.primary,
    selectedColor: TColors.primaryDark,
    contentPadding: EdgeInsets.symmetric(
      horizontal: TSpacing.md,
      vertical: TSpacing.sm,
    ),
    dense: false,
    style: ListTileStyle.list,
  );

  /// Dark Theme
  static ListTileThemeData dark = ListTileThemeData(
    tileColor: TColors.surfaceDark,
    textColor: TColors.white,
    iconColor: TColors.darkModePrimary,
    selectedColor: TColors.darkModeSecondary,
    contentPadding: EdgeInsets.symmetric(
      horizontal: TSpacing.md,
      vertical: TSpacing.sm,
    ),
    dense: false,
    style: ListTileStyle.list,
  );
}
