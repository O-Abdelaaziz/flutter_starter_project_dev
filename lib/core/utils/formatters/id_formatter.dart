/// Pure utility class for masking sensitive IDs and formatting structured codes.
abstract final class IdFormatter {
  const IdFormatter._();

  /// Masks sensitive ID numbers showing only the last [visibleTrailingDigits].
  /// Example: maskSensitive('123456789012') -> '••••••••9012'
  /// Example: maskSensitive('123456789012', maskChar: '*') -> '********9012'
  static String maskSensitive(
    String? id, {
    int visibleTrailingDigits = 4,
    String maskChar = '•',
  }) {
    if (id == null || id.isEmpty) return '';
    final cleanId = id.trim();

    if (cleanId.length <= visibleTrailingDigits) {
      return cleanId;
    }

    final maskedLength = cleanId.length - visibleTrailingDigits;
    final maskedPrefix = maskChar * maskedLength;
    final visibleSuffix = cleanId.substring(maskedLength);

    return '$maskedPrefix$visibleSuffix';
  }

  /// Groups credit card digits into standard 4-digit blocks with masking options.
  /// Example (unmasked): formatCreditCard('1234567812345678') -> '1234 5678 1234 5678'
  /// Example (masked): formatCreditCard('1234567812345678', masked: true) -> '•••• •••• •••• 5678'
  static String formatCreditCard(String? cardNumber, {bool masked = false}) {
    if (cardNumber == null || cardNumber.isEmpty) return '';

    // Remove non-digit characters
    final digits = cardNumber.replaceAll(RegExp(r'\D'), '');
    if (digits.isEmpty) return '';

    if (masked) {
      final maskedDigits = maskSensitive(
        digits,
        visibleTrailingDigits: 4,
        maskChar: '•',
      );
      return _groupDigits(maskedDigits, groupSize: 4);
    }

    return _groupDigits(digits, groupSize: 4);
  }

  /// Formats raw strings into uniform grouped code blocks (e.g., license keys, activation codes).
  /// Example: formatGroupedCode('ABCDEF123456', groupSize: 4) -> 'ABCD-EF12-3456'
  static String formatGroupedCode(
    String? code, {
    int groupSize = 4,
    String separator = '-',
  }) {
    if (code == null || code.isEmpty) return '';
    final cleanCode = code
        .replaceAll(RegExp(r'[^a-zA-Z0-9]'), '')
        .toUpperCase();

    return _groupDigits(cleanCode, groupSize: groupSize, separator: separator);
  }

  /// Helper to split string into uniform chunks with custom separators.
  static String _groupDigits(
    String input, {
    required int groupSize,
    String separator = ' ',
  }) {
    final buffer = StringBuffer();
    for (var i = 0; i < input.length; i++) {
      if (i > 0 && i % groupSize == 0) {
        buffer.write(separator);
      }
      buffer.write(input[i]);
    }
    return buffer.toString();
  }
}
