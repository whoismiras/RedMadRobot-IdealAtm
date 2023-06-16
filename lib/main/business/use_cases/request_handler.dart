import 'package:ideal_atm/main/business/models/use_cases/api_error.dart';
import 'package:ideal_atm/main/business/models/user/user_data.dart';

abstract class RequestHandler {
  Future<ApiError?> handleAuthRequest(UserData request);
  Future<ApiError?> handleRegRequest(UserData request);
}