import 'package:ideal_atm/main/business/models/layout/text_field_model.dart';

enum ResponseErrorType {
  connectionError,
  internalServerError,
  invalidData,
  rejectedData
}

class ResponseError {
  ResponseError({required this.errorType, this.errorBodyUserData = const {}});
  ResponseErrorType errorType;
  Map<FieldType, FieldError> errorBodyUserData;
}
