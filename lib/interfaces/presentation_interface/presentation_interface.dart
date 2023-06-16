
import 'package:ideal_atm/main/business/models/layout/text_field_model.dart';
import 'package:ideal_atm/main/business/models/use_cases/api_error.dart';
import 'package:ideal_atm/main/business/models/use_cases/response_error.dart';
import 'package:ideal_atm/main/business/models/user/user_data.dart';

abstract class PresentationInterface {
  UserData userDataToDomain(Map<FieldType, String> data);
  Map<FieldType, String?> userDataToView(UserData data);
  ResponseError? handleAuthResponse(ApiError? apiError);
  ResponseError? handleRegResponse(ApiError? apiError);
}