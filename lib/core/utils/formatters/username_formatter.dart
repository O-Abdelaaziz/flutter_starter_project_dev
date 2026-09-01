/// Pure utility class for formatting, normalizing, masking, and validating handles/usernames.
abstract final class UsernameFormatter {
  const UsernameFormatter._();

  /// List of reserved usernames that cannot be registered or used.
  static const Set<String> _reservedWords = {
    'admin',
    'administrator',
    'root',
    'system',
    'support',
    'official',
    'help',
    'null',
    'undefined',
    'superuser',
  };

  /// Normalizes a raw string into a clean username by lowercasing and stripping illegal characters.
  /// Allowed characters: lowercase letters, numbers, underscores, and hyphens.
  /// Example: ' John Doe! ' -> 'johndoe'
  /// Example: 'User#123@App' -> 'user123app'
  static String normalize(String? username) {
    if (username == null || username.trim().isEmpty) return '';

    return username
        .trim()
        .toLowerCase()
        .replaceAll(RegExp(r'\s+'), '') // Remove whitespace
        .replaceAll(RegExp(r'[^a-z0-9_-]'), ''); // Remove non-allowed chars
  }

  /// Adds an `@` prefix for social-style handle display if not already present.
  /// Example: formatHandle('johndoe') -> '@johndoe'
  /// Example: formatHandle('@johndoe') -> '@johndoe'
  static String formatHandle(String? username) {
    if (username == null || username.trim().isEmpty) return '';
    final clean = username.trim();
    return clean.startsWith('@') ? clean : '@$clean';
  }

  /// Masks a username for privacy in public UI or activity logs.
  /// Example: maskSensitive('johndoe') -> 'jo***oe'
  /// Example: maskSensitive('alex') -> 'a**x'
  /// Example: maskSensitive('ab') -> 'a*'
  static String maskSensitive(String? username, {String maskChar = '*'}) {
    if (username == null || username.isEmpty) return '';

    final clean = username.trim().replaceAll(RegExp(r'^@'), '');
    if (clean.length <= 2) {
      return '${clean[0]}$maskChar';
    }

    if (clean.length <= 4) {
      final fill = maskChar * 2;
      return '${clean[0]}$fill${clean[clean.length - 1]}';
    }

    final visiblePrefix = clean.substring(0, 2);
    final visibleSuffix = clean.substring(clean.length - 2);
    final maskLength = (clean.length - 4).clamp(1, 3);
    final fill = maskChar * maskLength;

    return '$visiblePrefix$fill$visibleSuffix';
  }

  /// Safely truncates long usernames for tight UI containers.
  /// Example: truncate('superlongusername12345', maxLength: 12) -> 'superlonguse…'
  static String truncate(String? username, {int maxLength = 15}) {
    if (username == null || username.isEmpty) return '';
    final clean = username.trim();
    if (clean.length <= maxLength) return clean;

    return '${clean.substring(0, maxLength).trim()}…';
  }

  /// Checks if a username is in the reserved system words list.
  static bool isReserved(String? username) {
    if (username == null || username.isEmpty) return false;
    final normalized = normalize(username);
    return _reservedWords.contains(normalized);
  }

  /// Validates whether a username satisfies length limits, character constraints, and reserved rules.
  static bool isValid(
    String? username, {
    int minLength = 3,
    int maxLength = 20,
  }) {
    if (username == null || username.isEmpty) return false;

    final normalized = normalize(username);
    if (normalized.length < minLength || normalized.length > maxLength) {
      return false;
    }

    if (isReserved(normalized)) {
      return false;
    }

    // Must start with an alphanumeric character (not hyphen or underscore)
    return RegExp(r'^[a-z0-9][a-z0-9_-]*$').hasMatch(normalized);
  }
}

// class UsernameFormatter {
//   UsernameFormatter._();

//   /// Normalize username (lowercase, trim spaces)
//   static String normalize(String username) {
//     return username.trim().toLowerCase();
//   }

//   /// Validate username (length + allowed chars)
//   static bool isValid(String username) {
//     final regex = RegExp(r'^[a-z0-9_]{3,20}$');
//     return regex.hasMatch(username);
//   }

//   /// Mask username for privacy
//   static String mask(String username) {
//     if (username.length <= 4) return username;
//     return username.substring(0, 2) + '***' + username.substring(username.length - 2);
//   }

//   /// Format for display (truncate + add @)
//   static String display(String username, {int maxLength = 12}) {
//     final normalized = normalize(username);
//     if (normalized.length > maxLength) {
//       return '@${normalized.substring(0, maxLength)}…';
//     }
//     return '@$normalized';
//   }
// }
