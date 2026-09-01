/// Pure utility class for validating address fields (streets, cities, postal codes).
/// Fully compatible with Flutter's [TextFormField] validator callback.
abstract final class AddressValidator {
  const AddressValidator._();

  /// Validates a street address field.
  /// Example: AddressValidator.validateStreet('123 Main St') -> null (valid)
  static String? validateStreet(
    String? value, {
    int minLength = 3,
    String? customErrorMessage,
  }) {
    if (value == null || value.trim().isEmpty) {
      return 'Street address is required.';
    }

    if (value.trim().length < minLength) {
      return customErrorMessage ??
          'Street address must be at least $minLength characters.';
    }

    return null;
  }

  /// Validates a city or region name field.
  /// Example: AddressValidator.validateCity('New York') -> null (valid)
  static String? validateCity(
    String? value, {
    int minLength = 2,
    String? customErrorMessage,
  }) {
    if (value == null || value.trim().isEmpty) {
      return 'City is required.';
    }

    final clean = value.trim();

    if (clean.length < minLength) {
      return customErrorMessage ?? 'City name is too short.';
    }

    // City names shouldn't contain numeric or special character noise
    if (!RegExp(r"^[a-zA-Z\s\-\'\,]+$").hasMatch(clean)) {
      return 'City name contains invalid characters.';
    }

    return null;
  }

  /// Validates postal or ZIP codes across common formats (e.g., 12345, 12345-6789, A1B 2C3).
  /// Example: AddressValidator.validatePostalCode('90210') -> null (valid)
  static String? validatePostalCode(
    String? value, {
    String? customErrorMessage,
  }) {
    if (value == null || value.trim().isEmpty) {
      return 'Postal code is required.';
    }

    final clean = value.trim();

    // Standard postal pattern matching alphanumeric, hyphens, and spaces (3-10 chars)
    if (!RegExp(r'^[a-zA-Z0-9\s\-]{3,10}$').hasMatch(clean)) {
      return customErrorMessage ?? 'Please enter a valid postal code.';
    }

    return null;
  }
}
