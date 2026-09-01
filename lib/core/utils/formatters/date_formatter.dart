import 'package:intl/intl.dart';

/// Pure utility class for formatting dates, timestamps, and relative time representations.
abstract final class DateFormatter {
  const DateFormatter._();

  /// Formats a [DateTime] or ISO-8601 string into a standard display date.
  /// Example: format(DateTime.now()) -> 'Jan 15, 2026'
  /// Example: format(date, pattern: 'dd/MM/yyyy') -> '15/01/2026'
  static String format(
    dynamic date, {
    String pattern = 'MMM dd, yyyy',
    String locale = 'en_US',
  }) {
    final parsedDate = _parseDate(date);
    if (parsedDate == null) return '';

    return DateFormat(pattern, locale).format(parsedDate);
  }

  /// Formats a date into time only.
  /// Example: formatTime(DateTime.now()) -> '02:30 PM'
  static String formatTime(
    dynamic date, {
    bool use24Hour = false,
    String locale = 'en_US',
  }) {
    final parsedDate = _parseDate(date);
    if (parsedDate == null) return '';

    final pattern = use24Hour ? 'HH:mm' : 'hh:mm a';
    return DateFormat(pattern, locale).format(parsedDate);
  }

  /// Converts a date into a human-readable "time ago" string.
  /// Example: formatRelative(twoMinutesAgo) -> '2 minutes ago'
  /// Example: formatRelative(yesterday) -> 'Yesterday'
  static String formatRelative(dynamic date) {
    final parsedDate = _parseDate(date);
    if (parsedDate == null) return '';

    final now = DateTime.now();
    final difference = now.difference(parsedDate);

    if (difference.isNegative) return 'In the future';

    if (difference.inSeconds < 45) return 'Just now';
    if (difference.inMinutes < 60) {
      final mins = difference.inMinutes;
      return '$mins ${mins == 1 ? 'minute' : 'minutes'} ago';
    }
    if (difference.inHours < 24) {
      final hours = difference.inHours;
      return '$hours ${hours == 1 ? 'hour' : 'hours'} ago';
    }
    if (difference.inDays == 1) return 'Yesterday';
    if (difference.inDays < 7) return '${difference.inDays} days ago';
    if (difference.inDays < 30) {
      final weeks = (difference.inDays / 7).floor();
      return '$weeks ${weeks == 1 ? 'week' : 'weeks'} ago';
    }

    return format(parsedDate, pattern: 'MMM dd, yyyy');
  }

  /// Formats a date range for cards and event schedules.
  /// Example: formatRange(start, end) -> 'Jan 15 - Jan 18, 2026'
  static String formatRange(dynamic startDate, dynamic endDate) {
    final start = _parseDate(startDate);
    final end = _parseDate(endDate);

    if (start == null || end == null) return '';

    if (start.year == end.year) {
      if (start.month == end.month) {
        return '${DateFormat('MMM dd').format(start)} - ${DateFormat('dd, yyyy').format(end)}';
      }
      return '${DateFormat('MMM dd').format(start)} - ${DateFormat('MMM dd, yyyy').format(end)}';
    }

    return '${format(start)} - ${format(end)}';
  }

  /// Helper parser accepting both [DateTime] and ISO-8601 [String] values.
  static DateTime? _parseDate(dynamic date) {
    if (date == null) return null;
    if (date is DateTime) return date;
    if (date is String) return DateTime.tryParse(date);
    return null;
  }
}
