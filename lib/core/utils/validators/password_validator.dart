/// Represents the calculated strength level of a password for UI strength meters.
enum PasswordStrength {
  weak,
  medium,
  strong,
  veryStrong;

  /// Human-readable label for UI display.
  String get label {
    switch (this) {
      case PasswordStrength.weak:
        return 'Weak';
      case PasswordStrength.medium:
        return 'Medium';
      case PasswordStrength.strong:
        return 'Strong';
      case PasswordStrength.veryStrong:
        return 'Very Strong';
    }
  }

  /// Score normalized between 0.0 and 1.0 for UI progress indicators.
  double get fraction {
    switch (this) {
      case PasswordStrength.weak:
        return 0.25;
      case PasswordStrength.medium:
        return 0.50;
      case PasswordStrength.strong:
        return 0.75;
      case PasswordStrength.veryStrong:
        return 1.00;
    }
  }
}

/// Pure utility class for validating password rules and calculating password strength.
abstract final class PasswordValidator {
  const PasswordValidator._();

  static final RegExp _hasUppercase = RegExp(r'[A-Z]');
  static final RegExp _hasLowercase = RegExp(r'[a-z]');
  static final RegExp _hasDigit = RegExp(r'\d');
  static final RegExp _hasSpecial = RegExp(r'[!@#$%^&*(),.?":{}|<>]');

  /// Validates a password against standard registration constraints.
  /// Returns null if valid, or a descriptive error message if invalid.
  static String? validate(
    String? value, {
    int minLength = 8,
    bool requireUppercase = true,
    bool requireLowercase = true,
    bool requireDigit = true,
    bool requireSpecialChar = true,
    String? customErrorMessage,
  }) {
    if (value == null || value.isEmpty) {
      return 'Password is required.';
    }

    if (value.length < minLength) {
      return customErrorMessage ??
          'Password must be at least $minLength characters long.';
    }

    if (requireUppercase && !_hasUppercase.hasMatch(value)) {
      return customErrorMessage ??
          'Password must contain at least one uppercase letter.';
    }

    if (requireLowercase && !_hasLowercase.hasMatch(value)) {
      return customErrorMessage ??
          'Password must contain at least one lowercase letter.';
    }

    if (requireDigit && !_hasDigit.hasMatch(value)) {
      return customErrorMessage ?? 'Password must contain at least one number.';
    }

    if (requireSpecialChar && !_hasSpecial.hasMatch(value)) {
      return customErrorMessage ??
          'Password must contain at least one special character.';
    }

    return null;
  }

  /// Calculates the strength score of a password for visual indicators (progress bars, badges).
  static PasswordStrength calculateStrength(String? password) {
    if (password == null || password.isEmpty) {
      return PasswordStrength.weak;
    }

    int score = 0;

    // Length checks
    if (password.length >= 8) score++;
    if (password.length >= 12) score++;

    // Character set checks
    if (_hasUppercase.hasMatch(password)) score++;
    if (_hasLowercase.hasMatch(password)) score++;
    if (_hasDigit.hasMatch(password)) score++;
    if (_hasSpecial.hasMatch(password)) score++;

    if (score <= 2) {
      return PasswordStrength.weak;
    } else if (score <= 4) {
      return PasswordStrength.medium;
    } else if (score == 5) {
      return PasswordStrength.strong;
    } else {
      return PasswordStrength.veryStrong;
    }
  }

  /// Validates that a confirmation password matches the original password.
  static String? validateConfirmPassword(
    String? confirmValue,
    String? originalValue, {
    String? customErrorMessage,
  }) {
    if (confirmValue == null || confirmValue.isEmpty) {
      return 'Please confirm your password.';
    }

    if (confirmValue != originalValue) {
      return customErrorMessage ?? 'Passwords do not match.';
    }

    return null;
  }
}
