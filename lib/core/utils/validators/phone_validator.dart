/// Pure utility class for validating phone number form inputs.
/// Fully compatible with Flutter's [TextFormField] validator callback.
abstract final class PhoneValidator {
  const PhoneValidator._();

  /// Validates that a string is a valid national or international phone number.
  /// Example: PhoneValidator.validate('1234567890') -> null (valid)
  /// Example: PhoneValidator.validate('123') -> 'Please enter a valid phone number.'
  static String? validate(
    String? value, {
    int minDigits = 7,
    int maxDigits = 15,
    bool requireInternationalFormat = false,
    String? customErrorMessage,
  }) {
    if (value == null || value.trim().isEmpty) {
      return 'Phone number is required.';
    }

    final cleanValue = value.trim();

    if (requireInternationalFormat && !cleanValue.startsWith('+')) {
      return 'Phone number must start with a country code (e.g., +1).';
    }

    // Strip non-digit characters to evaluate true digit length
    final digitsOnly = cleanValue.replaceAll(RegExp(r'\D'), '');

    if (digitsOnly.length < minDigits || digitsOnly.length > maxDigits) {
      return customErrorMessage ??
          'Phone number must be between $minDigits and $maxDigits digits.';
    }

    return null;
  }
}
