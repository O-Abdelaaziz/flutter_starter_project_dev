import 'package:flutter/material.dart';

import '../tokens/t_colors.dart';
import '../tokens/t_typography.dart';
import '../tokens/t_elevation.dart';
import '../tokens/t_icons.dart';

/// Bottom Navigation Bar Theme (Light & Dark)
class AppNavBarTheme {
  AppNavBarTheme._();

  /// Light Theme
  static BottomNavigationBarThemeData light = BottomNavigationBarThemeData(
    backgroundColor: TColors.surfaceLight,
    selectedItemColor: TColors.primary,
    unselectedItemColor: TColors.gray600,
    selectedIconTheme: IconThemeData(size: TIcons.md, color: TColors.primary),
    unselectedIconTheme: IconThemeData(size: TIcons.md, color: TColors.gray600),
    selectedLabelStyle: TTypography.caption.copyWith(color: TColors.primary),
    unselectedLabelStyle: TTypography.caption.copyWith(color: TColors.gray600),
    elevation: TElevation.navBar.toDouble(),
    type: BottomNavigationBarType.fixed,
    showUnselectedLabels: true,
  );

  /// Dark Theme
  static BottomNavigationBarThemeData dark = BottomNavigationBarThemeData(
    backgroundColor: TColors.surfaceDark,
    selectedItemColor: TColors.darkModePrimary,
    unselectedItemColor: TColors.gray400,
    selectedIconTheme: IconThemeData(
      size: TIcons.md,
      color: TColors.darkModePrimary,
    ),
    unselectedIconTheme: IconThemeData(size: TIcons.md, color: TColors.gray400),
    selectedLabelStyle: TTypography.caption.copyWith(
      color: TColors.darkModePrimary,
    ),
    unselectedLabelStyle: TTypography.caption.copyWith(color: TColors.gray400),
    elevation: TElevation.navBar.toDouble(),
    type: BottomNavigationBarType.fixed,
    showUnselectedLabels: true,
  );
}
