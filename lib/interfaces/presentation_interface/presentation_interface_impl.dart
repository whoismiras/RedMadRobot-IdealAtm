import 'package:ideal_atm/interfaces/presentation_interface/presentation_interface.dart';
import 'package:ideal_atm/main/business/models/layout/text_field_model.dart';
import 'package:ideal_atm/main/business/models/use_cases/api_error.dart';
import 'package:ideal_atm/main/business/models/use_cases/response_error.dart';
import 'package:ideal_atm/main/business/models/user/user_data.dart';

class PresentationInterfaceImpl implements PresentationInterface {
  @override
  UserData userDataToDomain(Map<FieldType, String?> map) {
    return UserData(
        email: map[FieldType.email] == '' ? null : map[FieldType.email],
        phone: map[FieldType.phone] == '' ? null : map[FieldType.phone],
        iin: map[FieldType.iin] == '' ? null : map[FieldType.iin],
        firstName:
            map[FieldType.firstName] == '' ? null : map[FieldType.firstName],
        middleName:
            map[FieldType.middleName] == '' ? null : map[FieldType.middleName],
        lastName:
            map[FieldType.lastName] == '' ? null : map[FieldType.lastName],
        birthDate:
            map[FieldType.birthDate] == '' ? null : map[FieldType.birthDate],
        password:
            map[FieldType.password] == '' ? null : map[FieldType.password]);
  }

  @override
  Map<FieldType, String?> userDataToView(UserData data) {
    Map<FieldType, String?> map = {};
    data.phone != null ? map.addAll({FieldType.phone: data.phone}) : {};
    data.email != null ? map.addAll({FieldType.email: data.email}) : {};
    data.firstName != null
        ? map.addAll({FieldType.firstName: data.firstName})
        : {};
    data.middleName != null
        ? map.addAll({FieldType.middleName: data.middleName})
        : {};
    data.lastName != null
        ? map.addAll({FieldType.lastName: data.lastName})
        : {};
    data.iin != null ? map.addAll({FieldType.iin: data.iin}) : {};
    data.birthDate != null
        ? map.addAll({FieldType.birthDate: data.birthDate})
        : {};
    return map;
  }

  @override
  ResponseError? handleAuthResponse(ApiError? apiError) {
    if (apiError == null) {
      return null;
    } else {
      switch (apiError.apiErrorType) {
        case ApiErrorType.badData:
          if (apiError.errorFields == null) {
            return ResponseError(errorType: ResponseErrorType.rejectedData);
          } else {
            Map<FieldType, FieldError> result = {};
            for (FieldWithError errorField in apiError.errorFields!.keys) {
              for (FieldType field in FieldType.values) {
                if (field.name == errorField.name) {
                  result = {field: FieldError.mismatch};
                  break;
                }
              }
            }
            return ResponseError(
                errorType: ResponseErrorType.invalidData,
                errorBodyUserData: result);
          }
        case ApiErrorType.serverError:
          return ResponseError(
              errorType: ResponseErrorType.internalServerError);
        case ApiErrorType.connectionError :
          return ResponseError(errorType: ResponseErrorType.connectionError);
        default:
          {
            throw Exception('Unknown error');
          }
      }
    }
  }

  @override
  ResponseError? handleRegResponse(ApiError? apiError) {
    if (apiError == null) {
      return null;
    } else {
      switch (apiError.apiErrorType) {
        case ApiErrorType.badData:
          if (apiError.errorFields == null) {
            throw Exception('Bad data error, but no description provided');
          } else {
            Map<FieldType, FieldError> result = {};
            for (FieldWithError errorField in apiError.errorFields!.keys) {
              for (FieldType field in FieldType.values) {
                if (field.name == errorField.name) {
                  result = {field: FieldError.invalid};
                  break;
                }
              }
            }
            return ResponseError(
                errorType: ResponseErrorType.invalidData,
                errorBodyUserData: result);
          }
        case ApiErrorType.dataAlreadyExists:
          if (apiError.errorFields != null) {
            Map<FieldType, FieldError> result = {
              FieldType.values.firstWhere((field) =>
                      field.name == apiError.errorFields!.keys.first.name):
                  FieldError.rejected
            };
            return ResponseError(
                errorType: ResponseErrorType.rejectedData,
                errorBodyUserData: result);
          } else {
            throw Exception('Matched Reg Data, but to description provided');
          }
        case ApiErrorType.serverError:
          return ResponseError(
              errorType: ResponseErrorType.internalServerError);
        case ApiErrorType.connectionError :
          return ResponseError(errorType: ResponseErrorType.connectionError);
        default:
          {
            throw Exception('Unknown error');
          }
      }
    }
  }
}
