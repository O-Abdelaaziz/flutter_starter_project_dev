/// Pure utility class for converting [Duration] objects or millisecond/second
/// values into human-readable time strings or digital clock formats.
abstract final class TimeFormatter {
  const TimeFormatter._();

  /// Converts a [Duration] into digital clock format.
  /// Automatically includes hours if duration is 1 hour or longer.
  /// Example (short): Duration(seconds: 145) -> '02:25'
  /// Example (long): Duration(hours: 1, minutes: 15, seconds: 8) -> '01:15:08'
  static String formatDigital(Duration? duration) {
    if (duration == null || duration.isNegative) return '00:00';

    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');

    if (hours > 0) {
      final hoursStr = hours.toString().padLeft(2, '0');
      return '$hoursStr:$minutes:$seconds';
    }

    return '$minutes:$seconds';
  }

  /// Converts seconds into digital clock format.
  /// Example: formatSecondsDigital(90) -> '01:30'
  static String formatSecondsDigital(int? seconds) {
    if (seconds == null || seconds < 0) return '00:00';
    return formatDigital(Duration(seconds: seconds));
  }

  /// Converts a [Duration] into a compact human-readable duration label.
  /// Example: Duration(hours: 2, minutes: 15) -> '2h 15m'
  /// Example: Duration(minutes: 45) -> '45m'
  /// Example: Duration(seconds: 30) -> '30s'
  static String formatCompact(Duration? duration) {
    if (duration == null || duration.isNegative) return '0s';

    final days = duration.inDays;
    final hours = duration.inHours.remainder(24);
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);

    final parts = <String>[];

    if (days > 0) parts.add('${days}d');
    if (hours > 0) parts.add('${hours}h');
    if (minutes > 0) parts.add('${minutes}m');
    if (seconds > 0 || parts.isEmpty) parts.add('${seconds}s');

    return parts.join(' ');
  }

  /// Converts milliseconds into a readable stopwatch format (MM:SS.ms).
  /// Useful for timer widgets, workout logs, or speech recording UI.
  /// Example: formatStopwatch(65432) -> '01:05.43'
  static String formatStopwatch(int? milliseconds) {
    if (milliseconds == null || milliseconds < 0) return '00:00.00';

    final duration = Duration(milliseconds: milliseconds);
    final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    final hundredths = (duration.inMilliseconds.remainder(1000) ~/ 10)
        .toString()
        .padLeft(2, '0');

    return '$minutes:$seconds.$hundredths';
  }
}
