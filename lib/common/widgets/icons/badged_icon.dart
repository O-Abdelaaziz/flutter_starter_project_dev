import 'package:flutter/material.dart';

import '../../../../core/extensions/extensions.dart';

/// Icon wrapper displaying an unread dot or count badge in the top-right corner.
class BadgedIcon extends StatelessWidget {
  final IconData icon;
  final int badgeCount;
  final bool showBadge;
  final Color? badgeColor;
  final Color? badgeTextColor;
  final double iconSize;
  final VoidCallback? onTap;

  const BadgedIcon({
    super.key,
    required this.icon,
    this.badgeCount = 0,
    this.showBadge = true,
    this.badgeColor,
    this.badgeTextColor,
    this.iconSize = 24.0,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveBadgeColor = badgeColor ?? context.colorScheme.error;
    final effectiveTextColor = badgeTextColor ?? context.colorScheme.onError;

    final shouldDisplay = showBadge && (badgeCount > 0);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20.0),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Icon(icon, size: iconSize, color: context.colorScheme.onSurface),
          if (shouldDisplay)
            Positioned(
              top: -4,
              right: -6,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 5.0,
                  vertical: 2.0,
                ),
                decoration: BoxDecoration(
                  color: effectiveBadgeColor,
                  shape: BoxShape.circle,
                ),
                constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
                child: Center(
                  child: Text(
                    badgeCount > 99 ? '99+' : '$badgeCount',
                    style: context.textTheme.labelSmall?.copyWith(
                      color: effectiveTextColor,
                      fontSize: 9.0,
                      fontWeight: FontWeight.bold,
                      height: 1.0,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
