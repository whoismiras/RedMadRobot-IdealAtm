enum ApiErrorType {
  badData,
  dataAlreadyExists,
  serverError,
  connectionError,
  unhandledError
}

enum FieldWithError {
  firstName,
  middleName,
  lastName,
  email,
  phone,
  password,
  repPassword,
  iin,
  birthDate,
  unhandledField
}

class ApiError {
  ApiError({this.apiErrorType, this.errorFields});

  ApiErrorType? apiErrorType;
  Map<FieldWithError, ApiErrorType>? errorFields;

  factory ApiError.fromJson(Map<String, dynamic> body) {
    Map<FieldWithError, ApiErrorType>? errorFields;
    switch (body['status']) {
      case 1001:
        {
          errorFields = {FieldWithError.email: ApiErrorType.dataAlreadyExists};
          return ApiError(
              apiErrorType: ApiErrorType.dataAlreadyExists,
              errorFields: errorFields);
        }
      case 1002:
        {
          return ApiError(apiErrorType: ApiErrorType.badData);
        }
      case 1003:
        {
          errorFields = {FieldWithError.phone: ApiErrorType.dataAlreadyExists};
          return ApiError(
              apiErrorType: ApiErrorType.dataAlreadyExists,
              errorFields: errorFields);
        }
      case 1004:
        {
          errorFields = {FieldWithError.iin: ApiErrorType.dataAlreadyExists};
          return ApiError(
              apiErrorType: ApiErrorType.dataAlreadyExists,
              errorFields: errorFields);
        }
      case 400:
        {
          List<dynamic> errors = body['errors'];
          FieldWithError fieldWithError;
          errorFields = {};
          for (var error in errors) {
            switch (error['field']) {
              case 'email':
                fieldWithError = FieldWithError.email;
                break;
              case 'phone':
                fieldWithError = FieldWithError.phone;
                break;
              case 'uid':
                fieldWithError = FieldWithError.iin;
                break;
              case 'firstName':
                fieldWithError = FieldWithError.firstName;
                break;
              case 'patronomic':
                fieldWithError = FieldWithError.middleName;
                break;
              case 'lastName':
                fieldWithError = FieldWithError.lastName;
                break;
              case 'password':
                fieldWithError = FieldWithError.password;
                break;
              case 'dateOfBirth':
                fieldWithError = FieldWithError.birthDate;
                break;
              default:
                fieldWithError = FieldWithError.unhandledField;
            }
            errorFields.addAll({fieldWithError: ApiErrorType.badData});
          }
          return ApiError(
              apiErrorType: ApiErrorType.badData, errorFields: errorFields);
        }
      case 500:
        {
          return ApiError(apiErrorType: ApiErrorType.serverError);
        }
      default:
        {
          return ApiError(apiErrorType: ApiErrorType.unhandledError);
        }
    }
  }
}
