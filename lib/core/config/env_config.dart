import 'package:flutter/foundation.dart';
import 'package:flutter_starter_project_dev/core/constants/api_constant.dart';

/// Handles dynamic environment configuration and platform-specific resolutions.
abstract final class EnvConfig {
  const EnvConfig._();

  /// Resolves the base URL using compile-time environment flags or local platform defaults.
  static String get baseUrl {
    const envBaseUrl = String.fromEnvironment('BASE_URL');
    if (envBaseUrl.isNotEmpty) {
      return envBaseUrl;
    }

    if (kIsWeb) {
      return ApiConstants.webLocalhost;
    } else if (defaultTargetPlatform == TargetPlatform.android) {
      return ApiConstants.androidEmulatorLocalhost;
    } else {
      return ApiConstants.defaultLocalhost;
    }
  }
}
