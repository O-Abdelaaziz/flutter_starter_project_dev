import 'package:flutter/material.dart';

import '../../../../core/extensions/extensions.dart';

/// Standardized icon button supporting plain and filled shell variations.
class AppIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;
  final Color? iconColor;
  final Color? backgroundColor;
  final double size;
  final double iconSize;
  final String? tooltip;
  final bool isLoading;

  const AppIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.iconColor,
    this.backgroundColor,
    this.size = 40.0,
    this.iconSize = 20.0,
    this.tooltip,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveIconColor = iconColor ?? context.colorScheme.onSurface;

    final button = Material(
      color: backgroundColor ?? Colors.transparent,
      shape: const CircleBorder(),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: isLoading ? null : onPressed,
        child: SizedBox(
          width: size,
          height: size,
          child: Center(
            child: isLoading
                ? SizedBox(
                    width: iconSize,
                    height: iconSize,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.0,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        effectiveIconColor,
                      ),
                    ),
                  )
                : Icon(icon, size: iconSize, color: effectiveIconColor),
          ),
        ),
      ),
    );

    if (tooltip != null) {
      return Tooltip(message: tooltip!, child: button);
    }

    return button;
  }
}
