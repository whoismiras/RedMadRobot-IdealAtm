import 'package:ideal_atm/main/business/bloc/utils/validation_mixin.dart';
import 'package:ideal_atm/main/business/models/layout/text_field_model.dart';

class Validator with ValidationMixin {
  FieldError? validateField(FieldType fieldType, String? fieldText) {
    if (!isFieldEmpty(fieldText)) {
      bool isInvalid = false;
      switch (fieldType) {
        case FieldType.firstName:
        case FieldType.middleName:
        case FieldType.lastName:
          if (!validateName(fieldText)) {
            isInvalid = true;
          }
          break;
        case FieldType.email:
          if (!validateMail(fieldText)) {
            isInvalid = true;
          }
          break;
        case FieldType.phone:
          if (!validatePhoneNumber(fieldText)) {
            isInvalid = true;
          }
          break;
        case FieldType.password:
          if (!validatePassword(fieldText)) {
            isInvalid = true;
          }
          break;
        case FieldType.iin:
          if (!validateIIN(fieldText)) {
            isInvalid = true;
          }
          break;
        case FieldType.birthDate:
          if (!validateBirthDate(fieldText)) {
            isInvalid = true;
          }
          break;
        default:
          return null;
      }
      if (isInvalid) {
        return FieldError.invalid;
      } else {
        return null;
      }
    } else {
      return FieldError.empty;
    }
  }

  FieldError? validateIfEmpty(String? fieldText){
    if (isFieldEmpty(fieldText)){
      return FieldError.empty;
    } else {
      return null;
    }
  }

  FieldError? validateRepeatPasswordField(String? pass, String? repPass) {
    if (isFieldEmpty(repPass)){
      return FieldError.empty;
    }
    if (validatePasswordMatch(pass, repPass)) {
      return null;
    } else {
      return FieldError.mismatch;
    }
  }

  Map<FieldType, FieldError>? validateCreds(Map<FieldType, String?> fieldsData){
    FieldError? error;
    Map<FieldType, FieldError> errorMap = {};
    for (FieldType field in fieldsData.keys){
      error = null;
      if (field != FieldType.password) {
        error = validateField(field, fieldsData[field]);
      } else {
        if (isFieldEmpty(fieldsData[field])){
          error = FieldError.empty;
        }
      }
      if (error != null) {
        errorMap.addAll({field: error});
      }
    }
    if (errorMap.isNotEmpty) {
      return errorMap;
    } else {
      return null;
    }
  }

  Map<FieldType, FieldError>? validateAllFields(
      Map<FieldType, String?> fieldsData) {
    Map<FieldType, FieldError> errorMap = {};
    FieldError? error;
    for (FieldType field in fieldsData.keys) {
      error = null;
      if (field != FieldType.repPassword) {
        error = validateField(field, fieldsData[field]);
      } else {
        error = validateRepeatPasswordField(
            fieldsData[FieldType.password], fieldsData[FieldType.repPassword]);
      }
      if (error != null) {
        errorMap.addAll({field: error});
      }
    }
    if (errorMap.isNotEmpty) {
      return errorMap;
    } else {
      return null;
    }
  }
}
