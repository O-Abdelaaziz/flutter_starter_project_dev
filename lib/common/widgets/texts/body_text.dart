import 'package:flutter/material.dart';

import '../../../../core/extensions/extensions.dart';

enum BodySize { large, medium, small, caption }

/// Styled body text primitive mapped to Material 3 body and label styles.
class BodyText extends StatelessWidget {
  final String text;
  final BodySize size;
  final Color? color;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final FontWeight? fontWeight;

  const BodyText(
    this.text, {
    super.key,
    this.size = BodySize.medium,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    final baseStyle = _getStyle(context);

    return Text(
      text,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      style: baseStyle?.copyWith(
        color:
            color ??
            (size == BodySize.caption
                ? context.colorScheme.onSurfaceVariant
                : context.colorScheme.onSurface),
        fontWeight: fontWeight ?? baseStyle.fontWeight,
      ),
    );
  }

  TextStyle? _getStyle(BuildContext context) {
    final styles = context.textTheme;
    switch (size) {
      case BodySize.large:
        return styles.bodyLarge;
      case BodySize.medium:
        return styles.bodyMedium;
      case BodySize.small:
        return styles.bodySmall;
      case BodySize.caption:
        return styles.labelSmall;
    }
  }
}
