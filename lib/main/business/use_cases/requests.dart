import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:ideal_atm/core/exceptions/failure.dart';
import 'package:ideal_atm/core/services/secure_storage/secure_storage.dart';
import 'package:ideal_atm/core/services/secure_storage/secure_storage_impl.dart';
import 'package:ideal_atm/core/services/interactor/interactor_impl.dart';
import 'package:ideal_atm/main/business/models/use_cases/api_error.dart';
import 'package:ideal_atm/main/business/models/user/user_data.dart';
import 'package:ideal_atm/main/business/use_cases/request_handler.dart';

class Requests implements RequestHandler {
  final InteractorImpl _interactor;
  final SecureStorage _SecureStorage;

  Requests()
      : _interactor = InteractorImpl(),
        _SecureStorage = SecureStorageImpl();

  @override
  Future<ApiError?> handleAuthRequest(UserData userData) async {
    final result = await _interactor.requestAuth(userData);
    if (result.isRight) {
      if (result.right.responseSuccess == true) {
        if (result.right.apiToken != null) {
          _SecureStorage.writeAccessToken(result.right.apiToken!.token);
        } else {
          throw Exception('No token received on successful response!');
        }
        if (result.right.userData != null) {
          _SecureStorage
              .writeUserData(jsonEncode(result.right.userData!.toJson()));
        } else {
          throw Exception('No user data received on successful response!');
        }
        return null;
      } else if (result.right.responseSuccess == false) {
        if (result.right.apiError != null) {
          return result.right.apiError;
        } else {
          throw Exception('No error generated on unsuccessful response!');
        }
      } else {
        throw Exception('No response status was given!');
      }
    } else {
      if (result.left is DioFailure){
          return ApiError(apiErrorType: ApiErrorType.connectionError);
      } else {
        throw Exception('Unhandled Left Result Exception!');
      }
    }
  }

  @override
  Future<ApiError?> handleRegRequest(UserData userData) async {
    final result = await _interactor.requestReg(userData);
    if (result.isRight) {
      if (result.right.responseSuccess == true) {
        return null;
      } else if (result.right.responseSuccess == false) {
        if (result.right.apiError != null) {
          return result.right.apiError;
        } else {
          throw Exception('No error generated on unsuccessful response!');
        }
      } else {
        throw Exception('Unhandled Right Result Exception!');
      }
    } else {
      if (result.left is DioFailure){
        return ApiError(apiErrorType: ApiErrorType.connectionError);
      } else {
        throw Exception('Unhandled Left Result Exception!');
      }
    }
  }
}
