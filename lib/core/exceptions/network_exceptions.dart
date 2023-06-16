import 'package:dio/dio.dart';

class NetworkExceptions {
  late String title;
  late String message;
  final int? statusCode;
  Response? response;

  NetworkExceptions({this.statusCode = -3, this.response, this.title = ''}) {
    switch (statusCode) {
      case -3:
        message = 'Internet Connection Error';
        title = 'No Internet';
        break;
      case 500:
        message = 'Internal Error';
        title = 'Internal Error';
        break;
      case 501:
        message = 'Internal Error';
        title = 'Internal Error';
        break;
      case 502:
        message = 'Internal Error';
        title = 'Internal Error';
        break;
      case 503:
        message = 'Internal Error';
        title = 'Internal Error';
        break;
      default:
        title = "Response Error";
        message = title;
        break;
    }
  }

  @override
  String toString() => message;
}