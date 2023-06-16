import 'package:ideal_atm/main/business/models/layout/text_field_model.dart';
import 'package:ideal_atm/main/business/models/use_cases/response_error.dart';

mixin BlocUtils {
  Map<FieldType, TextFieldProps?>? updateFieldsPropsWithErrors(
      Map<FieldType, FieldError>? errors,
      Map<FieldType, TextFieldProps?> fieldsProps) {
    if (errors != null) {
      Map<FieldType, TextFieldProps?> result = {};
      for (FieldType errorField in errors.keys) {
        result.addAll({
          errorField:
              fieldsProps[errorField]?.copyWith(fieldError: errors[errorField])
        });
      }
      return result;
    } else {
      return null;
    }
  }

  Map<FieldType, TextFieldProps?>? updateFieldsPropsWithValues(
      Map<FieldType, String>? values,
      Map<FieldType, TextFieldProps> fieldsProps) {
    if (values != null) {
      Map<FieldType, TextFieldProps?> result = {};
      for (FieldType field in values.keys) {
        result.addAll(
            {field: fieldsProps[field]?.copyWith(fieldValue: values[field])});
      }
      return result;
    } else {
      return null;
    }
  }

  Map<FieldType, String?> convertPropsMapToStringMap(
      Map<FieldType, TextFieldProps?> fieldsProps) {
    Map<FieldType, String?> result = {};
    for (FieldType field in fieldsProps.keys) {
      result.addAll({field: fieldsProps[field]?.fieldValue});
    }
    return result;
  }

  Map<FieldType, FieldError?> convertPropsMapToErrorMap(
      Map<FieldType, TextFieldProps?> fieldsProps) {
    Map<FieldType, FieldError?> result = {};
    for (FieldType field in fieldsProps.keys) {
      result.addAll({field: fieldsProps[field]?.fieldError});
    }
    return result;
  }

  Map<FieldType, TextFieldProps?>? handleResponseErrorBody(
      ResponseError responseError,
      Map<FieldType, TextFieldProps?> fieldsProps) {
    switch (responseError.errorType) {
      case ResponseErrorType.invalidData:
      case ResponseErrorType.rejectedData:
        if (responseError.errorBodyUserData.isEmpty) {
          return updateFieldsPropsWithErrors(
              {fieldsProps.keys.first: FieldError.mismatch}, fieldsProps);
        } else {
          return updateFieldsPropsWithErrors(
              responseError.errorBodyUserData, fieldsProps);
        }
      default:
        return null;
    }
  }
}
