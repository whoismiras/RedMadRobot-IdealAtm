import 'package:ideal_atm/main/business/models/layout/text_field_model.dart';

const Map<FieldType, TextFieldProps> defAuthFields = {
  FieldType.email: TextFieldProps(),
  FieldType.password: TextFieldProps(),
  FieldType.phone: TextFieldProps(),
};

const Map<FieldType, TextFieldProps> defRegFields = {
  FieldType.firstName: TextFieldProps(),
  FieldType.middleName:TextFieldProps(),
  FieldType.lastName: TextFieldProps(),
  FieldType.email: TextFieldProps(),
  FieldType.password: TextFieldProps(),
  FieldType.repPassword: TextFieldProps(),
  FieldType.iin: TextFieldProps(),
  FieldType.birthDate: TextFieldProps(),
  FieldType.phone: TextFieldProps(),
};