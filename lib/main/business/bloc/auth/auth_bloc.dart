import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ideal_atm/interfaces/presentation_interface/presentation_interface_impl.dart';
import 'package:ideal_atm/main/business/bloc/utils/bloc_utils_mixin.dart';
import 'package:ideal_atm/main/business/bloc/utils/validator.dart';
import 'package:ideal_atm/main/business/models/layout/text_field_model.dart';
import 'package:ideal_atm/main/business/models/layout/text_field_def_props.dart';
import 'package:ideal_atm/main/business/models/use_cases/response_error.dart';
import 'package:ideal_atm/main/business/models/use_cases/response_status.dart';
import 'package:ideal_atm/main/business/use_cases/requests.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> with BlocUtils {
  AuthBloc()
      : _interface = PresentationInterfaceImpl(),
        _requestHandler = Requests(),
        _validator = Validator(),
        super(const AuthState()) {
    on<AuthDataSubmitted>(_onAuthDataSubmitted);
    on<AuthFieldChanged>(_onAuthFieldChanged);
    on<AuthFieldFocused>(_onAuthFieldFocused);
    on<AuthFieldUnfocused>(_onAuthFieldUnfocused);
    on<ChangeLoginType>(_onChangeLoginType);
    on<AuthErrorWasShown>(_onAuthErrorWasShown);
  }

  final PresentationInterfaceImpl _interface;
  final Requests _requestHandler;
  final Validator _validator;

  void _onAuthErrorWasShown(AuthErrorWasShown event, Emitter<AuthState> emit) {
    emit(state.copyWith(
        responseStatus: state.responseStatus.resetError()));
  }

  void _onChangeLoginType(ChangeLoginType event, Emitter<AuthState> emit) {
    emit(state.copyWith(
        loginType: state.loginType == FieldType.email
            ? FieldType.phone
            : FieldType.email,
        fieldsProps: {
          FieldType.phone: state.fieldsProps[FieldType.phone]?.reset(),
          FieldType.email: state.fieldsProps[FieldType.email]?.reset()
        }));
  }

  void _onAuthFieldChanged(AuthFieldChanged event, Emitter<AuthState> emit) {
    emit(state.copyWith(fieldsProps: {
      event.fieldType: state.fieldsProps[event.fieldType]
          ?.copyWith(fieldValue: event.fieldText)
    }));
  }

  void _onAuthFieldFocused(AuthFieldFocused event, Emitter<AuthState> emit) {
    if (state.fieldsProps[event.fieldType]?.fieldError != FieldError.none) {
      emit(state.copyWith(fieldsProps: {
        event.fieldType: state.fieldsProps[event.fieldType]
            ?.copyWith(fieldError: FieldError.none)
      }));
    }
  }

  void _onAuthFieldUnfocused(
      AuthFieldUnfocused event, Emitter<AuthState> emit) {
    FieldError? error;
    if (event.fieldType != FieldType.password) {
      error = _validator.validateField(
          event.fieldType, state.fieldsProps[event.fieldType]?.fieldValue);
    } else {
      error = _validator
          .validateIfEmpty(state.fieldsProps[FieldType.password]?.fieldValue);
    }
    if (error != null) {
      emit(state.copyWith(
        fieldsProps: {
          event.fieldType:
              state.fieldsProps[event.fieldType]?.copyWith(fieldError: error)
        },
      ));
    }
  }

  Future<void> _onAuthDataSubmitted(
      AuthDataSubmitted event, Emitter<AuthState> emit) async {
    Map<FieldType, TextFieldProps?> request = {
      state.loginType: state.fieldsProps[state.loginType],
      FieldType.password: state.fieldsProps[FieldType.password]
    };
    Map<FieldType, FieldError>? errors =
        _validator.validateCreds(convertPropsMapToStringMap(request));
    if (errors != null) {
      emit(state.copyWith(
          fieldsProps: updateFieldsPropsWithErrors(errors, request)));
    } else {
      emit(state.copyWith(
          responseStatus: state.responseStatus
              .copyWith(status: ResponseStatusType.inProgress)));

      ResponseError? response = _interface.handleAuthResponse(
          await _requestHandler.handleAuthRequest(_interface
              .userDataToDomain(convertPropsMapToStringMap(request))));

      if (response != null) {
        emit(state.copyWith(
            fieldsProps: handleResponseErrorBody(response, request),
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
