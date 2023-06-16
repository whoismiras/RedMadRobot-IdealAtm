
import 'package:ideal_atm/main/business/models/use_cases/api_response.dart';
import 'package:ideal_atm/main/business/models/user/user_data.dart';

abstract class DomainInterface{
  ApiResponse handleAuthApiResponse(Map<String,dynamic> body);
  ApiResponse handleRegApiResponse(Map<String,dynamic> body);
  String handleRegRequest(UserData userData);
  String handleAuthRequest(UserData userData);
}