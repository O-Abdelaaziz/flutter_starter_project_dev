import 'package:flutter/material.dart';

import '../tokens/t_colors.dart';
import '../tokens/t_typography.dart';
import '../tokens/t_elevation.dart';
import '../tokens/t_spacing.dart';

/// AppBar Theme (Light & Dark)
class AppAppBarTheme {
  AppAppBarTheme._();

  /// Light Theme
  static AppBarTheme light = AppBarTheme(
    backgroundColor: TColors.surfaceLight,
    foregroundColor: TColors.onSurfaceLight,
    elevation: TElevation.appBar.toDouble(),
    titleTextStyle: TTypography.heading6.copyWith(color: TColors.black),
    toolbarTextStyle: TTypography.body1.copyWith(color: TColors.gray800),
    centerTitle: true,
    actionsIconTheme: IconThemeData(color: TColors.primary),
    iconTheme: IconThemeData(color: TColors.black),
    shadowColor: TColors.shadow,
  );

  /// Dark Theme
  static AppBarTheme dark = AppBarTheme(
    backgroundColor: TColors.surfaceDark,
    foregroundColor: TColors.onSurfaceDark,
    elevation: TElevation.appBar.toDouble(),
    titleTextStyle: TTypography.heading6.copyWith(color: TColors.white),
    toolbarTextStyle: TTypography.body1.copyWith(color: TColors.gray200),
    centerTitle: true,
    actionsIconTheme: IconThemeData(color: TColors.darkModePrimary),
    iconTheme: IconThemeData(color: TColors.white),
    shadowColor: TColors.shadow,
  );
}
