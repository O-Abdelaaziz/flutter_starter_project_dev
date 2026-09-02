import 'package:flutter/material.dart';

import '../../../../core/extensions/extensions.dart';

enum HeadingLevel {
  displayLarge,
  displayMedium,
  headlineLarge,
  headlineMedium,
  headlineSmall,
  titleLarge,
  titleMedium,
  titleSmall,
}

/// Styled heading text primitive mapped to Material 3 typography levels.
class HeadingText extends StatelessWidget {
  final String text;
  final HeadingLevel level;
  final Color? color;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final FontWeight? fontWeight;

  const HeadingText(
    this.text, {
    super.key,
    this.level = HeadingLevel.titleLarge,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow = TextOverflow.ellipsis,
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
        color: color ?? context.colorScheme.onSurface,
        fontWeight: fontWeight ?? baseStyle.fontWeight,
      ),
    );
  }

  TextStyle? _getStyle(BuildContext context) {
    final styles = context.textTheme;
    switch (level) {
      case HeadingLevel.displayLarge:
        return styles.displayLarge;
      case HeadingLevel.displayMedium:
        return styles.displayMedium;
      case HeadingLevel.headlineLarge:
        return styles.headlineLarge;
      case HeadingLevel.headlineMedium:
        return styles.headlineMedium;
      case HeadingLevel.headlineSmall:
        return styles.headlineSmall;
      case HeadingLevel.titleLarge:
        return styles.titleLarge;
      case HeadingLevel.titleMedium:
        return styles.titleMedium;
      case HeadingLevel.titleSmall:
        return styles.titleSmall;
    }
  }
}
