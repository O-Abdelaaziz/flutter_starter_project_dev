/// Pure utility class for validating credit card numbers, expiration dates, and CVVs.
/// Fully compatible with Flutter's [TextFormField] validator callback.
abstract final class CreditCardValidator {
  const CreditCardValidator._();

  /// Validates a credit card number using the Luhn Algorithm (Mod 10 checksum).
  /// Example: CreditCardValidator.validateCardNumber('4532015112830366') -> null (valid)
  /// Example: CreditCardValidator.validateCardNumber('1234') -> 'Invalid credit card number.'
  static String? validateCardNumber(
    String? value, {
    String? customErrorMessage,
  }) {
    if (value == null || value.trim().isEmpty) {
      return 'Card number is required.';
    }

    final digits = value.replaceAll(RegExp(r'\D'), '');

    if (digits.length < 13 || digits.length > 19) {
      return customErrorMessage ?? 'Invalid credit card number length.';
    }

    if (!_luhnCheck(digits)) {
      return customErrorMessage ?? 'Invalid credit card number.';
    }

    return null;
  }

  /// Validates an expiration date in MM/YY or MM/YYYY format.
  /// Example: CreditCardValidator.validateExpiry('12/28') -> null (valid)
  /// Example: CreditCardValidator.validateExpiry('01/20') -> 'Card has expired.'
  static String? validateExpiry(String? value, {String? customErrorMessage}) {
    if (value == null || value.trim().isEmpty) {
      return 'Expiration date is required.';
    }

    final clean = value.trim();
    final parts = clean.split('/');

    if (parts.length != 2) {
      return customErrorMessage ?? 'Use MM/YY format.';
    }

    final month = int.tryParse(parts[0]);
    var year = int.tryParse(parts[1]);

    if (month == null || month < 1 || month > 12) {
      return 'Invalid month.';
    }

    if (year == null) {
      return 'Invalid year.';
    }

    // Convert 2-digit year to 4-digit year
    if (year < 100) {
      year += 2000;
    }

    final now = DateTime.now();
    final expiryDate = DateTime(year, month + 1, 0); // Last day of expiry month

    if (expiryDate.isBefore(now)) {
      return 'Card has expired.';
    }

    return null;
  }

  /// Validates a CVC/CVV security code (3 digits for Visa/MC, 4 digits for Amex).
  static String? validateCVV(
    String? value, {
    bool isAmex = false,
    String? customErrorMessage,
  }) {
    if (value == null || value.trim().isEmpty) {
      return 'CVV is required.';
    }

    final digits = value.trim().replaceAll(RegExp(r'\D'), '');
    final requiredLength = isAmex ? 4 : 3;

    if (digits.length != requiredLength) {
      return customErrorMessage ?? 'CVV must be $requiredLength digits.';
    }

    return null;
  }

  /// Luhn Algorithm (Modulus 10) implementation.
  static bool _luhnCheck(String cardNumber) {
    int sum = 0;
    bool isAlternate = false;

    for (int i = cardNumber.length - 1; i >= 0; i--) {
      int digit = int.parse(cardNumber[i]);

      if (isAlternate) {
        digit *= 2;
        if (digit > 9) {
          digit -= 9;
        }
      }

      sum += digit;
      isAlternate = !isAlternate;
    }

    return sum % 10 == 0;
  }
}
