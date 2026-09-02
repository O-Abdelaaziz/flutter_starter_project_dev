import 'dart:async';
import 'dart:convert';
import 'dart:math';

/// Pure Dart utility class for data manipulations, safe parsing,
/// collection transformations, and execution control algorithms.
abstract final class HelperFunctions {
  const HelperFunctions._();

  // ===========================================================================
  // 1. SAFE TYPE PARSING & CONVERSION
  // ===========================================================================

  /// Safely parses an untyped value to an [int] with a fallback default.
  /// Example: safeParseInt('42') -> 42
  /// Example: safeParseInt('invalid', defaultValue: 0) -> 0
  static int safeParseInt(dynamic value, {int defaultValue = 0}) {
    if (value == null) return defaultValue;
    if (value is int) return value;
    if (value is double) return value.toInt();
    if (value is String) {
      return int.tryParse(value.trim()) ?? defaultValue;
    }
    return defaultValue;
  }

  /// Safely parses an untyped value to a [double] with a fallback default.
  /// Example: safeParseDouble('12.34') -> 12.34
  static double safeParseDouble(dynamic value, {double defaultValue = 0.0}) {
    if (value == null) return defaultValue;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) {
      return double.tryParse(value.trim()) ?? defaultValue;
    }
    return defaultValue;
  }

  /// Safely converts dynamic primitives/JSON values into a [bool].
  /// Recognizes: true, 'true', 1, '1', 'yes' as true.
  /// Example: safeParseBool('TRUE') -> true
  /// Example: safeParseBool(0) -> false
  static bool safeParseBool(dynamic value, {bool defaultValue = false}) {
    if (value == null) return defaultValue;
    if (value is bool) return value;
    if (value is num) return value == 1;
    if (value is String) {
      final normalized = value.trim().toLowerCase();
      if (normalized == 'true' || normalized == '1' || normalized == 'yes') {
        return true;
      }
      if (normalized == 'false' || normalized == '0' || normalized == 'no') {
        return false;
      }
    }
    return defaultValue;
  }

  // ===========================================================================
  // 2. COLLECTION TRANSFORMATIONS & SEARCHING
  // ===========================================================================

  /// Splits a list into smaller chunks/batches of a fixed size.
  /// Example: chunkList([1, 2, 3, 4, 5], 2) -> [[1, 2], [3, 4], [5]]
  static List<List<T>> chunkList<T>(List<T> list, int chunkSize) {
    if (list.isEmpty || chunkSize <= 0) return [];
    final chunks = <List<T>>[];
    for (var i = 0; i < list.length; i += chunkSize) {
      final end = (i + chunkSize < list.length) ? i + chunkSize : list.length;
      chunks.add(list.sublist(i, end));
    }
    return chunks;
  }

  /// Groups list elements by a key extractor function into a Map.
  /// Example: groupBy(['apple', 'banana', 'avocado'], (s) => s[0])
  ///          -> {'a': ['apple', 'avocado'], 'b': ['banana']}
  static Map<K, List<T>> groupBy<T, K>(
    Iterable<T> values,
    K Function(T item) keyExtractor,
  ) {
    final map = <K, List<T>>{};
    for (final element in values) {
      final key = keyExtractor(element);
      map.putIfAbsent(key, () => []).add(element);
    }
    return map;
  }

  /// Returns a new list containing only unique elements determined by a key function.
  /// Example: distinctBy(users, (user) => user.id)
  static List<T> distinctBy<T, K>(
    Iterable<T> list,
    K Function(T element) keySelector,
  ) {
    final seen = <K>{};
    final result = <T>[];
    for (final element in list) {
      if (seen.add(keySelector(element))) {
        result.add(element);
      }
    }
    return result;
  }

  // ===========================================================================
  // 3. EXECUTION CONTROL (DEBOUNCE, THROTTLE, RETRY)
  // ===========================================================================

  /// Debounces a function call, executing it only after [duration] has elapsed
  /// without any new calls (ideal for search inputs).
  static Function(T) debounce<T>(
    void Function(T value) action, {
    Duration duration = const Duration(milliseconds: 300),
  }) {
    Timer? timer;
    return (T value) {
      timer?.cancel();
      timer = Timer(duration, () => action(value));
    };
  }

  /// Throttles a function call, ensuring it is executed at most once per [duration]
  /// (ideal for scroll listeners or rapid button clicks).
  static Function(T) throttle<T>(
    void Function(T value) action, {
    Duration duration = const Duration(milliseconds: 300),
  }) {
    bool isThrottled = false;
    return (T value) {
      if (!isThrottled) {
        action(value);
        isThrottled = true;
        Timer(duration, () => isThrottled = false);
      }
    };
  }

  /// Retries an asynchronous task [maxAttempts] times with exponential backoff.
  static Future<T> retryTask<T>(
    Future<T> Function() task, {
    int maxAttempts = 3,
    Duration initialDelay = const Duration(milliseconds: 500),
  }) async {
    int attempts = 0;
    Duration currentDelay = initialDelay;

    while (true) {
      try {
        attempts++;
        return await task();
      } catch (e) {
        if (attempts >= maxAttempts) rethrow;
        await Future.delayed(currentDelay);
        currentDelay *= 2; // Exponential backoff
      }
    }
  }

  // ===========================================================================
  // 4. EQUALITY, CLAMPING & GENERATORS
  // ===========================================================================

  /// Performs a structural deep equality check on primitive values, Lists, and Maps.
  static bool deepEquals(dynamic a, dynamic b) {
    if (identical(a, b)) return true;
    if (a is List && b is List) {
      if (a.length != b.length) return false;
      for (var i = 0; i < a.length; i++) {
        if (!deepEquals(a[i], b[i])) return false;
      }
      return true;
    }
    if (a is Map && b is Map) {
      if (a.length != b.length) return false;
      for (final key in a.keys) {
        if (!b.containsKey(key) || !deepEquals(a[key], b[key])) return false;
      }
      return true;
    }
    return a == b;
  }

  /// Restricts a num value between a minimum and maximum bound.
  /// Example: clamp(15, min: 0, max: 10) -> 10
  static T clamp<T extends num>(T value, {required T min, required T max}) {
    if (value < min) return min;
    if (value > max) return max;
    return value;
  }

  /// Generates a random cryptographically non-secure alphanumeric string.
  /// Useful for temporary local IDs or form keys.
  static String generateRandomString({int length = 16}) {
    const chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    final random = Random();
    return List.generate(
      length,
      (index) => chars[random.nextInt(chars.length)],
    ).join();
  }
}
