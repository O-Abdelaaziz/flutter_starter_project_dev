/// Pure utility class for validating numeric quantities, measurements, and value ranges.
/// Fully compatible with Flutter's [TextFormField] validator callback.
abstract final class UnitValidator {
  const UnitValidator._();

  /// Validates that a numeric input falls within specified minimum and maximum bounds.
  /// Example: UnitValidator.validateRange('25', min: 18, max: 65) -> null (valid)
  /// Example: UnitValidator.validateRange('15', min: 18) -> 'Value must be at least 18.'
  static String? validateRange(
    String? value, {
    num? min,
    num? max,
    String? unitLabel,
    String? customErrorMessage,
  }) {
    if (value == null || value.trim().isEmpty) {
      return 'This field is required.';
    }

    final parsedNumber = num.tryParse(value.trim());
    if (parsedNumber == null) {
      return 'Please enter a valid number.';
    }

    final label = unitLabel != null ? ' $unitLabel' : '';

    if (min != null && parsedNumber < min) {
      return customErrorMessage ?? 'Value must be at least $min$label.';
    }

    if (max != null && parsedNumber > max) {
      return customErrorMessage ?? 'Value cannot exceed $max$label.';
    }

    return null;
  }

  /// Validates that an input value is strictly positive (> 0).
  /// Useful for price, weight, height, or inventory quantity fields.
  static String? validatePositive(String? value, {String? customErrorMessage}) {
    if (value == null || value.trim().isEmpty) {
      return 'This field is required.';
    }

    final parsedNumber = num.tryParse(value.trim());
    if (parsedNumber == null) {
      return 'Please enter a valid number.';
    }

    if (parsedNumber <= 0) {
      return customErrorMessage ?? 'Value must be greater than zero.';
    }

    return null;
  }
}
