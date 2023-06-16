import 'dart:convert';
import 'package:ideal_atm/interfaces/domain_interface/domain_interface.dart';
import 'package:ideal_atm/main/business/models/use_cases/api_response.dart';
import 'package:ideal_atm/main/business/models/user/user_data.dart';

class DomainInterfaceImpl implements DomainInterface {
  ApiResponse apiResponse = ApiResponse();

  @override
  ApiResponse handleAuthApiResponse(Map<String,dynamic> body) {
    switch (body['status']) {
      case 1000:
        {
          apiResponse.setSuccessfulData(body['data']);
        }
        break;
      default:
        {
          apiResponse.setError(body);
        }
    }
    return apiResponse;
  }

  @override
  ApiResponse handleRegApiResponse(Map<String,dynamic> body) {
    switch (body['status']) {
      case 1000:
        {
          apiResponse.responseSuccess = true;
        }
        break;
      default:
        {
          apiResponse.setError(body);
        }
    }
    return apiResponse;
  }

  @override
  String handleRegRequest(UserData userData) {
    return jsonEncode(userData.toJson());
  }

  @override
  String handleAuthRequest(UserData userData) {
    return jsonEncode(userData.toJson());
  }
}
