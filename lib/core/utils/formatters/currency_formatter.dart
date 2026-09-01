import 'package:intl/intl.dart';

/// Pure utility class for formatting monetary values and prices.
abstract final class CurrencyFormatter {
  const CurrencyFormatter._();

  /// Formats a numeric value as currency with symbol based on locale.
  /// Example (en_US): format(1234.56) -> '$1,234.56'
  /// Example (fr_FR): format(1234.56, locale: 'fr_FR', symbol: '€') -> '1 234,56 €'
  static String format(
    num? amount, {
    String symbol = '\$',
    String locale = 'en_US',
    int decimalDigits = 2,
  }) {
    if (amount == null) return '${symbol}0.00';

    final formatter = NumberFormat.currency(
      locale: locale,
      symbol: symbol,
      decimalDigits: decimalDigits,
    );

    return formatter.format(amount);
  }

  /// Compact currency format for high numbers (dashboards, cards).
  /// Example: formatCompact(1200000) -> '$1.2M'
  /// Example: formatCompact(4500) -> '$4.5K'
  static String formatCompact(
    num? amount, {
    String symbol = '\$',
    String locale = 'en_US',
  }) {
    if (amount == null) return '${symbol}0';

    final formatter = NumberFormat.compactCurrency(
      locale: locale,
      symbol: symbol,
    );

    return formatter.format(amount);
  }

  /// Parses a formatted currency string back to a pure [double].
  /// Example: parse('$1,234.56') -> 1234.56
  static double parse(String? currencyString) {
    if (currencyString == null || currencyString.trim().isEmpty) return 0.0;

    // Strip non-numeric chars except dot and minus
    final cleanString = currencyString.replaceAll(RegExp(r'[^0-9.-]'), '');
    return double.tryParse(cleanString) ?? 0.0;
  }
}
