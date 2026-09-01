import 'package:intl/intl.dart';

/// Pure utility class for formatting, normalizing, and truncating web URLs.
abstract final class UrlFormatter {
  const UrlFormatter._();

  /// Ensures a web URL string has a valid protocol prefix (`http://` or `https://`).
  /// Useful before launching links via `url_launcher`.
  /// Example: normalize('example.com') -> 'https://example.com'
  /// Example: normalize('http://example.com') -> 'http://example.com'
  static String normalize(String? url, {String defaultScheme = 'https'}) {
    if (url == null || url.trim().isEmpty) return '';

    final cleanUrl = url.trim();
    if (cleanUrl.startsWith(RegExp(r'https?://', caseSensitive: false))) {
      return cleanUrl;
    }

    return '$defaultScheme://$cleanUrl';
  }

  /// Extracts the clean host domain from a full URL for compact card displays.
  /// Example: extractDomain('https://sub.example.com/path/to/page?id=1') -> 'sub.example.com'
  static String extractDomain(String? url) {
    if (url == null || url.trim().isEmpty) return '';

    try {
      final normalized = normalize(url);
      final uri = Uri.parse(normalized);
      return uri.host.replaceFirst(RegExp(r'^www\.'), '');
    } catch (_) {
      return url.trim();
    }
  }

  /// Formats a URL for display in UI components by removing protocols and trailing slashes.
  /// Example: formatForDisplay('https://www.example.com/dashboard/') -> 'example.com/dashboard'
  static String formatForDisplay(String? url, {int? maxLength}) {
    if (url == null || url.trim().isEmpty) return '';

    var clean = url.trim();
    // Strip scheme
    clean = clean.replaceFirst(RegExp(r'^https?://', caseSensitive: false), '');
    // Strip www.
    clean = clean.replaceFirst(RegExp(r'^www\.', caseSensitive: false), '');
    // Strip trailing slash
    if (clean.endsWith('/')) {
      clean = clean.substring(0, clean.length - 1);
    }

    if (maxLength != null && clean.length > maxLength) {
      return '${clean.substring(0, maxLength).trim()}…';
    }

    return clean;
  }

  /// Validates whether a string is a syntactically valid HTTP/HTTPS web URL.
  static bool isValidUrl(String? url) {
    if (url == null || url.trim().isEmpty) return false;

    try {
      final normalized = normalize(url);
      final uri = Uri.parse(normalized);
      return uri.hasAuthority && uri.host.contains('.');
    } catch (_) {
      return false;
    }
  }
}

// /// Pure utility class for formatting and parsing URLs.
// class UrlFormatter {
//   /// Formats a URL into a standardized display format.
//   /// Example: format('https://example.com/path?param=value') -> 'example.com/path?param=value'
//   static String format(String? url) {
//     if (url == null) return '';
//     final parsedUrl = Uri.parse(url);
//     return parsedUrl.host + parsedUrl.path + parsedUrl.query;
//   }

//   /// Parses a standardized URL string back into a full URL.
//   /// Example: parse('example.com/path?param=value') -> 'https://example.com/path?param=value'
//   static String parse(String? urlString) {
//     if (urlString == null || urlString.isEmpty) return '';
//     final url = 'https://$urlString';
//     try {
//       final parsedUrl = Uri.parse(url);
//       return parsedUrl.toString();
//     } catch (e) {
//       return url;
//     }
//   }
// }

// class UrlFormatter {
//   UrlFormatter._();

//   /// Normalize URL (ensure lowercase scheme, trim spaces)
//   static String normalize(String url) {
//     final trimmed = url.trim();
//     if (!trimmed.startsWith('http://') && !trimmed.startsWith('https://')) {
//       return 'https://$trimmed'.toLowerCase();
//     }
//     return trimmed.toLowerCase();
//   }

//   /// Validate URL (basic regex check)
//   static bool isValid(String url) {
//     final regex = RegExp(
//       r'^(https?:\/\/)?' // scheme
//       r'([a-zA-Z0-9-]+\.)+[a-zA-Z]{2,}' // domain
//       r'(\/[^\s]*)?$' // optional path
//     );
//     return regex.hasMatch(url.trim());
//   }

//   /// Shorten URL for display (truncate long paths)
//   static String shorten(String url, {int maxLength = 40}) {
//     final normalized = normalize(url);
//     if (normalized.length <= maxLength) return normalized;
//     return normalized.substring(0, maxLength) + '…';
//   }

//   /// Extract domain only
//   static String domain(String url) {
//     try {
//       final uri = Uri.parse(normalize(url));
//       return uri.host;
//     } catch (_) {
//       return url;
//     }
//   }

//   /// Display-friendly format (strip scheme, truncate)
//   static String display(String url, {int maxLength = 30}) {
//     final normalized = normalize(url);
//     final stripped = normalized.replaceFirst(RegExp(r'^https?:\/\/'), '');
//     if (stripped.length <= maxLength) return stripped;
//     return stripped.substring(0, maxLength) + '…';
//   }
// }
