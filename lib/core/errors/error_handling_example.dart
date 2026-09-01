import 'dart:async';

import 'exceptions.dart';
import 'failures.dart';

// =============================================================================
// STEP 1: Data Layer (Remote Data Source)
// Data sources throw specialized [AppException] subtypes when things go wrong.
// =============================================================================
class AuthRemoteDataSourceExample {
  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      // Simulating a network request...
      if (email.isEmpty) {
        throw const AuthException(
          'Email cannot be empty.',
          code: 'EMPTY_EMAIL',
        );
      }

      if (password != 'secret123') {
        throw const AuthException(
          'Invalid email or password credentials.',
          code: 'INVALID_CREDENTIALS',
        );
      }

      // Simulate network timeout or server down scenario
      // throw const ServerException('Database connection failed', code: '500');

      return {'token': 'jwt_token_123', 'userId': 'usr_99'};
    } catch (e) {
      // Re-throw known AppExceptions directly
      if (e is AppException) rethrow;

      // Wrap unknown runtime errors into an unexpected AppException
      throw AppException(
        'Unexpected data source failure: ${e.toString()}',
        type: FailureType.unexpected,
      );
    }
  }
}

// =============================================================================
// STEP 2: Repository Layer
// Repositories catch [AppException]s and convert them into clean [Failure] objects.
// =============================================================================
class AuthRepositoryExample {
  final AuthRemoteDataSourceExample _remoteDataSource;

  AuthRepositoryExample(this._remoteDataSource);

  /// Executes the login call and guarantees that any failure is returned
  /// as a clean, UI-safe [Failure] object.
  Future<({String? token, Failure? failure})> authenticateUser({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _remoteDataSource.login(email, password);
      return (token: response['token'] as String, failure: null);
    } on AppException catch (e) {
      // Convert low-level AppException into a domain-level Failure
      return (token: null, failure: e.toFailure());
    } catch (e) {
      // Catch-all safety net for unhandled Dart errors
      return (
        token: null,
        failure: Failure.unexpected('An unhandled error occurred: $e'),
      );
    }
  }
}

// =============================================================================
// STEP 3: Presentation/Controller Layer
// Controllers or state management execute the repository and react to [Failure].
// =============================================================================
class LoginControllerExample {
  final AuthRepositoryExample _repository;

  LoginControllerExample(this._repository);

  Future<void> handleLoginButton(String email, String password) async {
    // 1. Trigger loading UI state...
    print('UI State: Loading...');

    // 2. Execute repository action
    final result = await _repository.authenticateUser(
      email: email,
      password: password,
    );

    // 3. Handle outcome via Pattern Matching or standard check
    if (result.failure != null) {
      final failure = result.failure!;

      // Pattern match on FailureType to trigger specific UI behaviors
      switch (failure.type) {
        case FailureType.auth:
          print('UI Action: Highlight input fields Red -> ${failure.message}');
          break;
        case FailureType.network:
          print('UI Action: Show offline Banner -> ${failure.message}');
          break;
        case FailureType.server:
          print('UI Action: Show Alert Dialog -> Server maintenance');
          break;
        default:
          print('UI Action: Show Snackbar -> ${failure.message}');
      }
    } else {
      print('UI Action: Navigate to Dashboard with Token: ${result.token}');
    }
  }
}

// =============================================================================
// MAIN ENTRY - Execution Walkthrough
// Run this file to verify how errors flow cleanly across layers.
// =============================================================================
void main() async {
  final dataSource = AuthRemoteDataSourceExample();
  final repository = AuthRepositoryExample(dataSource);
  final controller = LoginControllerExample(repository);

  print('--- Scenario 1: Invalid Credentials ---');
  await controller.handleLoginButton('user@test.com', 'wrong_pass');

  print('\n--- Scenario 2: Successful Authentication ---');
  await controller.handleLoginButton('user@test.com', 'secret123');
}
