import 'package:flutter/material.dart';

/// Extension methods on [Iterable] and [List] collections for safe indexing,
/// layout widget separation, grouping, and filtering operations.
extension IterableX<T> on Iterable<T> {
  // ===========================================================================
  // 1. SAFE ELEMENT ACCESS & FILTERING
  // ===========================================================================

  /// Safely retrieves an element at [index], returning `null` if the index is out of bounds.
  /// Example: `[1, 2, 3].getOrNull(5)` -> `null`
  T? getOrNull(int index) {
    if (index < 0 || index >= length) return null;
    return elementAt(index);
  }

  /// Filters out null values from an Iterable of nullable elements.
  /// Example: `[1, null, 2].whereNotNull()` -> `[1, 2]`
  Iterable<T> whereNotNull() {
    return where((element) => element != null);
  }

  // ===========================================================================
  // 2. GROUPING & TRANSFORMATIONS
  // ===========================================================================

  /// Groups items into a [Map] based on a dynamic key extractor function.
  /// Useful for categorizing items by date, type, or status.
  ///
  /// Example:
  /// ```dart
  /// final grouped = users.groupBy((user) => user.role);
  /// ```
  Map<K, List<T>> groupBy<K>(K Function(T element) keySelector) {
    final result = <K, List<T>>{};
    for (final element in this) {
      final key = keySelector(element);
      result.putIfAbsent(key, () => []).add(element);
    }
    return result;
  }
}

/// Extension specifically for lists of Flutter [Widget]s (e.g., Column or Row children).
extension WidgetListX on List<Widget> {
  // ===========================================================================
  // 3. UI LAYOUT SEPARATION
  // ===========================================================================

  /// Automatically injects a [separator] widget (e.g., [Divider] or [SizedBox])
  /// between every item in the widget list.
  ///
  /// Example:
  /// ```dart
  /// Column(
  ///   children: [
  ///     Text('Item 1'),
  ///     Text('Item 2'),
  ///   ].separatedBy(const Divider()),
  /// )
  /// ```
  List<Widget> separatedBy(Widget separator) {
    if (length <= 1) return this;

    final result = <Widget>[];
    for (var i = 0; i < length; i++) {
      result.add(this[i]);
      if (i < length - 1) {
        result.add(separator);
      }
    }
    return result;
  }
}
