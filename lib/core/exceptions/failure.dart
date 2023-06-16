import 'package:dio/dio.dart';
import 'package:ideal_atm/core/exceptions/network_exceptions.dart';

abstract class Failure {
  NetworkExceptions get exception;
}

class ServerFailure extends Failure {
  Response? response;
  ServerFailure({this.response});

  @override
  NetworkExceptions get exception => NetworkExceptions(
    statusCode: response?.statusCode,
    response: response,
  );
}

class DioFailure extends Failure {
  Response? response;

  DioFailure({this.response});

  @override
  NetworkExceptions get exception => NetworkExceptions(
    statusCode: response?.statusCode,
    response: response,
  );
}

class DioConnectionError extends DioError {
  DioConnectionError({
    required RequestOptions requestOptions,
    Response? response,
    DioErrorType type = DioErrorType.unknown,
    dynamic error,
  }) : super(
            requestOptions: requestOptions,
            response: response,
            type: type,
            error: error);
}

class NoConnectionFailure extends Failure {
  @override
  NetworkExceptions get exception => NetworkExceptions(
    statusCode: -3,
  );
}

class ServerException implements Exception {
  Response? response;
  ServerException({this.response});
}