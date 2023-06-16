import 'package:flutter/material.dart';
import 'package:ideal_atm/main/business/models/layout/text_field_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

String? textFieldErrorDictionary(
    BuildContext context, FieldType fieldType, FieldError? fieldError) {
  switch (fieldType) {
    case FieldType.firstName:
    case FieldType.middleName:
    case FieldType.lastName:
      switch (fieldError) {
        case FieldError.empty:
          return AppLocalizations.of(context).errorNameEmpty;
        case FieldError.invalid:
          return AppLocalizations.of(context).errorNameFormat;
        case FieldError.rejected:
          return AppLocalizations.of(context).errorNameAlreadyExists;
        default:
          return null;
      }
    case FieldType.email:
      switch (fieldError) {
        case FieldError.empty:
          return AppLocalizations.of(context).errorEmailEmpty;
        case FieldError.invalid:
          return AppLocalizations.of(context).errorEmailFormat;
        case FieldError.rejected:
          return AppLocalizations.of(context).errorEmailAlreadyExists;
        case FieldError.mismatch:
          return AppLocalizations.of(context).errorWrongLoginPassword;
        default:
          return null;
      }
    case FieldType.phone:
      switch (fieldError) {
        case FieldError.empty:
          return AppLocalizations.of(context).errorPhoneEmpty;
        case FieldError.invalid:
          return AppLocalizations.of(context).errorPhoneFormat;
        case FieldError.rejected:
          return AppLocalizations.of(context).errorPhoneAlreadyExists;
        case FieldError.mismatch:
          return AppLocalizations.of(context).errorWrongLoginPassword;
        default:
          return null;
      }
    case FieldType.password:
      switch (fieldError) {
        case FieldError.empty:
          return AppLocalizations.of(context).errorPasswordEmpty;
        case FieldError.invalid:
          return AppLocalizations.of(context).errorPasswordInvalid;
        default:
          return null;
      }
    case FieldType.repPassword:
      switch (fieldError) {
        case FieldError.empty:
          return AppLocalizations.of(context).errorRepeatPassword;
        case FieldError.invalid:
          return AppLocalizations.of(context).errorPasswordsDoesNotMatch;
        case FieldError.rejected:
          return AppLocalizations.of(context).errorPasswordInvalid;
        case FieldError.mismatch:
          return AppLocalizations.of(context).errorPasswordsDoesNotMatch;
        default:
          return null;
      }
    case FieldType.iin:
      switch (fieldError) {
        case FieldError.empty:
          return AppLocalizations.of(context).errorIINEmpty;
        case FieldError.invalid:
          return AppLocalizations.of(context).errorIINFormat;
        case FieldError.rejected:
          return AppLocalizations.of(context).errorIINAlreadyExists;
        default:
          return null;
      }
    case FieldType.birthDate:
      switch (fieldError) {
        case FieldError.empty:
          return AppLocalizations.of(context).errorBirthDateEmpty;
        case FieldError.invalid:
          return AppLocalizations.of(context).errorBirthDateFormat;
        case FieldError.rejected:
          return AppLocalizations.of(context).errorBirthDateFormat;
        default:
          return null;
      }
  }
}