import 'package:flutter/foundation.dart';

/// General categories of app failures.
enum FailureType { validation, auth, network, notFound, server, unexpected }

/// Domain & UI layer failure representation.
/// Immutable value object safe to pass across state management layers.
@immutable
class Failure {
  const Failure(this.message, {this.code, this.type = FailureType.unexpected});

  final String message;
  final String? code;
  final FailureType type;

  // Named constructors for quick instantiation
  factory Failure.validation(String message, {String? code}) =>
      Failure(message, code: code, type: FailureType.validation);

  factory Failure.auth(String message, {String? code}) =>
      Failure(message, code: code, type: FailureType.auth);

  factory Failure.network(String message, {String? code}) =>
      Failure(message, code: code, type: FailureType.network);

  factory Failure.notFound(String message, {String? code}) =>
      Failure(message, code: code, type: FailureType.notFound);

  factory Failure.server(String message, {String? code}) =>
      Failure(message, code: code, type: FailureType.server);

  factory Failure.unexpected([String? message]) => Failure(
    message ?? 'An unexpected error occurred. Please try again.',
    type: FailureType.unexpected,
  );

  @override
  String toString() => 'Failure(message: $message, code: $code, type: $type)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Failure &&
          runtimeType == other.runtimeType &&
          message == other.message &&
          code == other.code &&
          type == other.type;

  @override
  int get hashCode => Object.hash(message, code, type);
}
