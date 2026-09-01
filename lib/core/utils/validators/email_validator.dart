import '../formatters/email_formatter.dart';

/// Pure utility class for validating email form inputs.
/// Fully compatible with Flutter's [TextFormField] validator callback.
abstract final class EmailValidator {
  const EmailValidator._();

  /// Validates that a string is a properly formatted email address.
  /// Option to enforce specific allowed domains (e.g., ['company.com']).
  /// Example: EmailValidator.validate('user@gmail.com') -> null (valid)
  /// Example: EmailValidator.validate('user@invalid') -> 'Please enter a valid email address.'
  static String? validate(
    String? value, {
    List<String>? allowedDomains,
    String? customErrorMessage,
  }) {
    if (value == null || value.trim().isEmpty) {
      return 'Email address is required.';
    }

    final cleanEmail = value.trim();

    if (!EmailFormatter.isValidEmail(cleanEmail)) {
      return customErrorMessage ?? 'Please enter a valid email address.';
    }

    if (allowedDomains != null && allowedDomains.isNotEmpty) {
      final domain = EmailFormatter.extractDomain(cleanEmail);
      final isAllowed = allowedDomains.any(
        (allowed) => allowed.toLowerCase() == domain.toLowerCase(),
      );

      if (!isAllowed) {
        return 'Email must belong to an authorized domain (${allowedDomains.join(', ')}).';
      }
    }

    return null;
  }
}
