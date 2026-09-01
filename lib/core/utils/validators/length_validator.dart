/// Pure utility class for enforcing character count rules on text inputs.
/// Fully compatible with Flutter's [TextFormField] validator callback.
abstract final class LengthValidator {
  const LengthValidator._();

  /// Validates that a string's length falls within specified min/max bounds or matches an exact length.
  /// Example: LengthValidator.validate('Hello', min: 3, max: 10) -> null (valid)
  /// Example: LengthValidator.validate('Hi', min: 3) -> 'Must be at least 3 characters long.'
  static String? validate(
    String? value, {
    int? min,
    int? max,
    int? exact,
    String? customErrorMessage,
  }) {
    if (value == null || value.isEmpty) {
      return 'This field is required.';
    }

    final length = value.length;

    if (exact != null && length != exact) {
      return customErrorMessage ?? 'Must be exactly $exact characters long.';
    }

    if (min != null && length < min) {
      return customErrorMessage ?? 'Must be at least $min characters long.';
    }

    if (max != null && length > max) {
      return customErrorMessage ?? 'Cannot exceed $max characters.';
    }

    return null;
  }
}
