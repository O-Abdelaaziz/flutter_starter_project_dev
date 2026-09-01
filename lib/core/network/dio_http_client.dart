import 'package:dio/dio.dart';

import '../errors/exceptions.dart';
import 'network_exceptions.dart';

import 'package:flutter_starter_project_dev/core/constants/api_constant.dart';

/// Production-ready Dio wrapper featuring global timeouts, interceptors, and error mapping.
class DioHttpClient {
  final Dio _dio;

  DioHttpClient({Dio? dio, required String baseUrl})
    : _dio =
          dio ??
          Dio(
            BaseOptions(
              baseUrl: baseUrl,
              connectTimeout: ApiConstants.connectTimeout,
              receiveTimeout: ApiConstants.receiveTimeout,
              headers: {
                ApiConstants.contentTypeHeader: ApiConstants.jsonContentType,
              },
            ),
          ) {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          // Attach Authorization header, language headers, etc.
          return handler.next(options);
        },
        onError: (DioException error, handler) {
          return handler.next(error);
        },
      ),
    );
  }

  Future<dynamic> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return _performRequest(
      () => _dio.get(path, queryParameters: queryParameters, options: options),
    );
  }

  Future<dynamic> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return _performRequest(
      () => _dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      ),
    );
  }

  Future<dynamic> put(String path, {dynamic data, Options? options}) async {
    return _performRequest(() => _dio.put(path, data: data, options: options));
  }

  Future<dynamic> delete(String path, {dynamic data, Options? options}) async {
    return _performRequest(
      () => _dio.delete(path, data: data, options: options),
    );
  }

  Future<dynamic> _performRequest(Future<Response> Function() request) async {
    try {
      final response = await request();
      return response.data;
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      if (e is AppException) rethrow;
      throw AppException(e.toString());
    }
  }

  AppException _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const NetworkException(
          'Connection timeout with server.',
          code: 'TIMEOUT',
        );
      case DioExceptionType.connectionError:
        return const NetworkException(
          'No internet connection available.',
          code: 'NO_INTERNET',
        );
      case DioExceptionType.badResponse:
        return NetworkExceptions.handleResponse(
          error.response?.statusCode,
          error.response?.data,
        );
      case DioExceptionType.cancel:
        return const NetworkException(
          'Request was cancelled.',
          code: 'CANCELLED',
        );
      default:
        return NetworkException(
          error.message ?? 'Unexpected network error.',
          code: 'UNKNOWN',
        );
    }
  }
}
