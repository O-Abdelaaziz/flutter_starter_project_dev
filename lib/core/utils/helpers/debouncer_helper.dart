import 'dart:async';

/// Utility class for controlling rate-limited function execution.
/// - Use [Debouncer] to delay execution until user stops typing (e.g., search bars).
/// - Use [Throttler] to enforce a max execution frequency or prevent double-taps (e.g., submit buttons).
abstract final class RateLimiter {
  const RateLimiter._();
}

/// Delays execution of a callback until a specified duration has elapsed
/// since the last time it was invoked.
///
/// Ideal for auto-complete search inputs, live form field validation,
/// and auto-save draft functionality.
class DebouncerHelper {
  final Duration duration;
  Timer? _timer;

  DebouncerHelper({this.duration = const Duration(milliseconds: 300)});

  /// Runs the provided action after [duration] has passed without any new calls.
  /// Any pending execution is automatically canceled.
  void run(void Function() action) {
    cancel();
    _timer = Timer(duration, action);
  }

  /// Cancels any active pending timer.
  void cancel() {
    _timer?.cancel();
    _timer = null;
  }

  /// True if a callback is currently scheduled and waiting to execute.
  bool get isPending => _timer?.isActive ?? false;

  /// Disposes of the active timer.
  void dispose() {
    cancel();
  }
}

/// Enforces a maximum execution rate, ensuring the target callback is executed
/// at most once per specified duration interval.
///
/// Ideal for double-tap button prevention, scroll position listeners,
/// and window resize handlers.
class ThrottlerHelper {
  final Duration duration;
  Timer? _timer;
  bool _isThrottled = false;

  ThrottlerHelper({this.duration = const Duration(milliseconds: 500)});

  /// Executes the action immediately if not throttled, then locks execution
  /// until [duration] has elapsed.
  void run(void Function() action) {
    if (!_isThrottled) {
      action();
      _isThrottled = true;
      _timer = Timer(duration, () {
        _isThrottled = false;
        _timer = null;
      });
    }
  }

  /// Returns whether execution is currently locked/throttled.
  bool get isThrottled => _isThrottled;

  /// Cancels any active throttle timer and unlocks execution immediately.
  void reset() {
    _timer?.cancel();
    _timer = null;
    _isThrottled = false;
  }

  /// Disposes of active timers and resets state.
  void dispose() {
    reset();
  }
}
