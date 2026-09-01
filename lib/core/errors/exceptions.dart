import 'failures.dart';

/// Base exception for low-level infrastructure/data errors.
/// Implements [Exception] and provides conversion to a UI-friendly [Failure].
abstract class AppException implements Exception {
  const AppException(
    this.message, {
    this.code,
    this.type = FailureType.unexpected,
  });

  final String message;
  final String? code;
  final FailureType type;

  /// Map infrastructure exception directly into domain failure
  Failure toFailure() => Failure(message, code: code, type: type);

  @override
  String toString() => '$runtimeType(message: $message, code: $code)';
}

// -----------------------------------------------------------------------------
// Specialized Data Exceptions
// -----------------------------------------------------------------------------

class NetworkException extends AppException {
  const NetworkException(super.message, {super.code})
    : super(type: FailureType.network);
}

class ServerException extends AppException {
  const ServerException(super.message, {super.code})
    : super(type: FailureType.server);
}

class CacheException extends AppException {
  const CacheException(super.message, {super.code})
    : super(type: FailureType.unexpected);
}

class AuthException extends AppException {
  const AuthException(super.message, {super.code})
    : super(type: FailureType.auth);
}

class NotFoundException extends AppException {
  const NotFoundException(super.message, {super.code})
    : super(type: FailureType.notFound);
}
