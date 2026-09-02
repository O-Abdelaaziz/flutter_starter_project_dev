import 'package:flutter/material.dart';

import '../../../../core/extensions/extensions.dart';

/// Lightweight custom container with configurable borders, rounded corners, and gradients.
class RoundedContainer extends StatelessWidget {
  final Widget? child;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color? backgroundColor;
  final Color? borderColor;
  final double borderWidth;
  final double borderRadius;
  final Gradient? gradient;
  final List<BoxShadow>? boxShadow;
  final AlignmentGeometry? alignment;

  const RoundedContainer({
    super.key,
    this.child,
    this.width,
    this.height,
    this.padding,
    this.margin,
    this.backgroundColor,
    this.borderColor,
    this.borderWidth = 1.0,
    this.borderRadius = 12.0,
    this.gradient,
    this.boxShadow,
    this.alignment,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: padding,
      margin: margin,
      alignment: alignment,
      decoration: BoxDecoration(
        color: gradient == null
            ? (backgroundColor ?? context.colorScheme.surfaceContainer)
            : null,
        gradient: gradient,
        borderRadius: BorderRadius.circular(borderRadius),
        border: borderColor != null
            ? Border.all(color: borderColor!, width: borderWidth)
            : null,
        boxShadow: boxShadow,
      ),
      child: child,
    );
  }
}
