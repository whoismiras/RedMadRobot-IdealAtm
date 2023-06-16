import 'package:flutter/cupertino.dart';
import 'package:ideal_atm/main/business/models/layout/text_field_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:ideal_atm/main/presentation/utils/text_fields_utils/text_field_error_dictionary.dart';

enum TextFieldPart { label, hint, error }

Map<TextFieldPart, String?> textFieldDictionary(
    BuildContext context, FieldType fieldType, FieldError? fieldError) {
  Map<TextFieldPart, String?> fieldProps = {};
  switch (fieldType) {
    case FieldType.firstName:
      fieldProps.addAll({
        TextFieldPart.label: AppLocalizations.of(context).name,
        TextFieldPart.hint: AppLocalizations.of(context).nameHint
      });
      break;
    case FieldType.middleName:
      fieldProps.addAll({
        TextFieldPart.label: AppLocalizations.of(context).middlename,
        TextFieldPart.hint: AppLocalizations.of(context).middlenameHint
      });
      break;
    case FieldType.lastName:
      fieldProps.addAll({
        TextFieldPart.label: AppLocalizations.of(context).surname,
        TextFieldPart.hint: AppLocalizations.of(context).surnameHint
      });
      break;
    case FieldType.email:
      fieldProps.addAll({
        TextFieldPart.label: AppLocalizations.of(context).email,
        TextFieldPart.hint: AppLocalizations.of(context).emailHint
      });
      break;
    case FieldType.phone:
      fieldProps.addAll({
        TextFieldPart.label: AppLocalizations.of(context).phone_number,
        TextFieldPart.hint: AppLocalizations.of(context).phone_numberHint
      });
      break;
    case FieldType.password:
      fieldProps.addAll({
        TextFieldPart.label: AppLocalizations.of(context).password,
        TextFieldPart.hint: AppLocalizations.of(context).passwordHint
      });
      break;
    case FieldType.repPassword:
      fieldProps.addAll({
        TextFieldPart.label: AppLocalizations.of(context).repPassword,
        TextFieldPart.hint: AppLocalizations.of(context).repPassword
      });
      break;
    case FieldType.iin:
      fieldProps.addAll({
        TextFieldPart.label: AppLocalizations.of(context).iin,
        TextFieldPart.hint: AppLocalizations.of(context).iinHint
      });
      break;
    case FieldType.birthDate:
      fieldProps.addAll({
        TextFieldPart.label: AppLocalizations.of(context).dob,
        TextFieldPart.hint: AppLocalizations.of(context).dobHint
      });
      break;
  }
  fieldProps.addAll({
    TextFieldPart.error:
        textFieldErrorDictionary(context, fieldType, fieldError)
  });
  return fieldProps;
}
