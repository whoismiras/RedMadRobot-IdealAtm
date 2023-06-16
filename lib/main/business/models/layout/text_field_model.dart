enum FieldType {
  firstName,
  middleName,
  lastName,
  email,
  phone,
  password,
  repPassword,
  iin,
  birthDate
}

enum FieldError { empty, invalid, mismatch, rejected, none }

class TextFieldProps {
  const TextFieldProps(
      {this.fieldValue = '', this.fieldError = FieldError.none});

  final String fieldValue;
  final FieldError fieldError;

  TextFieldProps copyWith({
    String? fieldValue,
    FieldError? fieldError,
  }) {
    return TextFieldProps(
        fieldValue: fieldValue ?? this.fieldValue,
        fieldError: fieldError ?? this.fieldError);
  }

  TextFieldProps reset() {
    return const TextFieldProps(fieldValue: '', fieldError: FieldError.none );
  }
}
