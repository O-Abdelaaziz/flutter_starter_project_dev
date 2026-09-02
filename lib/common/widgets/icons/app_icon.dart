import 'package:flutter/material.dart';

import '../../../../core/extensions/extensions.dart';

/// Standardized icon component supporting plain, bordered, and background-filled styles.
class AppIcon extends StatelessWidget {
  final IconData icon;
  final double size;
  final Color? color;
  final Color? backgroundColor;
  final Color? borderColor;
  final double borderRadius;
  final EdgeInsetsGeometry padding;
  final VoidCallback? onTap;

  const AppIcon(
    this.icon, {
    super.key,
    this.size = 24.0,
    this.color,
    this.backgroundColor,
    this.borderColor,
    this.borderRadius = 8.0,
    this.padding = EdgeInsets.zero,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveColor = color ?? context.colorScheme.onSurface;

    Widget iconWidget = Padding(
      padding: padding,
      child: Icon(icon, size: size, color: effectiveColor),
    );

    if (backgroundColor != null || borderColor != null) {
      iconWidget = Container(
        padding: padding == EdgeInsets.zero
            ? const EdgeInsets.all(8.0)
            : padding,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(borderRadius),
          border: borderColor != null ? Border.all(color: borderColor!) : null,
        ),
        child: Icon(icon, size: size, color: effectiveColor),
      );
    }

    if (onTap != null) {
      return GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: iconWidget,
      );
    }

    return iconWidget;
  }
}
