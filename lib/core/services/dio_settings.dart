import 'package:dio/dio.dart';

BaseOptions baseOptions = BaseOptions(
    connectTimeout: const Duration(seconds: 3),
    sendTimeout: const Duration(seconds: 3),
    receiveTimeout: const Duration(seconds: 3));