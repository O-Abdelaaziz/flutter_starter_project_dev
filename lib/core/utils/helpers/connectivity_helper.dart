import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';

/// Normalized connectivity states for easy consumption in the UI/BLoC layers.
enum NetworkStatus {
  wifi,
  cellular,
  ethernet,
  none;

  bool get isConnected => this != NetworkStatus.none;
  bool get isDisconnected => this == NetworkStatus.none;
}

/// Utility class for inspecting real-time device network interface connectivity.
abstract final class ConnectivityHelper {
  const ConnectivityHelper._();

  static final Connectivity _connectivity = Connectivity();

  // ===========================================================================
  // 1. ONE-TIME CONNECTIVITY CHECKS
  // ===========================================================================

  /// Returns the current primary active network connection status.
  /// Example: `final status = await ConnectivityHelper.checkConnectivity();`
  static Future<NetworkStatus> checkConnectivity() async {
    final results = await _connectivity.checkConnectivity();
    return _mapResultsToStatus(results);
  }

  /// Convenience boolean check to quickly verify if device has an active network interface.
  static Future<bool> isConnected() async {
    final status = await checkConnectivity();
    return status.isConnected;
  }

  /// Checks if the device is currently connected specifically via Wi-Fi.
  static Future<bool> isWifi() async {
    final results = await _connectivity.checkConnectivity();
    return results.contains(ConnectivityResult.wifi);
  }

  /// Checks if the device is currently connected specifically via Cellular data.
  static Future<bool> isCellular() async {
    final results = await _connectivity.checkConnectivity();
    return results.contains(ConnectivityResult.mobile);
  }

  // ===========================================================================
  // 2. REAL-TIME STREAM MONITORING
  // ===========================================================================

  /// Real-time stream broadcasting network status changes (Wi-Fi, Cellular, Ethernet, None).
  /// Perfect for driving global banner alerts or offline state listeners.
  ///
  /// Example Usage:
  /// ```dart
  /// ConnectivityHelper.onStatusChanged.listen((status) {
  ///   if (status.isDisconnected) {
  ///     showOfflineBanner();
  ///   }
  /// });
  /// ```
  static Stream<NetworkStatus> get onStatusChanged {
    return _connectivity.onConnectivityChanged.map(_mapResultsToStatus);
  }

  // ===========================================================================
  // 3. PRIVATE HELPERS
  // ===========================================================================

  static NetworkStatus _mapResultsToStatus(List<ConnectivityResult> results) {
    if (results.isEmpty || results.contains(ConnectivityResult.none)) {
      return NetworkStatus.none;
    }
    if (results.contains(ConnectivityResult.wifi)) {
      return NetworkStatus.wifi;
    }
    if (results.contains(ConnectivityResult.mobile)) {
      return NetworkStatus.cellular;
    }
    if (results.contains(ConnectivityResult.ethernet)) {
      return NetworkStatus.ethernet;
    }
    return NetworkStatus.none;
  }
}
