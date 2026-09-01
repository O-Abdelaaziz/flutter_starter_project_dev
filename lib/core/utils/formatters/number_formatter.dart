import 'package:intl/intl.dart';

/// Pure utility class for formatting raw numbers, decimals, percentages, and metrics.
abstract final class NumberFormatter {
  const NumberFormatter._();

  /// Formats a raw number with thousands separators based on locale.
  /// Example (en_US): format(1234567) -> '1,234,567'
  /// Example (fr_FR): format(1234567, locale: 'fr_FR') -> '1 234 567'
  static String format(num? number, {String locale = 'en_US'}) {
    if (number == null) return '0';
    return NumberFormat.decimalPattern(locale).format(number);
  }

  /// Compact notation for large integers (likes, followers, view counts).
  /// Example: formatCompact(1500) -> '1.5K'
  /// Example: formatCompact(2300000) -> '2.3M'
  static String formatCompact(num? number, {String locale = 'en_US'}) {
    if (number == null) return '0';
    return NumberFormat.compact(locale: locale).format(number);
  }

  /// Formats a decimal fraction as a localized percentage string.
  /// Example: formatPercentage(0.85) -> '85%'
  /// Example: formatPercentage(0.1234, decimalDigits: 1) -> '12.3%'
  static String formatPercentage(
    num? value, {
    int decimalDigits = 0,
    String locale = 'en_US',
  }) {
    if (value == null) return '0%';

    final formatter = NumberFormat.percentPattern(locale)
      ..maximumFractionDigits = decimalDigits
      ..minimumFractionDigits = decimalDigits;

    return formatter.format(value);
  }

  /// Rounds a double to a fixed number of decimal places without trailing zero bloat.
  /// Example: formatDecimal(12.3456, decimalDigits: 2) -> '12.35'
  /// Example: formatDecimal(12.00, decimalDigits: 2) -> '12'
  static String formatDecimal(
    num? number, {
    int decimalDigits = 2,
    String locale = 'en_US',
  }) {
    if (number == null) return '0';

    final formatter = NumberFormat.subsequentDigits(locale)
      ..maximumFractionDigits = decimalDigits;

    return formatter.format(number);
  }
}
