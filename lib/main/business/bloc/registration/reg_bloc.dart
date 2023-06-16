import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ideal_atm/interfaces/presentation_interface/presentation_interface_impl.dart';
import 'package:ideal_atm/main/business/bloc/utils/bloc_utils_mixin.dart';
import 'package:ideal_atm/main/business/bloc/utils/validator.dart';
import 'package:ideal_atm/main/business/models/layout/text_field_def_props.dart';
import 'package:ideal_atm/main/business/models/layout/text_field_model.dart';
import 'package:ideal_atm/main/business/models/use_cases/response_error.dart';
import 'package:ideal_atm/main/business/models/use_cases/response_status.dart';
import 'package:ideal_atm/main/business/use_cases/requests.dart';

part 'reg_event.dart';

part 'reg_state.dart';

class RegBloc extends Bloc<RegEvent, RegState> with BlocUtils {
  RegBloc()
      : _interface = PresentationInterfaceImpl(),
        _requestHandler = Requests(),
        _validator = Validator(),
        super(const RegState()) {
    on<HidePasswordWarning>(_onHidePasswordWarning);
    on<RegDataSubmitted>(_onRegDataSubmitted);
    on<RegFieldChanged>(_onRegFieldChanged);
    on<RegFieldFocused>(_onRegFieldFocused);
    on<RegFieldUnfocused>(_onRegFieldUnfocused);
    on<RegCheckBoxChanged>(_onRegCheckBoxChanged);
    on<RegErrorWasShown>(_onRegErrorWasShown);
  }

  final PresentationInterfaceImpl _interface;
  final Requests _requestHandler;
  final Validator _validator;

  void _onRegErrorWasShown(RegErrorWasShown event, Emitter<RegState> emit){
    emit(state.copyWith(
        responseStatus: state.responseStatus.resetError()));
  }

  void _onHidePasswordWarning(
      HidePasswordWarning event, Emitter<RegState> emit) {
    emit(state.copyWith(showAgreementWarning: false));
  }

  void _onRegCheckBoxChanged(RegCheckBoxChanged event, Emitter<RegState> emit) {
    bool? showWarning;
    if (event.isChecked) {
      showWarning = false;
    }
    emit(state.copyWith(
        dataUsageAgreed: event.isChecked, showAgreementWarning: showWarning));
  }

  void _onRegFieldChanged(RegFieldChanged event, Emitter<RegState> emit) {
    emit(state.copyWith(fieldsProps: {
      event.fieldType: state.fieldsProps[event.fieldType]
          ?.copyWith(fieldValue: event.fieldText)
    }));
  }

  void _onRegFieldFocused(RegFieldFocused event, Emitter<RegState> emit) {
    if (state.fieldsProps[event.fieldType]?.fieldError != FieldError.none) {
      emit(state.copyWith(fieldsProps: {
        event.fieldType: state.fieldsProps[event.fieldType]
            ?.copyWith(fieldError: FieldError.none)
      }));
    }
  }

  void _onRegFieldUnfocused(RegFieldUnfocused event, Emitter<RegState> emit) {
    bool showPasswordWarning = false;
    FieldError? error;
    if (event.fieldType != FieldType.repPassword) {
      error = _validator.validateField(
          event.fieldType, state.fieldsProps[event.fieldType]?.fieldValue);
      if ((error != null) && (event.fieldType == FieldType.password)) {
        showPasswordWarning = true;
      }
    } else {
      error = _validator.validateRepeatPasswordField(
          state.fieldsProps[FieldType.password]?.fieldValue,
          state.fieldsProps[FieldType.repPassword]?.fieldValue);
    }
    if (error != null) {
      emit(state.copyWith(fieldsProps: {
        event.fieldType: state.fieldsProps[event.fieldType]
            ?.copyWith(fieldError: error)
      }, showPasswordWarning: showPasswordWarning));
    }
  }

  Future<void> _onRegDataSubmitted(
      RegDataSubmitted event, Emitter<RegState> emit) async {
    Map<FieldType, FieldError>? errors = _validator
        .validateAllFields(convertPropsMapToStringMap(state.fieldsProps));
    if ((errors != null) || !state.dataUsageAgreed) {
      bool showWarning = !state.dataUsageAgreed;
      emit(state.copyWith(
          fieldsProps: updateFieldsPropsWithErrors(errors, state.fieldsProps),
          showAgreementWarning: showWarning));
    } else {
      emit(state.copyWith(
          responseStatus: state.responseStatus
              .copyWith(status: ResponseStatusType.inProgress)));

      ResponseError? response = _interface.handleRegResponse(
          await _requestHandler.handleRegRequest(_interface.userDataToDomain(
              convertPropsMapToStringMap(state.fieldsProps))));

      if (response != null) {
        emit(state.copyWith(
            fieldsProps: handleResponseErrorBody(response, state.fieldsProps),
            responseStatus: state.responseStatus.copyWith(
                status: ResponseStatusType.error, error: response.errorType)));
      } else {
        emit(state.copyWith(
            responseStatus: state.responseStatus
                .copyWith(status: ResponseStatusType.completed)));
      }
    }
  }
}
