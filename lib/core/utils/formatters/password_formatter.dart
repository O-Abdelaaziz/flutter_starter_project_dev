// Or leave this logic in a separate file (validate_password.dart)
class PasswordFormatter {
  PasswordFormatter._();

  /// Normalize password (trim spaces)
  static String normalize(String password) {
    return password.trim();
  }

  /// Mask password for UI (e.g., ********)
  static String mask(String password) {
    return '*' * password.length;
  }

  /// Strength check (returns score 0–4)
  static int strengthScore(String password) {
    int score = 0;

    if (password.length >= 8) score++;
    if (RegExp(r'[A-Z]').hasMatch(password)) score++;
    if (RegExp(r'[0-9]').hasMatch(password)) score++;
    if (RegExp(r'[!@#\$%^&*(),.?":{}|<>]').hasMatch(password)) score++;

    return score;
  }

  /// Strength label (Weak, Medium, Strong)
  static String strengthLabel(String password) {
    final score = strengthScore(password);
    switch (score) {
      case 0:
      case 1:
        return 'Weak';
      case 2:
        return 'Medium';
      case 3:
      case 4:
        return 'Strong';
      default:
        return 'Unknown';
    }
  }

  /// Display-friendly format (truncate for logs/debug)
  static String display(String password, {int maxLength = 6}) {
    if (password.isEmpty) return '';
    final truncated = password.length > maxLength
        ? password.substring(0, maxLength) + '…'
        : password;
    return mask(truncated);
  }
}
