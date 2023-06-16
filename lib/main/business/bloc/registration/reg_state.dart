part of 'reg_bloc.dart';

class RegState extends Equatable {
  final ResponseStatus responseStatus;
  final bool dataUsageAgreed;
  final bool showAgreementWarning;
  final bool showPasswordWarning;
  final Map<FieldType, TextFieldProps> fieldsProps;

  const RegState({
    this.responseStatus = const ResponseStatus(),
    this.dataUsageAgreed = false,
    this.showPasswordWarning = false,
    this.showAgreementWarning = false,
    this.fieldsProps = defRegFields,
  });

  RegState copyWith({
    ResponseStatus? responseStatus,
    bool? dataUsageAgreed,
    bool? showPasswordWarning,
    bool? showAgreementWarning,
    Map<FieldType, TextFieldProps?>? fieldsProps,
  }) {
    return RegState(
      responseStatus: responseStatus ?? this.responseStatus,
      dataUsageAgreed: dataUsageAgreed ?? this.dataUsageAgreed,
      showPasswordWarning: showPasswordWarning ?? this.showPasswordWarning,
      showAgreementWarning: showAgreementWarning ?? this.showAgreementWarning,
      fieldsProps:
          fieldsProps == null ? this.fieldsProps : _updateProps(fieldsProps),
    );
  }

  @override
  List<Object?> get props => [
        responseStatus,
        dataUsageAgreed,
        showPasswordWarning,
        showAgreementWarning,
        fieldsProps
      ];

  Map<FieldType, TextFieldProps> _updateProps(
      Map<FieldType, TextFieldProps?> fieldsProps) {
    Map<FieldType, TextFieldProps> updFieldProps = Map.from(this.fieldsProps);
    for (FieldType field in fieldsProps.keys) {
      updFieldProps.update(field, (value) => fieldsProps[field] ?? value);
    }
    return updFieldProps;
  }
}
