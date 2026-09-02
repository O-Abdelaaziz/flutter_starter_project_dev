import 'package:flutter/material.dart';

import '../../../../core/extensions/extensions.dart';
import '../buttons/app_icon_button.dart';

/// Standardized custom navigation header implementing [PreferredSizeWidget].
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final Widget? titleWidget;
  final bool showBackButton;
  final VoidCallback? onBackPressed;
  final Widget? leading;
  final List<Widget>? actions;
  final bool centerTitle;
  final Color? backgroundColor;
  final double elevation;
  final PreferredSizeWidget? bottom;

  const CustomAppBar({
    super.key,
    this.title,
    this.titleWidget,
    this.showBackButton = true,
    this.onBackPressed,
    this.leading,
    this.actions,
    this.centerTitle = true,
    this.backgroundColor,
    this.elevation = 0.0,
    this.bottom,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      elevation: elevation,
      backgroundColor: backgroundColor ?? context.colorScheme.surface,
      surfaceTintColor: Colors.transparent,
      centerTitle: centerTitle,
      title:
          titleWidget ??
          (title != null
              ? Text(
                  title!,
                  style: context.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: context.colorScheme.onSurface,
                  ),
                )
              : null),
      leading: _buildLeading(context),
      actions: actions,
      bottom: bottom,
    );
  }

  Widget? _buildLeading(BuildContext context) {
    if (leading != null) return leading;

    if (showBackButton && Navigator.canPop(context)) {
      return Center(
        child: AppIconButton(
          icon: Icons.arrow_back_ios_new_rounded,
          iconSize: 18.0,
          onPressed: onBackPressed ?? () => context.pop(),
        ),
      );
    }

    return null;
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(kToolbarHeight + (bottom?.preferredSize.height ?? 0.0));
}
