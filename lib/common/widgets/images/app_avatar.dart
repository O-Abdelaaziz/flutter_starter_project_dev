import 'package:flutter/material.dart';

import '../../../../core/extensions/extensions.dart';
import 'app_network_image.dart';

/// Circular avatar widget displaying a user image or fallback initials.
class AppAvatar extends StatelessWidget {
  final String? imageUrl;
  final String? name;
  final double size;
  final Color? backgroundColor;

  const AppAvatar({
    super.key,
    this.imageUrl,
    this.name,
    this.size = 40.0,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveBackgroundColor =
        backgroundColor ?? context.colorScheme.primaryContainer;
    final effectiveTextColor = context.colorScheme.onPrimaryContainer;

    if (imageUrl.isNotNullOrEmpty) {
      return ClipOval(
        child: AppNetworkImage(
          imageUrl: imageUrl!,
          width: size,
          height: size,
          borderRadius: size / 2,
          errorWidget: _buildInitialsFallback(
            effectiveBackgroundColor,
            effectiveTextColor,
            context,
          ),
        ),
      );
    }

    return _buildInitialsFallback(
      effectiveBackgroundColor,
      effectiveTextColor,
      context,
    );
  }

  Widget _buildInitialsFallback(
    Color bgColor,
    Color textColor,
    BuildContext context,
  ) {
    final initials = name.orEmpty().getInitials();

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(color: bgColor, shape: BoxShape.circle),
      alignment: Alignment.center,
      child: Text(
        initials.isEmpty ? '?' : initials,
        style: context.textTheme.labelMedium?.copyWith(
          color: textColor,
          fontWeight: FontWeight.bold,
          fontSize: size * 0.4,
        ),
      ),
    );
  }
}
