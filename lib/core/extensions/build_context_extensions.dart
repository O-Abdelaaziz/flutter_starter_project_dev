import 'package:flutter/material.dart';

/// Clean extension methods on [BuildContext] to streamline theme,
/// screen dimensions, navigation, focus management, and localization access.
extension BuildContextX on BuildContext {
  // ===========================================================================
  // 1. THEME & COLORS ACCESS
  // ===========================================================================

  /// Direct shortcut to [ThemeData].
  ThemeData get theme => Theme.of(this);

  /// Direct shortcut to [TextTheme].
  TextTheme get textTheme => Theme.of(this).textTheme;

  /// Direct shortcut to current active [ColorScheme].
  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  /// True if the current active theme brightness is dark.
  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;

  // ===========================================================================
  // 2. MEDIA QUERY & SCREEN DIMENSIONS (Flutter 3.7+ Performance Optimized)
  // ===========================================================================

  /// Returns total screen size in logical pixels.
  Size get screenSize => MediaQuery.sizeOf(this);

  /// Returns screen width in logical pixels.
  double get screenWidth => MediaQuery.sizeOf(this).width;

  /// Returns screen height in logical pixels.
  double get screenHeight => MediaQuery.sizeOf(this).height;

  /// Returns safe area padding (e.g., top notch, bottom gesture indicator).
  EdgeInsets get screenPadding => MediaQuery.paddingOf(this);

  /// Top status bar / notch height.
  double get statusBarHeight => MediaQuery.paddingOf(this).top;

  /// Bottom home indicator inset height.
  double get bottomSafeAreaHeight => MediaQuery.paddingOf(this).bottom;

  /// View insets (e.g., soft keyboard height).
  EdgeInsets get viewInsets => MediaQuery.viewInsetsOf(this);

  /// Height of the active soft keyboard.
  double get keyboardHeight => MediaQuery.viewInsetsOf(this).bottom;

  /// Checks if the soft keyboard is currently open on screen.
  bool get isKeyboardOpen => MediaQuery.viewInsetsOf(this).bottom > 0;

  /// Returns current device orientation.
  Orientation get orientation => MediaQuery.orientationOf(this);

  /// True if device is currently in portrait orientation.
  bool get isPortrait => MediaQuery.orientationOf(this) == Orientation.portrait;

  /// True if device is currently in landscape orientation.
  bool get isLandscape =>
      MediaQuery.orientationOf(this) == Orientation.landscape;

  // ===========================================================================
  // 3. NAVIGATION OPERATORS
  // ===========================================================================

  /// Direct shortcut to [NavigatorState].
  NavigatorState get navigator => Navigator.of(this);

  /// Pushes a new route onto the navigation stack.
  Future<T?> push<T>(Widget page) {
    return Navigator.of(this).push<T>(MaterialPageRoute(builder: (_) => page));
  }

  /// Pushes a named route onto the navigation stack.
  Future<T?> pushNamed<T>(String routeName, {Object? arguments}) {
    return Navigator.of(this).pushNamed<T>(routeName, arguments: arguments);
  }

  /// Replaces current route with a new page.
  Future<T?> pushReplacement<T, TO>(Widget page) {
    return Navigator.of(this)
        .pushReplacement<T, TO>(MaterialPageRoute(builder: (_) => page));
  }

  /// Removes all previous routes and pushes a new page at the root.
  Future<T?> pushAndRemoveUntil<T>(Widget page) {
    return Navigator.of(this).pushAndRemoveUntil<T>(
      MaterialPageRoute(builder: (_) => page),
      (route) => false,
    );
  }

  /// Pops the current route off the navigator stack.
  void pop<T>([T? result]) {
    Navigator.of(this).pop<T>(result);
  }

  // ===========================================================================
  // 4. FOCUS MANAGEMENT
  // ===========================================================================

  /// Dismisses the active soft keyboard and unfocuses current primary node.
  void unfocus() {
    final currentFocus = FocusScope.of(this);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }

  /// Shifts focus to the next available text field or node.
  void nextFocus() {
    FocusScope.of(this).nextFocus();
  }

  /// Requests focus for a specific [FocusNode].
  void requestFocus(FocusNode node) {
    FocusScope.of(this).requestFocus(node);
  }

  // ===========================================================================
  // 5. SNACKBAR CONVENIENCE HELPERS
  // ===========================================================================

  /// Shows a standard bottom SnackBar message.
  void showSnackBar(
    String message, {
    Color? backgroundColor,
    Duration duration = const Duration(seconds: 3),
    SnackBarAction? action,
  }) {
    ScaffoldMessenger.of(this).hideCurrentSnackBar();
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: backgroundColor,
        duration: duration,
        action: action,
      ),
    );
  }

  /// Shows an error SnackBar message.
  void showErrorSnackBar(String message) {
    showSnackBar(message, backgroundColor: Theme.of(this).colorScheme.error);
  }
}
