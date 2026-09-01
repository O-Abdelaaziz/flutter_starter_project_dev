/// Pure utility class for formatting, normalizing, and masking email addresses.
abstract final class EmailFormatter {
  const EmailFormatter._();

  /// Normalizes an email address by trimming whitespace and converting to lowercase.
  /// Example: ' John.Doe@Example.COM ' -> 'john.doe@example.com'
  static String normalize(String? email) {
    if (email == null || email.trim().isEmpty) return '';
    return email.trim().toLowerCase();
  }

  /// Masks an email address for privacy on settings screens or auth verification alerts.
  /// Example: maskSensitive('johndoe@gmail.com') -> 'j***e@gmail.com'
  /// Example: maskSensitive('al@domain.com') -> 'a*@domain.com'
  static String maskSensitive(String? email, {String maskChar = '*'}) {
    if (email == null || email.trim().isEmpty) return '';

    final cleanEmail = normalize(email);
    final parts = cleanEmail.split('@');

    if (parts.length != 2) return cleanEmail;

    final username = parts[0];
    final domain = parts[1];

    if (username.length <= 2) {
      return '${username[0]}$maskChar@$domain';
    }

    final firstChar = username[0];
    final lastChar = username[username.length - 1];
    final maskLength = (username.length - 2).clamp(1, 3);
    final fill = maskChar * maskLength;

    return '$firstChar$fill$lastChar@$domain';
  }

  /// Extracts the domain part of an email address.
  /// Example: extractDomain('user@company.org') -> 'company.org'
  static String extractDomain(String? email) {
    if (email == null || email.trim().isEmpty) return '';

    final parts = normalize(email).split('@');
    if (parts.length == 2) {
      return parts[1];
    }
    return '';
  }

  /// Validates whether an email string follows standard email syntax rules.
  static bool isValidEmail(String? email) {
    if (email == null || email.trim().isEmpty) return false;

    final emailRegex = RegExp(
      r'^[a-zA-Z0-9.!#$%&'
      r"'"
      r'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)+$',
    );

    return emailRegex.hasMatch(email.trim());
  }
}

// class EmailFormatter {
//   EmailFormatter._();

//   /// Normalize email (trim spaces, lowercase domain)
//   static String normalize(String email) {
//     final trimmed = email.trim();
//     final parts = trimmed.split('@');
//     if (parts.length != 2) return trimmed.toLowerCase();
//     return '${parts[0]}@${parts[1].toLowerCase()}';
//   }

//   /// Validate email (basic regex check)
//   static bool isValid(String email) {
//     final regex = RegExp(
//       r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$'
//     );
//     return regex.hasMatch(email.trim());
//   }

//   /// Mask email for privacy (e.g., jo***@gmail.com)
//   static String mask(String email) {
//     final normalized = normalize(email);
//     final parts = normalized.split('@');
//     if (parts.length != 2) return normalized;

//     final local = parts[0];
//     final domain = parts[1];

//     if (local.length <= 3) {
//       return '${local[0]}***@$domain';
//     }
//     return '${local.substring(0, 2)}***${local.substring(local.length - 1)}@$domain';
//   }

//   /// Display-friendly format (truncate long local parts)
//   static String display(String email, {int maxLocalLength = 10}) {
//     final normalized = normalize(email);
//     final parts = normalized.split('@');
//     if (parts.length != 2) return normalized;

//     final local = parts[0];
//     final domain = parts[1];

//     final truncatedLocal = local.length > maxLocalLength
//         ? '${local.substring(0, maxLocalLength)}…'
//         : local;

//     return '$truncatedLocal@$domain';
//   }
// }
