part of 'auth_bloc.dart';

class AuthState extends Equatable {
  final Map<FieldType, TextFieldProps> fieldsProps;
  final FieldType loginType;
  final ResponseStatus responseStatus;
  const AuthState({
    this.responseStatus = const ResponseStatus(),
    this.fieldsProps = defAuthFields,
    this.loginType = FieldType.email,
  });

  AuthState copyWith({
    ResponseStatus? responseStatus,
    Map<FieldType, TextFieldProps?>? fieldsProps,
    FieldType? loginType,
  }) {
    return AuthState(
      responseStatus: responseStatus ?? this.responseStatus,
      loginType: loginType ?? this.loginType,
      fieldsProps:
          fieldsProps == null ? this.fieldsProps : _updateProps(fieldsProps),
    );
  }

  @override
  List<Object?> get props =>
      [responseStatus, loginType, fieldsProps];

  Map<FieldType, TextFieldProps> _updateProps(
      Map<FieldType, TextFieldProps?> fieldsProps) {
    Map<FieldType, TextFieldProps> updFieldProps = Map.from(this.fieldsProps);
    for (FieldType field in fieldsProps.keys) {
      updFieldProps.update(field, (value) => fieldsProps[field] ?? value);
    }
    return updFieldProps;
  }
}
