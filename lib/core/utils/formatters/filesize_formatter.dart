import 'dart:math';

/// Pure utility class for converting raw byte counts into human-readable file sizes.
abstract final class FileSizeFormatter {
  const FileSizeFormatter._();

  static const List<String> _binaryUnits = ['B', 'KB', 'MB', 'GB', 'TB', 'PB'];
  static const List<String> _decimalUnits = ['B', 'kB', 'MB', 'GB', 'TB', 'PB'];

  /// Formats raw [bytes] into a human-readable file size string.
  ///
  /// Set [useBinaryUnits] to `true` for standard 1024-byte steps (KB, MB, GB),
  /// or `false` for decimal 1000-byte steps (kB, MB, GB).
  ///
  /// Example (1024 base): formatBytes(1048576) -> '1.0 MB'
  /// Example (1024 base): formatBytes(500) -> '500 B'
  /// Example (Custom decimals): formatBytes(1572864, decimals: 2) -> '1.50 MB'
  static String formatBytes(
    int? bytes, {
    int decimals = 1,
    bool useBinaryUnits = true,
  }) {
    if (bytes == null || bytes <= 0) return '0 B';

    final base = useBinaryUnits ? 1024 : 1000;
    final units = useBinaryUnits ? _binaryUnits : _decimalUnits;

    final digitGroups = (log(bytes) / log(base)).floor();
    final clampedGroup = digitGroups.clamp(0, units.length - 1);

    final value = bytes / pow(base, clampedGroup);
    final formattedValue = value
        .toStringAsFixed(decimals)
        .replaceAll(RegExp(r'\.0+$'), '');

    return '$formattedValue ${units[clampedGroup]}';
  }

  /// Converts a Megabyte double directly to a formatted string.
  /// Example: formatMegabytes(2.5) -> '2.5 MB'
  static String formatMegabytes(double? megabytes, {int decimals = 1}) {
    if (megabytes == null || megabytes <= 0) return '0 B';
    final bytes = (megabytes * 1024 * 1024).round();
    return formatBytes(bytes, decimals: decimals);
  }
}
