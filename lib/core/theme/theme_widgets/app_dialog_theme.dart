import 'package:flutter/material.dart';

import '../tokens/t_colors.dart';
import '../tokens/t_typography.dart';
import '../tokens/t_radius.dart';
import '../tokens/t_elevation.dart';
import '../tokens/t_spacing.dart';

/// Dialog Theme (Light & Dark)
class AppDialogTheme {
  AppDialogTheme._();

  /// Light Theme
  static DialogThemeData light = DialogThemeData(
    // Changed to DialogThemeData
    backgroundColor: TColors.surfaceLight,
    titleTextStyle: TTypography.heading5.copyWith(color: TColors.black),
    contentTextStyle: TTypography.body1.copyWith(color: TColors.gray800),
    shape: RoundedRectangleBorder(borderRadius: TRadius.dialog),
    elevation: TElevation.dialog.toDouble(),
    insetPadding: EdgeInsets.all(TSpacing.lg),
  );

  /// Dark Theme
  static DialogThemeData dark = DialogThemeData(
    // Changed to DialogThemeData
    backgroundColor: TColors.surfaceDark,
    titleTextStyle: TTypography.heading5.copyWith(color: TColors.white),
    contentTextStyle: TTypography.body1.copyWith(color: TColors.gray200),
    shape: RoundedRectangleBorder(borderRadius: TRadius.dialog),
    elevation: TElevation.dialog.toDouble(),
    insetPadding: EdgeInsets.all(TSpacing.lg),
  );
}
