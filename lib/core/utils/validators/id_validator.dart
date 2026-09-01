/// Pure utility class for validating identification numbers, national IDs, and account codes.
/// Fully compatible with Flutter's [TextFormField] validator callback.
abstract final class IdValidator {
  const IdValidator._();

  /// Validates a generic identification number (National ID, Passport, Employee Code).
  /// Example: IdValidator.validate('1234567890', exactLength: 10) -> null (valid)
  /// Example: IdValidator.validate('ABC12', numbersOnly: true) -> 'ID must contain numbers only.'
  static String? validate(
    String? value, {
    int? minLength,
    int? maxLength,
    int? exactLength,
    bool numbersOnly = false,
    bool alphanumericOnly = true,
    String? requiredPrefix,
    String? customErrorMessage,
  }) {
    if (value == null || value.trim().isEmpty) {
      return 'Identification number is required.';
    }

    final clean = value.trim();

    // Required prefix check
    if (requiredPrefix != null && !clean.startsWith(requiredPrefix)) {
      return customErrorMessage ?? 'ID must start with "$requiredPrefix".';
    }

    // Exact length check
    if (exactLength != null && clean.length != exactLength) {
      return customErrorMessage ??
          'ID must be exactly $exactLength characters.';
    }

    // Min length check
    if (minLength != null && clean.length < minLength) {
      return customErrorMessage ?? 'ID must be at least $minLength characters.';
    }

    // Max length check
    if (maxLength != null && clean.length > maxLength) {
      return customErrorMessage ?? 'ID cannot exceed $maxLength characters.';
    }

    // Numeric check
    if (numbersOnly && !RegExp(r'^\d+$').hasMatch(clean)) {
      return customErrorMessage ?? 'ID must contain numbers only.';
    }

    // Alphanumeric check
    if (alphanumericOnly && !RegExp(r'^[a-zA-Z0-9]+$').hasMatch(clean)) {
      return customErrorMessage ?? 'ID must contain letters and numbers only.';
    }

    return null;
  }
}
