/// App-wide static network constants and endpoint paths.
/// Contains zero runtime logic or platform execution checks.
abstract final class ApiConstants {
  const ApiConstants._();

  // Local development host addresses
  static const String webLocalhost = 'http://127.0.0.1:8000';
  static const String androidEmulatorLocalhost = 'http://10.0.2.2:8000';
  static const String defaultLocalhost = 'http://127.0.0.1:8000';

  // Network Timeouts
  static const Duration connectTimeout = Duration(seconds: 15);
  static const Duration receiveTimeout = Duration(seconds: 15);

  // Headers & Media Types
  static const String contentTypeHeader = 'Content-Type';
  static const String jsonContentType = 'application/json; charset=UTF-8';
  static const String authorizationHeader = 'Authorization';
  static const String bearerPrefix = 'Bearer ';

  // API Endpoints
  static const String analyze = '/analyze';
  static const String history = '/history';
  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String refreshToken = '/auth/refresh';
}
