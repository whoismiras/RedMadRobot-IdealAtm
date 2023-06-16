import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:ideal_atm/core/services/secure_storage/secure_storage.dart';
import 'package:ideal_atm/core/services/secure_storage/secure_storage_impl.dart';

class RestClientService {
  late Dio _client;
  RestClientService(Dio client) {
    _client = client;
    _client.interceptors.add(_baseInterceptor());
    ///Логирование
    if (kDebugMode) {
      _client.interceptors.add(LogInterceptor(
          responseBody: true, requestBody: true, logPrint: _logEvent));
    }
  }
  final SecureStorage _tokenStorage = SecureStorageImpl();

  // ignore: unused_element
  _logEvent(Object? object) {
    var pattern = RegExp('.{1,800}');
    pattern
        .allMatches(object.toString())
    // ignore: avoid_print
        .forEach((match) => print(match.group(0)));
  }

  Interceptor _baseInterceptor() {
    return InterceptorsWrapper(onRequest: (options, handler) async {
      var storageToken = await _tokenStorage.readAccessToken();

      if (storageToken != null && storageToken.isNotEmpty) {
        options.headers.addAll({
          "token": '$storageToken',
        });
      }
      return handler.next(options);
    });
  }

  Future<Response> get(String url,
      {Map<String, dynamic>? params,
        CancelToken? cancelToken,
        Options? options}) =>
      _client.get(
        url,
        queryParameters: params,
        cancelToken: cancelToken,
        options: options,
      );

  Future<Response> post(String url,
      {dynamic body, dynamic parameters, Options? options}) =>
      _client.post(
        url,
        data: body,
        queryParameters: parameters,
        options: options,
      );

  Future<Response> put(String url, {dynamic body, Options? options}) =>
      _client.put(
        url,
        data: body,
        options: options,
      );

  Future<Response> delete(String url,
      {dynamic body, Options? options, Map<String, dynamic>? params}) =>
      _client.delete(
        url,
        data: body,
        options: options,
        queryParameters: params,
      );

  Future<Response> patch(
      String url, {
        dynamic body,
        Options? options,
        Function(int, int)? onSendProgress,
      }) =>
      _client.patch(
        url,
        data: body,
        options: options,
        onSendProgress: onSendProgress,
      );
}

