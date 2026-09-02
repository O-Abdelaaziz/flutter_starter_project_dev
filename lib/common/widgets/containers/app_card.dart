import 'package:flutter/material.dart';

import '../../../../core/extensions/extensions.dart';

/// Standardized card shell container with elevation, borders, and touch interaction support.
class AppCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color? backgroundColor;
  final Color? borderColor;
  final double borderRadius;
  final double elevation;
  final VoidCallback? onTap;

  const AppCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16.0),
    this.margin,
    this.backgroundColor,
    this.borderColor,
    this.borderRadius = 16.0,
    this.elevation = 0.0,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveBorderColor =
        borderColor ?? context.colorScheme.outlineVariant;
    final effectiveBackgroundColor =
        backgroundColor ?? context.colorScheme.surfaceContainerLow;

    return Container(
      margin: margin,
      child: Material(
        color: effectiveBackgroundColor,
        elevation: elevation,
        shadowColor: context.colorScheme.shadow,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          side: elevation > 0
              ? BorderSide.none
              : BorderSide(color: effectiveBorderColor, width: 1.0),
        ),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Padding(padding: padding ?? EdgeInsets.zero, child: child),
        ),
      ),
    );
  }
}
