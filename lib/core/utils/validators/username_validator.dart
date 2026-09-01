import '../formatters/username_formatter.dart';

/// Pure utility class for validating username form inputs.
/// Fully compatible with Flutter's [TextFormField] validator callback.
abstract final class UsernameValidator {
  const UsernameValidator._();

  /// Validates that a username meets length, character set, and availability constraints.
  /// Example: UsernameValidator.validate('john_doe') -> null (valid)
  /// Example: UsernameValidator.validate('admin') -> 'This username is reserved.'
  static String? validate(
    String? value, {
    int minLength = 3,
    int maxLength = 20,
    bool allowUnderscores = true,
    bool allowHyphens = true,
    String? customErrorMessage,
  }) {
    if (value == null || value.trim().isEmpty) {
      return 'Username is required.';
    }

    final cleanValue = value.trim();

    if (cleanValue.length < minLength) {
      return 'Username must be at least $minLength characters long.';
    }

    if (cleanValue.length > maxLength) {
      return 'Username cannot exceed $maxLength characters.';
    }

    // Check reserved system words (e.g., admin, root, support)
    if (UsernameFormatter.isReserved(cleanValue)) {
      return 'This username is reserved by the system.';
    }

    // Ensure first character is alphanumeric (not hyphen/underscore)
    if (!RegExp(r'^[a-zA-Z0-9]').hasMatch(cleanValue)) {
      return 'Username must start with a letter or number.';
    }

    // Dynamic character set validation
    final buffer = StringBuffer(r'^[a-zA-Z0-9');
    if (allowUnderscores) buffer.write(r'_');
    if (allowHyphens) buffer.write(r'-');
    buffer.write(r']+$');

    final allowedRegex = RegExp(buffer.toString());
    if (!allowedRegex.hasMatch(cleanValue)) {
      return customErrorMessage ?? 'Username contains invalid characters.';
    }

    return null;
  }
}
