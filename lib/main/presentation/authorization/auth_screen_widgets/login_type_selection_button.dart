import 'package:flutter/material.dart';
import 'package:ideal_atm/main/business/models/layout/text_field_model.dart';
import 'package:ideal_atm/main/presentation/utils/design_widget_constants.dart';

class LoginTypeSelectorButton extends StatelessWidget {
  final String loginTypeText;
  final VoidCallback event;
  final FieldType fieldType;
  final FieldType loginType;

  const LoginTypeSelectorButton({
    Key? key,
    required this.loginTypeText,
    required this.event,
    required this.fieldType,
    required this.loginType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextDecoration textDecoration =
        fieldType == loginType ? TextDecoration.underline : TextDecoration.none;
    return Expanded(
      child: Padding(
        padding: loginTypeSelectorButtonPadding,
        child: GestureDetector(
          onTap: () {
            if (fieldType != loginType) {
              FocusManager.instance.primaryFocus?.unfocus();
              event();
            }
          },
          child: Text(
            loginTypeText,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Theme.of(context).colorScheme.onPrimary,
                fontSize: loginTypeSelectorButtonFontSize,
                decoration: textDecoration,
                decorationColor: Theme.of(context).colorScheme.outline,
                decorationThickness: loginTypeSelectorButtonUnderlineWidth),
          ),
        ),
      ),
    );
  }
}
