import '../errors/exceptions.dart';

/// Interprets HTTP status codes and maps network failures into typed [AppException]s.
abstract final class NetworkExceptions {
  const NetworkExceptions._();

  static AppException handleResponse(int? statusCode, dynamic errorResponse) {
    final String message =
        _extractMessage(errorResponse) ?? 'An error occurred';

    switch (statusCode) {
      case 400:
        return ServerException('Bad Request: $message', code: '400');
      case 401:
        return AuthException('Unauthorized: $message', code: '401');
      case 403:
        return AuthException('Forbidden: $message', code: '403');
      case 404:
        return NotFoundException('Not Found: $message', code: '404');
      case 409:
        return ServerException('Conflict: $message', code: '409');
      case 422:
        return ServerException('Unprocessable Entity: $message', code: '422');
      case 500:
      case 502:
      case 503:
      case 504:
        return ServerException(
          'Server Error ($statusCode): $message',
          code: '$statusCode',
        );
      default:
        return ServerException(
          'Unexpected Error ($statusCode): $message',
          code: '$statusCode',
        );
    }
  }

  static String? _extractMessage(dynamic response) {
    if (response is Map<String, dynamic>) {
      return response['message'] as String? ?? response['error'] as String?;
    }
    return null;
  }
}
