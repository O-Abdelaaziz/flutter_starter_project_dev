import 'package:flutter/material.dart';

import '../tokens/t_typography.dart';
import '../tokens/t_colors.dart';
import '../tokens/t_radius.dart';
import '../tokens/t_opacity.dart';

/// Tooltip Theme (Light & Dark)
class AppTooltipTheme {
  AppTooltipTheme._();

  /// Light Theme
  static TooltipThemeData light = TooltipThemeData(
    textStyle: TTypography.tooltip,
    decoration: BoxDecoration(
      color: TColors.tooltipBackground.withValues(
        alpha: TOpacity.tooltipBackground,
      ),
      borderRadius: TRadius.tooltip,
    ),
    waitDuration: const Duration(milliseconds: 300),
    showDuration: const Duration(seconds: 2),
    preferBelow: true,
  );

  /// Dark Theme
  static TooltipThemeData dark = TooltipThemeData(
    textStyle: TTypography.tooltip.copyWith(color: Colors.black),
    decoration: BoxDecoration(
      color: TColors.tooltipBackground.withValues(
        alpha: TOpacity.tooltipBackground,
      ),
      borderRadius: TRadius.tooltip,
    ),
    waitDuration: const Duration(milliseconds: 300),
    showDuration: const Duration(seconds: 2),
    preferBelow: true,
  );
}
