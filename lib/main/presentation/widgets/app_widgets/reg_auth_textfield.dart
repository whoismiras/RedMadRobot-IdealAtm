import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ideal_atm/main/business/models/layout/text_field_model.dart';
import 'package:ideal_atm/main/presentation/utils/design_widget_constants.dart';
import 'package:ideal_atm/main/presentation/utils/text_fields_utils/text_field_dictionary.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class CustomTextField extends StatefulWidget {
  final FieldType fieldType;
  final TextFieldProps? textFieldProps;
  final Function focusChangeCallback;
  final Function onChangedCallBack;
  final bool canBeObscured;

  const CustomTextField({
    Key? key,
    required this.fieldType,
    required this.textFieldProps,
    this.canBeObscured = false,
    required this.onChangedCallBack,
    required this.focusChangeCallback,
  }) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  TextEditingController controller = TextEditingController();
  late bool isObscured;
  String? label;

  @override
  void initState() {
    isObscured = widget.canBeObscured ? true : false;
    label = null;
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    InputBorder fieldBorder = OutlineInputBorder(
        borderSide: BorderSide(
            color: Theme.of(context).colorScheme.outline,
            width: textFieldBorderWidth),
        borderRadius: BorderRadius.circular(textFieldBorderRadius));

    Map<TextFieldPart, String?> textFieldValues = textFieldDictionary(
        context, widget.fieldType, widget.textFieldProps?.fieldError);
    String? hintText = textFieldValues[TextFieldPart.hint];
    String? labelText = textFieldValues[TextFieldPart.label];
    String? error = textFieldValues[TextFieldPart.error];

    label = controller.text == '' ? null : labelText;

    List<TextInputFormatter> inputFormatters = [];
    TextInputType textInputType = TextInputType.text;

    if (widget.fieldType == FieldType.iin) {
      textInputType = TextInputType.number;
      inputFormatters = [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(12)
      ];
    } else if (widget.fieldType == FieldType.phone) {
      textInputType = TextInputType.number;
      var maskFormatter = MaskTextInputFormatter(
          initialText: controller.text,
          mask: '+# (###) ###-##-##',
          filter: {"#": RegExp(r'[0-9]')},
          type: MaskAutoCompletionType.lazy);
      inputFormatters = [maskFormatter];
    } else if (widget.fieldType == FieldType.birthDate) {
      textInputType = TextInputType.none;
    }

    return Padding(
      padding: textFieldPadding,
      child: Focus(
        onFocusChange: (hasFocus) async {
          if (hasFocus) {
            if (widget.fieldType == FieldType.birthDate) {
              widget.focusChangeCallback(widget.fieldType, true);
              DateTime? birthDate = await showDatePicker(
                  context: context,
                  initialEntryMode: DatePickerEntryMode.input,
                  initialDatePickerMode: DatePickerMode.year,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(textFieldTheEarliestPickYear),
                  lastDate: DateTime.now());
              if (birthDate != null) {
                controller.text = DateFormat('yyyy-MM-dd').format(birthDate);
              }
              FocusManager.instance.primaryFocus?.unfocus();
              widget.onChangedCallBack(widget.fieldType, controller.text);
              widget.focusChangeCallback(widget.fieldType, false);
            } else {
              widget.focusChangeCallback(widget.fieldType, hasFocus);
            }
          } else {
            if (widget.fieldType != FieldType.birthDate) {
              widget.focusChangeCallback(widget.fieldType, hasFocus);
            } else {
              FocusManager.instance.primaryFocus?.unfocus();
            }
          }
        },
        child: TextFormField(
          onChanged: (fieldText) {
            if (widget.fieldType == FieldType.phone) {
              widget.onChangedCallBack(widget.fieldType,
                  controller.text.replaceAll(RegExp('[^0-9]'), ''));
            } else {
              widget.onChangedCallBack(widget.fieldType, controller.text);
            }
          },
          keyboardType: textInputType,
          inputFormatters: inputFormatters,
          textAlign: TextAlign.center,
          controller: controller,
          obscureText: isObscured,
          decoration: InputDecoration(
              filled: true,
              fillColor: Theme.of(context).colorScheme.primaryContainer,
              errorBorder: fieldBorder,
              enabledBorder: fieldBorder,
              focusedBorder: fieldBorder,
              floatingLabelAlignment: FloatingLabelAlignment.center,
              floatingLabelStyle: TextStyle(
                  fontSize: textFieldLabelFontSize,
                  color: Theme.of(context).colorScheme.onPrimary),
              labelStyle: TextStyle(
                  color: Theme.of(context).colorScheme.inversePrimary),
              errorText: error,
              hintText: hintText,
              labelText: label,
              iconColor: Theme.of(context).colorScheme.primary,
              prefixIcon: !widget.canBeObscured
                  ? null
                  : const SizedBox(
                      width: textFieldIconSpacer,
                    ),
              suffixIcon: !widget.canBeObscured
                  ? null
                  : IconButton(
                      onPressed: () {
                        setState(() {
                          isObscured = !isObscured;
                        });
                      },
                      icon: Icon(
                        isObscured ? Icons.visibility : Icons.visibility_off,
                        color: Theme.of(context).colorScheme.outline,
                      ),
                    )),
        ),
      ),
    );
  }
}
