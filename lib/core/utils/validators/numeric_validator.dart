/// Pure utility class for enforcing numeric rules on text inputs.
/// Fully compatible with Flutter's [TextFormField] validator callback.
abstract final class NumericValidator {
  const NumericValidator._();

  /// Validates that an input string consists strictly of digits (0-9).
  /// Perfect for OTP codes, security PINs, or raw numeric inputs.
  ///
  /// Examples:
  /// - OTP Code: `validateDigitsOnly(value, exactLength: 6)`
  /// - Security PIN: `validateDigitsOnly(value, minLength: 4, maxLength: 6)`
  /// - Age Input: `validateDigitsOnly(value, maxLength: 3)`
  static String? validateDigitsOnly(
    String? value, {
    int? minLength,
    int? maxLength,
    int? exactLength,
    String? customErrorMessage,
  }) {
    if (value == null || value.trim().isEmpty) {
      return 'This field is required.';
    }

    final clean = value.trim();

    // Digits-only check
    if (!RegExp(r'^\d+$').hasMatch(clean)) {
      return customErrorMessage ?? 'Must contain numbers only.';
    }

    // Exact length check (e.g., 6-digit OTP or 4-digit PIN)
    if (exactLength != null && clean.length != exactLength) {
      return customErrorMessage ?? 'Must be exactly $exactLength digits.';
    }

    // Minimum length check
    if (minLength != null && clean.length < minLength) {
      return customErrorMessage ?? 'Must be at least $minLength digits.';
    }

    // Maximum length check
    if (maxLength != null && clean.length > maxLength) {
      return customErrorMessage ?? 'Cannot exceed $maxLength digits.';
    }

    return null;
  }

  /// Convenience validator specifically for One-Time Passcodes (OTP).
  /// Example: `NumericValidator.validateOTP(value, length: 6)`
  static String? validateOTP(
    String? value, {
    int length = 6,
    String? customErrorMessage,
  }) {
    return validateDigitsOnly(
      value,
      exactLength: length,
      customErrorMessage:
          customErrorMessage ?? 'Please enter a valid $length-digit OTP code.',
    );
  }

  /// Convenience validator specifically for security PINs.
  /// Example: `NumericValidator.validatePIN(value, minLength: 4, maxLength: 6)`
  static String? validatePIN(
    String? value, {
    int minLength = 4,
    int maxLength = 6,
    String? customErrorMessage,
  }) {
    return validateDigitsOnly(
      value,
      minLength: minLength,
      maxLength: maxLength,
      customErrorMessage:
          customErrorMessage ??
          'PIN must be between $minLength and $maxLength digits.',
    );
  }

  /// Validates that an input string is a valid integer (positive or negative).
  /// Example: NumericValidator.validateInteger('-42', allowNegative: true)
  static String? validateInteger(
    String? value, {
    bool allowNegative = false,
    String? customErrorMessage,
  }) {
    if (value == null || value.trim().isEmpty) {
      return 'This field is required.';
    }

    final pattern = allowNegative ? r'^-?\d+$' : r'^\d+$';
    if (!RegExp(pattern).hasMatch(value.trim())) {
      return customErrorMessage ?? 'Please enter a valid whole number.';
    }

    return null;
  }

  /// Validates that an input string is a valid decimal/double number.
  /// Example: NumericValidator.validateDecimal('12.99', maxDecimalPlaces: 2)
  static String? validateDecimal(
    String? value, {
    int? maxDecimalPlaces,
    bool allowNegative = false,
    String? customErrorMessage,
  }) {
    if (value == null || value.trim().isEmpty) {
      return 'This field is required.';
    }

    final clean = value.trim();
    final parsed = double.tryParse(clean);

    if (parsed == null) {
      return customErrorMessage ?? 'Please enter a valid decimal number.';
    }

    if (!allowNegative && parsed < 0) {
      return 'Negative values are not allowed.';
    }

    if (maxDecimalPlaces != null && clean.contains('.')) {
      final decimalPart = clean.split('.')[1];
      if (decimalPart.length > maxDecimalPlaces) {
        return 'Cannot have more than $maxDecimalPlaces decimal places.';
      }
    }

    return null;
  }
}

// /// Pure utility class for enforcing numeric rules on text inputs.
// /// Fully compatible with Flutter's [TextFormField] validator callback.
// abstract final class NumericValidator {
//   const NumericValidator._();

//   /// Validates that an input string consists strictly of digits (0-9).
//   /// Example: NumericValidator.validateDigitsOnly('12345') -> null (valid)
//   /// Example: NumericValidator.validateDigitsOnly('12.3') -> 'Must contain digits only.'
//   static String? validateDigitsOnly(
//     String? value, {
//     String? customErrorMessage,
//   }) {
//     if (value == null || value.trim().isEmpty) {
//       return 'This field is required.';
//     }

//     if (!RegExp(r'^\d+$').hasMatch(value.trim())) {
//       return customErrorMessage ?? 'Must contain digits only.';
//     }

//     return null;
//   }

//   /// Validates that an input string is a valid integer (positive or negative).
//   /// Example: NumericValidator.validateInteger('-42') -> null (valid)
//   static String? validateInteger(
//     String? value, {
//     bool allowNegative = false,
//     String? customErrorMessage,
//   }) {
//     if (value == null || value.trim().isEmpty) {
//       return 'This field is required.';
//     }

//     final pattern = allowNegative ? r'^-?\d+$' : r'^\d+$';
//     if (!RegExp(pattern).hasMatch(value.trim())) {
//       return customErrorMessage ?? 'Please enter a valid whole number.';
//     }

//     return null;
//   }

//   /// Validates that an input string is a valid decimal/double number.
//   /// Example: NumericValidator.validateDecimal('12.99', maxDecimalPlaces: 2) -> null (valid)
//   static String? validateDecimal(
//     String? value, {
//     int? maxDecimalPlaces,
//     bool allowNegative = false,
//     String? customErrorMessage,
//   }) {
//     if (value == null || value.trim().isEmpty) {
//       return 'This field is required.';
//     }

//     final clean = value.trim();
//     final parsed = double.tryParse(clean);

//     if (parsed == null) {
//       return customErrorMessage ?? 'Please enter a valid decimal number.';
//     }

//     if (!allowNegative && parsed < 0) {
//       return 'Negative values are not allowed.';
//     }

//     if (maxDecimalPlaces != null && clean.contains('.')) {
//       final decimalPart = clean.split('.')[1];
//       if (decimalPart.length > maxDecimalPlaces) {
//         return 'Cannot have more than $maxDecimalPlaces decimal places.';
//       }
//     }

//     return null;
//   }
// }
