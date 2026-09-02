import 'package:flutter/material.dart';

/// Layout wrapper that centers content and enforces a maximum width constraint
/// to maintain clean readability on desktop and tablet viewports.
class CenteredConstrainedBody extends StatelessWidget {
  final Widget child;
  final double maxWidth;
  final AlignmentGeometry alignment;
  final EdgeInsetsGeometry? padding;

  const CenteredConstrainedBody({
    super.key,
    required this.child,
    this.maxWidth = 600.0,
    this.alignment = Alignment.topCenter,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: Container(
        constraints: BoxConstraints(maxWidth: maxWidth),
        padding: padding,
        child: child,
      ),
    );
  }
}
