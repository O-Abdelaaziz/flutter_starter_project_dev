import 'package:flutter/material.dart';

import '../../../core/extensions/extensions.dart';

/// Base page wrapper providing consistent layout scaffolding, keyboard unfocusing,
/// and safe area management across all feature screens.
class AppScaffold extends StatelessWidget {
  final Widget body;
  final PreferredSizeWidget? appBar;
  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final Color? backgroundColor;
  final bool resizeToAvoidBottomInset;
  final bool useSafeArea;
  final bool isScrollable;
  final EdgeInsetsGeometry? padding;

  const AppScaffold({
    super.key,
    required this.body,
    this.appBar,
    this.bottomNavigationBar,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.backgroundColor,
    this.resizeToAvoidBottomInset = true,
    this.useSafeArea = true,
    this.isScrollable = false,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    Widget content = padding != null
        ? Padding(padding: padding!, child: body)
        : body;

    if (isScrollable) {
      content = SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: content,
      );
    }

    if (useSafeArea) {
      content = SafeArea(child: content);
    }

    return GestureDetector(
      onTap: () => context.unfocus(),
      child: Scaffold(
        appBar: appBar,
        body: content,
        bottomNavigationBar: bottomNavigationBar,
        floatingActionButton: floatingActionButton,
        floatingActionButtonLocation: floatingActionButtonLocation,
        backgroundColor: backgroundColor ?? context.colorScheme.surface,
        resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      ),
    );
  }
}
