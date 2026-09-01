/// Pure utility class for formatting, normalizing, and masking phone numbers.
abstract final class PhoneFormatter {
  const PhoneFormatter._();

  /// Formats a raw 10-digit phone number into standard US/North American display format.
  /// Example: formatNational('1234567890') -> '(123) 456-7890'
  static String formatNational(String? phoneNumber) {
    if (phoneNumber == null || phoneNumber.isEmpty) return '';

    // Strip all non-numeric characters
    final digits = phoneNumber.replaceAll(RegExp(r'\D'), '');

    if (digits.length == 10) {
      final areaCode = digits.substring(0, 3);
      final prefix = digits.substring(3, 6);
      final line = digits.substring(6, 10);
      return '($areaCode) $prefix-$line';
    } else if (digits.length == 11 && digits.startsWith('1')) {
      final areaCode = digits.substring(1, 4);
      final prefix = digits.substring(4, 7);
      final line = digits.substring(7, 11);
      return '+1 ($areaCode) $prefix-$line';
    }

    // Fallback: return raw cleaned digits if non-standard length
    return digits;
  }

  /// Normalizes a raw phone number into standard E.164 international format (+CountryCodeNumber).
  /// Example: normalizeE164('1234567890', defaultCountryCode: '+1') -> '+11234567890'
  /// Example: normalizeE164('+213 555 123 456') -> '+213555123456'
  static String normalizeE164(
    String? phoneNumber, {
    String defaultCountryCode = '+1',
  }) {
    if (phoneNumber == null || phoneNumber.trim().isEmpty) return '';

    final clean = phoneNumber.trim();
    final hasPlus = clean.startsWith('+');
    final digits = clean.replaceAll(RegExp(r'\D'), '');

    if (hasPlus) {
      return '+$digits';
    }

    final countryCodeDigits = defaultCountryCode.replaceAll(RegExp(r'\D'), '');
    return '+$countryCodeDigits$digits';
  }

  /// Masks a phone number showing only the country code and last 4 digits for privacy.
  /// Example: maskSensitive('+1 (123) 456-7890') -> '+1 ••• ••• 7890'
  static String maskSensitive(String? phoneNumber) {
    if (phoneNumber == null || phoneNumber.isEmpty) return '';

    final digits = phoneNumber.replaceAll(RegExp(r'\D'), '');
    if (digits.length < 7) return phoneNumber;

    final visibleSuffix = digits.substring(digits.length - 4);
    final prefixLength = digits.length - 4;
    final maskedPrefix = '•' * prefixLength;

    return '$maskedPrefix$visibleSuffix';
  }
}
