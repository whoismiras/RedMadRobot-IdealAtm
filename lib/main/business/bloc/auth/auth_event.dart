part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthFieldFocused extends AuthEvent {
  final FieldType fieldType;

  const AuthFieldFocused(this.fieldType);
}

class AuthFieldUnfocused extends AuthEvent {
  final FieldType fieldType;

  const AuthFieldUnfocused(this.fieldType,);
}

class AuthFieldChanged extends AuthEvent {
  final String? fieldText;
  final FieldType fieldType;

  const AuthFieldChanged(this.fieldType, this.fieldText);
}

class AuthErrorWasShown extends AuthEvent {}

class ChangeLoginType extends AuthEvent {}

class AuthDataSubmitted extends AuthEvent {}
