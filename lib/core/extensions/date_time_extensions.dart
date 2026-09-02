/// Pure extension methods on [DateTime] for relative calendar checks,
/// date comparisons, and human-readable time-ago text generation.
extension DateTimeX on DateTime {
  // ===========================================================================
  // 1. RELATIVE DAY EVALUATIONS
  // ===========================================================================

  /// True if this date falls on today's date.
  bool get isToday {
    final now = DateTime.now();
    return isSameDay(now);
  }

  /// True if this date falls on yesterday's date.
  bool get isYesterday {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return isSameDay(yesterday);
  }

  /// True if this date falls on tomorrow's date.
  bool get isTomorrow {
    final tomorrow = DateTime.now().add(const Duration(days: 1));
    return isSameDay(tomorrow);
  }

  /// True if this date is in the past compared to [DateTime.now].
  bool get isPast => isBefore(DateTime.now());

  /// True if this date is in the future compared to [DateTime.now].
  bool get isFuture => isAfter(DateTime.now());

  /// Checks if two [DateTime] objects represent the same calendar day (ignoring hours/minutes).
  bool isSameDay(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }

  // ===========================================================================
  // 2. TIME-AGO RELATIVE FORMATTING
  // ===========================================================================

  /// Formats a timestamp into human-readable relative text.
  /// Examples:
  /// - `Just now`
  /// - `5m ago`
  /// - `2h ago`
  /// - `Yesterday`
  /// - `3d ago`
  String timeAgo({bool numericDates = true}) {
    final now = DateTime.now();
    final difference = now.difference(this);

    if (difference.inSeconds < 45) {
      return 'Just now';
    } else if (difference.inMinutes < 60) {
      final minutes = difference.inMinutes;
      return '${minutes}m ago';
    } else if (difference.inHours < 24) {
      final hours = difference.inHours;
      return '${hours}h ago';
    } else if (isYesterday) {
      return 'Yesterday';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d ago';
    } else if (difference.inDays < 30) {
      final weeks = (difference.inDays / 7).floor();
      return '${weeks}w ago';
    } else if (difference.inDays < 365) {
      final months = (difference.inDays / 30).floor();
      return '${months}mo ago';
    } else {
      final years = (difference.inDays / 365).floor();
      return '${years}y ago';
    }
  }

  // ===========================================================================
  // 3. BOUNDARY TRUNCATION
  // ===========================================================================

  /// Returns a new [DateTime] set to the start of the day (00:00:00.000).
  DateTime get startOfDay => DateTime(year, month, day);

  /// Returns a new [DateTime] set to the end of the day (23:59:59.999).
  DateTime get endOfDay => DateTime(year, month, day, 23, 59, 59, 999);
}
