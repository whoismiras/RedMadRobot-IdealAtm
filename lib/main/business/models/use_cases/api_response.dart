
import 'package:ideal_atm/main/business/models/use_cases/api_error.dart';
import 'package:ideal_atm/main/business/models/user/api_token.dart';
import 'package:ideal_atm/main/business/models/user/user_data.dart';

class ApiResponse {
  bool? responseSuccess;
  ApiToken? apiToken;
  UserData? userData;
  ApiError? apiError;

  void _setApiToken(Map<String, dynamic> apiToken) {
    this.apiToken = ApiToken.fromJson(apiToken);
  }
  void _setUserData(Map<String, dynamic> userData){
    this.userData = UserData.fromJson(userData);
  }
  void setSuccessfulData(Map<String, dynamic> bodyData){
    responseSuccess = true;
    _setApiToken(bodyData);
    _setUserData(bodyData['user']);
  }
  void setError(Map<String, dynamic> body){
    responseSuccess = false;
    apiError = ApiError.fromJson(body);
  }
}
