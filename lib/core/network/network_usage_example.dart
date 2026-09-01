import 'dart:async';

import '../config/env_config.dart';
import '../errors/exceptions.dart';
import '../errors/failures.dart';
import 'dio_http_client.dart';
import 'standard_http_client.dart';

// =============================================================================
// STEP 1: Feature Data Source using Dio (Recommended)
// Data sources receive the network client via Dependency Injection (DI).
// =============================================================================
class AuthRemoteDataSourceWithDio {
  final DioHttpClient _client;

  AuthRemoteDataSourceWithDio(this._client);

  Future<Map<String, dynamic>> login(String email, String password) async {
    // Dio automatically encodes 'data' as JSON and parses JSON response
    final response = await _client.post(
      '/auth/login',
      data: {'email': email, 'password': password},
    );

    return response as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>> getUserProfile() async {
    final response = await _client.get('/user/profile');
    return response as Map<String, dynamic>;
  }
}

// =============================================================================
// STEP 2: Feature Data Source using Standard Http
// Same contract, but uses standard client instance.
// =============================================================================
class AuthRemoteDataSourceWithHttp {
  final StandardHttpClient _client;

  AuthRemoteDataSourceWithHttp(this._client);

  Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await _client.post(
      '/auth/login',
      body: {'email': email, 'password': password},
    );

    return response as Map<String, dynamic>;
  }
}

// =============================================================================
// STEP 3: Repository Layer handling Network Exceptions
// The repository catches AppExceptions thrown by either client and returns Failures.
// =============================================================================
class AuthRepositoryImpl {
  final AuthRemoteDataSourceWithDio _remoteDataSource;

  AuthRepositoryImpl(this._remoteDataSource);

  Future<({String? token, Failure? failure})> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      final data = await _remoteDataSource.login(email, password);
      final token = data['token'] as String;
      return (token: token, failure: null);
    } on AppException catch (e) {
      // Maps NetworkException, ServerException, AuthException automatically to Failure
      return (token: null, failure: e.toFailure());
    } catch (e) {
      return (
        token: null,
        failure: Failure.unexpected('Unexpected error: ${e.toString()}'),
      );
    }
  }
}

// =============================================================================
// MAIN ENTRY - Execution Walkthrough
// Shows how to instantiate clients and pass them to data sources.
// =============================================================================
void main() async {
  // 1. Resolve baseUrl dynamically via EnvConfig
  final String baseUrl = EnvConfig.baseUrl;

  // 2. Instantiate Network Clients
  final dioClient = DioHttpClient(baseUrl: baseUrl);
  final httpClient = StandardHttpClient(baseUrl: baseUrl);

  // 3. Inject Client into Data Sources
  final authDataSourceDio = AuthRemoteDataSourceWithDio(dioClient);
  final authDataSourceHttp = AuthRemoteDataSourceWithHttp(httpClient);

  // 4. Inject Data Source into Repository
  final repository = AuthRepositoryImpl(authDataSourceDio);

  print('--- Executing Login via Network Architecture ---');

  final result = await repository.loginUser(
    email: 'user@example.com',
    password: 'password123',
  );

  if (result.failure != null) {
    print('Login Failed!');
    print('Type: ${result.failure!.type}');
    print('Message: ${result.failure!.message}');
    print('Code: ${result.failure!.code}');
  } else {
    print('Login Success! Token: ${result.token}');
  }
}
