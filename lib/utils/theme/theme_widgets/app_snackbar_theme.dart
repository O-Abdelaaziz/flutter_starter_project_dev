import 'package:flutter/material.dart';

import '../tokens/t_colors.dart';
import '../tokens/t_typography.dart';
import '../tokens/t_radius.dart';
import '../tokens/t_elevation.dart';

/// SnackBar Theme (Light & Dark)
class AppSnackbarTheme {
  AppSnackbarTheme._();

  /// Light Theme
  static SnackBarThemeData light = SnackBarThemeData(
    backgroundColor: TColors.gray900,
    contentTextStyle: TTypography.body2.copyWith(color: TColors.white),
    actionTextColor: TColors.primary,
    elevation: TElevation.snackbar.toDouble(),
    shape: RoundedRectangleBorder(borderRadius: TRadius.snackbar),
    behavior: SnackBarBehavior.floating,
  );

  /// Dark Theme
  static SnackBarThemeData dark = SnackBarThemeData(
    backgroundColor: TColors.gray100,
    contentTextStyle: TTypography.body2.copyWith(color: TColors.black),
    actionTextColor: TColors.darkModePrimary,
    elevation: TElevation.snackbar.toDouble(),
    shape: RoundedRectangleBorder(borderRadius: TRadius.snackbar),
    behavior: SnackBarBehavior.floating,
  );
}
