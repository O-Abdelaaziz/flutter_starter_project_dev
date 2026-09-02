import 'package:flutter/material.dart';

import '../../../../core/extensions/extensions.dart';

enum SnackBarType { success, error, warning, info }

/// Utility for triggering styled floating snackbars across the app.
abstract final class AppSnackBar {
  const AppSnackBar._();

  static void show(
    BuildContext context, {
    required String message,
    SnackBarType type = SnackBarType.info,
    Duration duration = const Duration(seconds: 3),
    SnackBarAction? action,
  }) {
    final colors = context.colorScheme;

    Color backgroundColor;
    Color foregroundColor;
    IconData icon;

    switch (type) {
      case SnackBarType.success:
        backgroundColor = colors.primaryContainer;
        foregroundColor = colors.onPrimaryContainer;
        icon = Icons.check_circle_outline_rounded;
      case SnackBarType.error:
        backgroundColor = colors.errorContainer;
        foregroundColor = colors.onErrorContainer;
        icon = Icons.error_outline_rounded;
      case SnackBarType.warning:
        backgroundColor = colors.tertiaryContainer;
        foregroundColor = colors.onTertiaryContainer;
        icon = Icons.warning_amber_rounded;
      case SnackBarType.info:
        backgroundColor = colors.secondaryContainer;
        foregroundColor = colors.onSecondaryContainer;
        icon = Icons.info_outline_rounded;
    }

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(icon, color: foregroundColor, size: 20),
              12.boxWidth,
              Expanded(
                child: Text(
                  message,
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: foregroundColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          backgroundColor: backgroundColor,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          duration: duration,
          action: action,
        ),
      );
  }
}
