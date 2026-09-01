import 'package:flutter/material.dart';

import '../tokens/t_colors.dart';
import '../tokens/t_radius.dart';
import '../tokens/t_shadows.dart';
import '../tokens/t_elevation.dart';
import '../tokens/t_spacing.dart';

/// Card Theme (Light & Dark)
class AppCardTheme {
  AppCardTheme._();

  /// Light Theme
  static CardThemeData light = CardThemeData(
    // Changed CardTheme to CardThemeData
    color: TColors.surfaceLight,
    shadowColor: TColors.shadow,
    elevation: TElevation.card.toDouble(),
    margin: EdgeInsets.all(TSpacing.md),
    shape: RoundedRectangleBorder(borderRadius: TRadius.card),
  );

  /// Dark Theme
  static CardThemeData dark = CardThemeData(
    // Changed CardTheme to CardThemeData
    color: TColors.surfaceDark,
    shadowColor: TColors.shadow,
    elevation: TElevation.card.toDouble(),
    margin: EdgeInsets.all(TSpacing.md),
    shape: RoundedRectangleBorder(borderRadius: TRadius.card),
  );
}
