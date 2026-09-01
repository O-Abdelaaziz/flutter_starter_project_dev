import 'dart:io';

import 'package:flutter/foundation.dart';

class ApiConstant {
  ApiConstant._();
  // Logic to determine the base URL based on the device
  static String get baseUrl {
    if (kIsWeb) {
      return "http://127.0.0.1:8000"; // Browser
    } else if (Platform.isAndroid) {
      return "http://10.0.2.2:8000"; // Android emulator
    } else {
      return "http://127.0.0.1:8000"; // iOS / Desktop
    }
  }

  // Specific endpoints (optional, to be more clean)
  static String get analyzeEndpoint => '$baseUrl/analyze';
  static String get historyEndpoint => '$baseUrl/history';
}
