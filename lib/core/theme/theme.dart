import 'package:flutter/material.dart';

import 'tokens/t_colors.dart';
import 'tokens/t_typography.dart';
import 'tokens/t_spacing.dart';
import 'tokens/t_shadows.dart';
import 'tokens/t_motion.dart';
import 'tokens/t_radius.dart';
import 'tokens/t_breakpoints.dart';
import 'tokens/t_opacity.dart';
import 'tokens/t_elevation.dart';
import 'tokens/t_icons.dart';
import 'tokens/t_borders.dart';
import 'tokens/t_layout.dart';
import 'tokens/t_durations.dart';
import 'tokens/t_animations.dart';

// Modular widget themes
import 'theme_widgets/app_button_theme.dart';
import 'theme_widgets/app_card_theme.dart';
import 'theme_widgets/app_input_theme.dart';
import 'theme_widgets/app_chip_theme.dart';
import 'theme_widgets/app_dialog_theme.dart';
import 'theme_widgets/app_appbar_theme.dart';
import 'theme_widgets/app_navbar_theme.dart';
import 'theme_widgets/app_snackbar_theme.dart';
import 'theme_widgets/app_tooltip_theme.dart';
import 'theme_widgets/app_listtile_theme.dart';

class AppTheme {
  AppTheme._();

  /// Light Theme
  static ThemeData light = ThemeData(
    brightness: Brightness.light,
    primaryColor: TColors.primary,
    scaffoldBackgroundColor: TColors.backgroundLight,
    textTheme: TextTheme(
      displayLarge: TTypography.heading1,
      displayMedium: TTypography.heading2,
      displaySmall: TTypography.heading3,

      headlineLarge: TTypography.heading4,
      headlineMedium: TTypography.heading5,
      headlineSmall: TTypography.heading6,

      titleLarge: TTypography.subtitle1,
      titleMedium: TTypography.subtitle2,
      titleSmall: TTypography.overline,

      bodyLarge: TTypography.body1,
      bodyMedium: TTypography.body2,
      bodySmall: TTypography.caption,

      labelLarge: TTypography.button,
      labelMedium: TTypography.tooltip,
      // labelMedium: TTypography.tooltipBackground == null
      //     ? TTypography.body2
      //     : TTypography.caption, // example fallback
      labelSmall: TTypography.overline,
    ),
    iconTheme: IconThemeData(size: TIcons.md, color: TColors.primary),
    dividerTheme: DividerThemeData(
      color: TColors.divider,
      thickness: TBorders.thin,
    ),
    cardTheme: AppCardTheme.light,
    elevatedButtonTheme: AppButtonTheme.light,
    inputDecorationTheme: AppInputTheme.light,
    chipTheme: AppChipTheme.light,
    dialogTheme: AppDialogTheme.light,
    appBarTheme: AppAppBarTheme.light,
    bottomNavigationBarTheme: AppNavBarTheme.light,
    snackBarTheme: AppSnackbarTheme.light,
    tooltipTheme: AppTooltipTheme.light,
    listTileTheme: AppListTileTheme.light,
  );

  /// Dark Theme
  static ThemeData dark = ThemeData(
    brightness: Brightness.dark,
    primaryColor: TColors.darkModePrimary,
    scaffoldBackgroundColor: TColors.backgroundDark,
    textTheme: TextTheme(
      displayLarge: TTypography.heading1HighContrast,
      bodyLarge: TTypography.body1LargeText,
      // other dark variants...
    ),
    iconTheme: IconThemeData(size: TIcons.md, color: TColors.darkModePrimary),
    dividerTheme: DividerThemeData(
      color: TColors.gray700,
      thickness: TBorders.thin,
    ),
    cardTheme: AppCardTheme.dark,
    elevatedButtonTheme: AppButtonTheme.dark,
    inputDecorationTheme: AppInputTheme.dark,
    chipTheme: AppChipTheme.dark,
    dialogTheme: AppDialogTheme.dark,
    appBarTheme: AppAppBarTheme.dark,
    bottomNavigationBarTheme: AppNavBarTheme.dark,
    snackBarTheme: AppSnackbarTheme.dark,
    tooltipTheme: AppTooltipTheme.dark,
    listTileTheme: AppListTileTheme.dark,
  );
}

///
/// --- Usage Example ---
///
/// ```dart
/// MaterialApp(
///   theme: AppTheme.light,
///   darkTheme: AppTheme.dark,
///   themeMode: ThemeMode.system,
///   home: MyHomePage(),
/// )
/// ```
///
/// This ensures consistent theming across the app.
///
