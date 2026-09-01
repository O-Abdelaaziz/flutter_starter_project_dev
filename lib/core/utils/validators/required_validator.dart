/// Pure utility class for validating non-empty form inputs.
/// Fully compatible with Flutter's [TextFormField] validator callback.
abstract final class RequiredValidator {
  const RequiredValidator._();

  /// Validates that a string value is not null, empty, or whitespace-only.
  /// Example: RequiredValidator.validate('John') -> null (valid)
  /// Example: RequiredValidator.validate('  ') -> 'This field is required.'
  static String? validate(String? value, {String? customErrorMessage}) {
    final errorMessage = customErrorMessage ?? 'This field is required.';

    if (value == null || value.trim().isEmpty) {
      return errorMessage;
    }

    return null;
  }

  /// Validates that an object (or selection like a Dropdown/Checkbox) is not null.
  /// Example: RequiredValidator.validateObject<int>(selectedId)
  static String? validateObject<T>(T? value, {String? customErrorMessage}) {
    final errorMessage = customErrorMessage ?? 'Please make a selection.';

    if (value == null) {
      return errorMessage;
    }

    return null;
  }

  /// Validates that a list or collection is not null and contains at least one element.
  /// Useful for multi-select pickers or image upload lists.
  static String? validateCollection<T>(
    Iterable<T>? collection, {
    String? customErrorMessage,
  }) {
    final errorMessage =
        customErrorMessage ?? 'Please select at least one item.';

    if (collection == null || collection.isEmpty) {
      return errorMessage;
    }

    return null;
  }
}
