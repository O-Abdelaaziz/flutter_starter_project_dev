import 'dart:developer' as developer;

import 'package:flutter/foundation.dart';

/// Supported log severity levels ordered by priority.
enum LogLevel implements Comparable<LogLevel> {
  trace(1, 'TRACE', '🔍'),
  debug(2, 'DEBUG', '🐛'),
  info(3, 'INFO ', '💡'),
  warning(4, 'WARN ', '⚠️'),
  error(5, 'ERROR', '❌'),
  fatal(6, 'FATAL', '💀');

  final int priority;
  final String label;
  final String emoji;

  const LogLevel(this.priority, this.label, this.emoji);

  @override
  int compareTo(LogLevel other) => priority.compareTo(other.priority);

  // Define relational operators directly on the enum
  bool operator <(LogLevel other) => priority < other.priority;
  bool operator <=(LogLevel other) => priority <= other.priority;
  bool operator >(LogLevel other) => priority > other.priority;
  bool operator >=(LogLevel other) => priority >= other.priority;
}

/// Abstract contract for log outputs (Console, Crashlytics, File, Remote API).
abstract interface class LogSink {
  void log({
    required LogLevel level,
    required String message,
    required String tag,
    required DateTime timestamp,
    Object? error,
    StackTrace? stackTrace,
    Map<String, dynamic>? metadata,
  });
}

/// Default console sink printing formatted logs to developer console in debug mode.
class ConsoleLogSink implements LogSink {
  const ConsoleLogSink();

  // ANSI Color Codes for terminal formatting
  static const _reset = '\x1B[0m';
  static const _gray = '\x1B[90m';
  static const _blue = '\x1B[34m';
  static const _green = '\x1B[32m';
  static const _yellow = '\x1B[33m';
  static const _red = '\x1B[31m';
  static const _magenta = '\x1B[35m';

  String _getColor(LogLevel level) {
    switch (level) {
      case LogLevel.trace:
        return _gray;
      case LogLevel.debug:
        return _blue;
      case LogLevel.info:
        return _green;
      case LogLevel.warning:
        return _yellow;
      case LogLevel.error:
        return _red;
      case LogLevel.fatal:
        return _magenta;
    }
  }

  @override
  void log({
    required LogLevel level,
    required String message,
    required String tag,
    required DateTime timestamp,
    Object? error,
    StackTrace? stackTrace,
    Map<String, dynamic>? metadata,
  }) {
    final color = _getColor(level);
    final timeStr = timestamp
        .toIso8601String()
        .split('T')
        .last
        .substring(0, 12);
    final header =
        '$color[${level.emoji} ${level.label}] [$timeStr] [$tag]$_reset';

    final buffer = StringBuffer('$header $message');

    if (metadata != null && metadata.isNotEmpty) {
      buffer.write('\n  $_gray Metadata: $metadata$_reset');
    }

    if (error != null) {
      buffer.write('\n  $_red Error: $error$_reset');
    }

    if (stackTrace != null) {
      final formattedStack = _formatStackTrace(stackTrace);
      buffer.write('\n  $_gray StackTrace:\n$formattedStack$_reset');
    }

    // Log to standard Flutter developer log console
    developer.log(
      buffer.toString(),
      name: tag,
      time: timestamp,
      level: level.priority * 100,
      error: error,
      stackTrace: stackTrace,
    );
  }

  /// Truncates raw stack traces down to the top relevant frames.
  String _formatStackTrace(StackTrace stackTrace, {int maxLines = 5}) {
    final lines = stackTrace.toString().split('\n');
    final formatted = lines
        .where(
          (line) =>
              line.trim().isNotEmpty && !line.contains('package:flutter/'),
        )
        .take(maxLines)
        .map((line) => '    $line')
        .join('\n');
    return formatted.isEmpty ? stackTrace.toString() : formatted;
  }
}

/// Advanced static Logger with level filtering, metadata context, and multi-sink support.
abstract final class Logger {
  const Logger._();

  /// Minimum severity level required to output a log.
  /// Defaults to [LogLevel.trace] in debug mode, [LogLevel.info] in release.
  static LogLevel minLogLevel = kDebugMode ? LogLevel.trace : LogLevel.info;

  /// Global tag used when no specific tag is provided.
  static String defaultTag = 'APP';

  /// Registered log outputs. Defaults to [ConsoleLogSink].
  static final List<LogSink> _sinks = [const ConsoleLogSink()];

  /// Adds a custom log sink (e.g., Firebase Crashlytics sink or File sink).
  static void addSink(LogSink sink) {
    _sinks.add(sink);
  }

  /// Removes all sinks (useful for test mocks or resetting loggers).
  static void clearSinks() {
    _sinks.clear();
  }

  /// Core dispatch function.
  static void _log(
    LogLevel level,
    String message, {
    String? tag,
    Object? error,
    StackTrace? stackTrace,
    Map<String, dynamic>? metadata,
  }) {
    if (level < minLogLevel) return;

    final timestamp = DateTime.now();
    final activeTag = tag ?? defaultTag;

    for (final sink in _sinks) {
      try {
        sink.log(
          level: level,
          message: message,
          tag: activeTag,
          timestamp: timestamp,
          error: error,
          stackTrace: stackTrace,
          metadata: metadata,
        );
      } catch (e, s) {
        if (kDebugMode) {
          debugPrint('Failed to log to sink $sink: $e\n$s');
        }
      }
    }
  }

  /// Log fine-grained diagnostic trace messages.
  static void trace(
    String message, {
    String? tag,
    Map<String, dynamic>? metadata,
  }) {
    _log(LogLevel.trace, message, tag: tag, metadata: metadata);
  }

  /// Log standard debug info during development.
  static void debug(
    String message, {
    String? tag,
    Map<String, dynamic>? metadata,
  }) {
    _log(LogLevel.debug, message, tag: tag, metadata: metadata);
  }

  /// Log general operational events.
  static void info(
    String message, {
    String? tag,
    Map<String, dynamic>? metadata,
  }) {
    _log(LogLevel.info, message, tag: tag, metadata: metadata);
  }

  /// Log expected issues or non-fatal warnings.
  static void warning(
    String message, {
    String? tag,
    Object? error,
    StackTrace? stackTrace,
    Map<String, dynamic>? metadata,
  }) {
    _log(
      LogLevel.warning,
      message,
      tag: tag,
      error: error,
      stackTrace: stackTrace,
      metadata: metadata,
    );
  }

  /// Log handled runtime errors and exceptions.
  static void error(
    String message, {
    String? tag,
    Object? error,
    StackTrace? stackTrace,
    Map<String, dynamic>? metadata,
  }) {
    _log(
      LogLevel.error,
      message,
      tag: tag,
      error: error,
      stackTrace: stackTrace,
      metadata: metadata,
    );
  }

  /// Log critical system failure events.
  static void fatal(
    String message, {
    String? tag,
    Object? error,
    StackTrace? stackTrace,
    Map<String, dynamic>? metadata,
  }) {
    _log(
      LogLevel.fatal,
      message,
      tag: tag,
      error: error,
      stackTrace: stackTrace,
      metadata: metadata,
    );
  }
}
