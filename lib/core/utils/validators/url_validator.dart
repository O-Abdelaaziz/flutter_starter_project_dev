import '../formatters/url_formatter.dart';

/// Pure utility class for validating web URLs and links in form inputs.
/// Fully compatible with Flutter's [TextFormField] validator callback.
abstract final class UrlValidator {
  const UrlValidator._();

  /// Validates that an input string is a valid HTTP/HTTPS web address.
  /// Example: UrlValidator.validate('https://flutter.dev') -> null (valid)
  /// Example: UrlValidator.validate('not_a_url') -> 'Please enter a valid website URL.'
  static String? validate(
    String? value, {
    bool requireHttps = false,
    List<String>? allowedDomains,
    String? customErrorMessage,
  }) {
    if (value == null || value.trim().isEmpty) {
      return 'URL is required.';
    }

    final cleanUrl = value.trim();

    if (!UrlFormatter.isValidUrl(cleanUrl)) {
      return customErrorMessage ?? 'Please enter a valid website URL.';
    }

    if (requireHttps && !cleanUrl.toLowerCase().startsWith('https://')) {
      return 'URL must use secure HTTPS protocol.';
    }

    if (allowedDomains != null && allowedDomains.isNotEmpty) {
      final domain = UrlFormatter.extractDomain(cleanUrl).toLowerCase();
      final isAllowed = allowedDomains.any(
        (allowed) =>
            domain == allowed.toLowerCase() ||
            domain.endsWith('.${allowed.toLowerCase()}'),
      );

      if (!isAllowed) {
        return 'URL must belong to an allowed domain (${allowedDomains.join(', ')}).';
      }
    }

    return null;
  }
}
