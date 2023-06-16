part of 'reg_bloc.dart';

abstract class RegEvent extends Equatable {
  const RegEvent();

  @override
  List<Object> get props => [];
}

class RegCheckBoxChanged extends RegEvent {
  final bool isChecked;

  const RegCheckBoxChanged(this.isChecked);
}

class RegDataSubmitted extends RegEvent {}

class RegFieldChanged extends RegEvent {
  final String? fieldText;
  final FieldType fieldType;

  const RegFieldChanged(this.fieldType, this.fieldText);
}

class RegFieldFocused extends RegEvent {
  final FieldType fieldType;

  const RegFieldFocused(this.fieldType);
}

class RegFieldUnfocused extends RegEvent {
  final FieldType fieldType;

  const RegFieldUnfocused(this.fieldType);
}

class RegErrorWasShown extends RegEvent {}

class HidePasswordWarning extends RegEvent {}