import 'package:flutter_starter_project_dev/core/utils/formatters/string_extensions.dart';

/// Expressive extension methods on [String] for casing transformations,
/// safe parsing, initial extraction, and localization markup.
extension StringX on String {
  // ===========================================================================
  // 1. TEXT CASING & FORMATTING
  // ===========================================================================

  /// Capitalizes the first letter of the string.
  /// Example: `'hello'.toCapitalized()` -> `'Hello'`
  String toCapitalized() => StringFormatter.capitalize(this);

  /// Converts the string to Title Case (capitalizes every word).
  /// Example: `'john doe'.toTitleCase()` -> `'John Doe'`
  String toTitleCase() => StringFormatter.toTitleCase(this);

  /// Capitalizes the first letter of each sentence.
  /// Example: `'hello world. how are you?'` -> `'Hello world. How are you?'`
  String toSentenceCase() => StringFormatter.toSentenceCase(this);

  // ===========================================================================
  // 2. INITIALS EXTRACTION & AVATAR HELPERS
  // ===========================================================================

  /// Extracts user initials (up to 2 characters) for default profile avatars.
  /// Example: `'John Doe'.getInitials()` -> `'JD'`
  /// Example: `'Jane'.getInitials()` -> `'JA'`
  String getInitials({int limit = 2}) {
    final clean = trim();
    if (clean.isEmpty) return '';

    final parts = clean.split(RegExp(r'\s+'));
    if (parts.length >= limit) {
      return parts
          .take(limit)
          .map((part) => part.isNotEmpty ? part[0].toUpperCase() : '')
          .join();
    } else if (parts.first.length >= limit) {
      return parts.first.substring(0, limit).toUpperCase();
    }
    return parts.first.toUpperCase();
  }

  // ===========================================================================
  // 3. SAFE NUMERIC PARSING
  // ===========================================================================

  /// Safely parses a string into an [int], returning [fallback] or `null` on failure.
  /// Example: `'123'.toInt()` -> `123`
  /// Example: `'abc'.toInt(fallback: 0)` -> `0`
  int? toInt({int? fallback}) {
    return int.tryParse(trim()) ?? fallback;
  }

  /// Safely parses a string into a [double], returning [fallback] or `null` on failure.
  /// Example: `'12.34'.toDouble()` -> `12.34`
  double? toDouble({double? fallback}) {
    return double.tryParse(trim()) ?? fallback;
  }

  /// True if the string consists strictly of numeric digits.
  bool get isNumeric => RegExp(r'^\d+$').hasMatch(trim());

  // ===========================================================================
  // 4. DEVELOPMENT & LOCALIZATION MARKUP
  // ===========================================================================

  /// Development flag used to identify hardcoded UI strings that require i18n/l10n localization.
  /// Example: `Text('Welcome'.hardcoded)`
  String get hardcoded => this;
}

/// Nullable String extension methods for safe fallback evaluations.
extension NullableStringX on String? {
  /// True if string is `null` or empty.
  bool get isNullOrEmpty => this == null || this!.trim().isEmpty;

  /// True if string is not `null` and contains characters.
  bool get isNotNullOrEmpty => !isNullOrEmpty;

  /// Returns the string value if non-empty, otherwise returns [fallback].
  String orEmpty([String fallback = '']) {
    return isNotNullOrEmpty ? this! : fallback;
  }
}
