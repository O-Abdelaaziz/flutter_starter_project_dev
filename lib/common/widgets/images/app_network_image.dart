import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../core/extensions/extensions.dart';
import '../feedback/shimmer_skeleton.dart';

/// Cached network image wrapper with automatic fallback states and loading placeholders.
class AppNetworkImage extends StatelessWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;
  final double borderRadius;
  final Widget? errorWidget;

  const AppNetworkImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius = 8.0,
    this.errorWidget,
  });

  @override
  Widget build(BuildContext context) {
    if (imageUrl.trim().isEmpty) {
      return _buildErrorState(context);
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        width: width,
        height: height,
        fit: fit,
        placeholder: (context, url) => ShimmerSkeleton(
          width: width ?? double.infinity,
          height: height ?? double.infinity,
          borderRadius: borderRadius,
        ),
        errorWidget: (context, url, error) => _buildErrorState(context),
      ),
    );
  }

  Widget _buildErrorState(BuildContext context) {
    if (errorWidget != null) return errorWidget!;

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: context.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Icon(
        Icons.broken_image_rounded,
        color: context.colorScheme.onSurfaceVariant,
        size: 24,
      ),
    );
  }
}
