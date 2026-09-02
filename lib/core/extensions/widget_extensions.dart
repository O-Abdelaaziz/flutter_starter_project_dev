import 'package:flutter/material.dart';

/// Clean layout extension methods on [Widget] to eliminate deeply nested boilerplate.
extension WidgetX on Widget {
  // ===========================================================================
  // 1. PADDING SHORTCUTS
  // ===========================================================================

  /// Wraps the widget with equal padding on all four sides.
  /// Example: `Text('Hello').paddingAll(16.0)`
  Widget paddingAll(double value) {
    return Padding(padding: EdgeInsets.all(value), child: this);
  }

  /// Wraps the widget with symmetric horizontal and vertical padding.
  /// Example: `Text('Hello').paddingSymmetric(horizontal: 16.0, vertical: 8.0)`
  Widget paddingSymmetric({double horizontal = 0.0, double vertical = 0.0}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical),
      child: this,
    );
  }

  /// Wraps the widget with directional padding for specific sides.
  /// Example: `Text('Hello').paddingOnly(left: 12.0, bottom: 24.0)`
  Widget paddingOnly({
    double left = 0.0,
    double top = 0.0,
    double right = 0.0,
    double bottom = 0.0,
  }) {
    return Padding(
      padding: EdgeInsets.only(
        left: left,
        top: top,
        right: right,
        bottom: bottom,
      ),
      child: this,
    );
  }

  // ===========================================================================
  // 2. LAYOUT & ALIGNMENT WRAPPERS
  // ===========================================================================

  /// Wraps the widget inside a [Center] widget.
  /// Example: `Text('Center Me').center()`
  Widget center() {
    return Center(child: this);
  }

  /// Wraps the widget inside an [Expanded] layout widget.
  /// Example: `Container().expanded(flex: 2)`
  Widget expanded({int flex = 1}) {
    return Expanded(flex: flex, child: this);
  }

  /// Wraps the widget inside a [Flexible] layout widget.
  Widget flexible({int flex = 1, FlexFit fit = FlexFit.loose}) {
    return Flexible(flex: flex, fit: fit, child: this);
  }

  /// Wraps the widget in a [SizedBox] specifying fixed dimensions.
  /// Example: `Image.network(...).sized(width: 100, height: 100)`
  Widget sized({double? width, double? height}) {
    return SizedBox(width: width, height: height, child: this);
  }

  /// Wraps the widget inside a [Card] or material paper container.
  Widget card({
    Color? color,
    double? elevation,
    EdgeInsetsGeometry? margin,
    ShapeBorder? shape,
  }) {
    return Card(
      color: color,
      elevation: elevation,
      margin: margin,
      shape: shape,
      child: this,
    );
  }

  // ===========================================================================
  // 3. CONDITIONAL VISIBILITY
  // ===========================================================================

  /// Conditionally displays the widget based on [visible].
  /// When false, returns [replacement] (defaults to [SizedBox.shrink]).
  ///
  /// Example: `Text('Secret').visible(isLoggedIn)`
  Widget visible(bool visible, {Widget replacement = const SizedBox.shrink()}) {
    return visible ? this : replacement;
  }

  // ===========================================================================
  // 4. GESTURE & INTERACTION SHORTCUTS
  // ===========================================================================

  /// Wraps the widget in a [GestureDetector] to capture tap events.
  /// Example: `Icon(Icons.star).onTap(() => print('Starred!'))`
  Widget onTap(
    VoidCallback? onTap, {
    HitTestBehavior behavior = HitTestBehavior.opaque,
  }) {
    if (onTap == null) return this;
    return GestureDetector(behavior: behavior, onTap: onTap, child: this);
  }

  /// Wraps the widget in an [InkWell] for touch feedback animations.
  Widget onInkWellTap({
    required VoidCallback? onTap,
    BorderRadius? borderRadius,
    Color? splashColor,
  }) {
    if (onTap == null) return this;
    return InkWell(
      onTap: onTap,
      borderRadius: borderRadius,
      splashColor: splashColor,
      child: this,
    );
  }
}
