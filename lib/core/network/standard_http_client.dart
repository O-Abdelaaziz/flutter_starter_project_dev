import 'dart:io';
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../errors/exceptions.dart';
import 'network_exceptions.dart';

import 'package:flutter_starter_project_dev/core/constants/api_constant.dart';

/// Lightweight wrapper around [http.Client] implementing pure Dart timeouts and status resolution.
class StandardHttpClient {
  final http.Client _client;
  final String baseUrl;

  StandardHttpClient({http.Client? client, required this.baseUrl})
    : _client = client ?? http.Client();

  Map<String, String> get _defaultHeaders => {
    ApiConstants.contentTypeHeader: ApiConstants.jsonContentType,
  };

  Future<dynamic> get(String path, {Map<String, String>? headers}) async {
    final url = Uri.parse('$baseUrl$path');
    return _performRequest(
      () => _client.get(url, headers: {..._defaultHeaders, ...?headers}),
    );
  }

  Future<dynamic> post(
    String path, {
    dynamic body,
    Map<String, String>? headers,
  }) async {
    final url = Uri.parse('$baseUrl$path');
    return _performRequest(
      () => _client.post(
        url,
        headers: {..._defaultHeaders, ...?headers},
        body: body != null ? jsonEncode(body) : null,
      ),
    );
  }

  Future<dynamic> _performRequest(
    Future<http.Response> Function() request,
  ) async {
    try {
      final response = await request().timeout(ApiConstants.connectTimeout);
      return _processResponse(response);
    } on SocketException {
      throw const NetworkException(
        'No internet connection available.',
        code: 'NO_INTERNET',
      );
    } on FormatException {
      throw const ServerException(
        'Invalid response format from server.',
        code: 'BAD_FORMAT',
      );
    } catch (e) {
      if (e is AppException) rethrow;
      throw NetworkException(e.toString());
    }
  }

  dynamic _processResponse(http.Response response) {
    final statusCode = response.statusCode;
    dynamic decodedBody;

    try {
      if (response.body.isNotEmpty) {
        decodedBody = jsonDecode(response.body);
      }
    } catch (_) {
      decodedBody = null;
    }

    if (statusCode >= 200 && statusCode < 300) {
      return decodedBody;
    }

    throw NetworkExceptions.handleResponse(statusCode, decodedBody);
  }
}
