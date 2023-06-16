import 'package:flutter/material.dart';
import 'package:ideal_atm/main/presentation/registration/reg_screen_widgets/personal_data_usage_agreement_widget.dart';
import 'package:ideal_atm/main/presentation/utils/app_router.dart';
import 'package:ideal_atm/main/presentation/utils/design_widget_constants.dart';
import 'package:ideal_atm/main/presentation/utils/response_status_handler.dart';
import 'package:ideal_atm/main/presentation/widgets/app_widgets/app_bar.dart';
import 'package:ideal_atm/main/presentation/widgets/app_widgets/auth_reg_button.dart';
import 'package:ideal_atm/main/presentation/widgets/app_widgets/custom_nav_bar.dart';
import 'package:ideal_atm/main/presentation/widgets/app_widgets/reg_auth_textfield.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ideal_atm/main/business/models/layout/navigatable_pages.dart';
import 'package:ideal_atm/main/business/models/layout/text_field_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:ideal_atm/main/business/bloc/registration/reg_bloc.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  late RegBloc _bloc;

  @override
  void initState() {
    _bloc = RegBloc();
    super.initState();
  }

  _focusChangeCallback(FieldType fieldType, bool hasFocus) {
    hasFocus
        ? _bloc.add(RegFieldFocused(fieldType))
        : _bloc.add(RegFieldUnfocused(fieldType));
  }

  _onChangeCallback(FieldType fieldType, String? fieldText) {
    _bloc.add(RegFieldChanged(fieldType, fieldText));
  }

  _onCheckBoxChangeCallback(bool isChecked) {
    _bloc.add(RegCheckBoxChanged(isChecked));
  }

  @override
  Widget build(BuildContext context) {
    final passwordHintSnack = SnackBar(
        content: Text(
      AppLocalizations.of(context).passwordEntryHint,
      style: regScreenPasswordHintTextStyle,
      textAlign: TextAlign.center,
    ));
    return BlocConsumer<RegBloc, RegState>(
        bloc: _bloc,
        listener: (context, state) {
          if (state.showPasswordWarning) {
            ScaffoldMessenger.of(context).showSnackBar(passwordHintSnack);
            _bloc.add(HidePasswordWarning());
          }
          handleResponseStatus(context,
              responseStatus: state.responseStatus,
              onCompleted: () => AppRouter.back(context),
              onErrorShown: () => _bloc.add(RegErrorWasShown()));
        },
        builder: (context, state) {
          return GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: Scaffold(
              appBar: CustomAppBar(
                titleWidget: Text(
                  AppLocalizations.of(context).welcomeMessage,
                  maxLines: regScreenAppBarTextMaxLines,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              bottomNavigationBar: const BottomNavBar(
                navPage: NavPages.userProfileScreen,
              ),
              body: Column(
                children: [
                  Flexible(
                    child: RawScrollbar(
                      trackColor: Theme.of(context).colorScheme.primary,
                      thumbColor: Theme.of(context).colorScheme.outline,
                      padding: regScreenScrollBarPadding,
                      radius: regScreenScrollBarRadius,
                      trackVisibility: true,
                      thumbVisibility: true,
                      child: Padding(
                        padding: regScreenBodyPadding,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              CustomTextField(
                                fieldType: FieldType.lastName,
                                textFieldProps:
                                    state.fieldsProps[FieldType.lastName],
                                focusChangeCallback: _focusChangeCallback,
                                onChangedCallBack: _onChangeCallback,
                              ),
                              CustomTextField(
                                fieldType: FieldType.firstName,
                                textFieldProps:
                                    state.fieldsProps[FieldType.firstName],
                                focusChangeCallback: _focusChangeCallback,
                                onChangedCallBack: _onChangeCallback,
                              ),
                              CustomTextField(
                                fieldType: FieldType.middleName,
                                textFieldProps:
                                    state.fieldsProps[FieldType.middleName],
                                focusChangeCallback: _focusChangeCallback,
                                onChangedCallBack: _onChangeCallback,
                              ),
                              CustomTextField(
                                fieldType: FieldType.email,
                                textFieldProps:
                                    state.fieldsProps[FieldType.email],
                                focusChangeCallback: _focusChangeCallback,
                                onChangedCallBack: _onChangeCallback,
                              ),
                              CustomTextField(
                                fieldType: FieldType.password,
                                canBeObscured: true,
                                textFieldProps:
                                    state.fieldsProps[FieldType.password],
                                focusChangeCallback: _focusChangeCallback,
                                onChangedCallBack: _onChangeCallback,
                              ),
                              CustomTextField(
                                fieldType: FieldType.repPassword,
                                canBeObscured: true,
                                textFieldProps:
                                    state.fieldsProps[FieldType.repPassword],
                                focusChangeCallback: _focusChangeCallback,
                                onChangedCallBack: _onChangeCallback,
                              ),
                              CustomTextField(
                                fieldType: FieldType.birthDate,
                                textFieldProps:
                                    state.fieldsProps[FieldType.birthDate],
                                focusChangeCallback: _focusChangeCallback,
                                onChangedCallBack: _onChangeCallback,
                              ),
                              CustomTextField(
                                fieldType: FieldType.iin,
                                textFieldProps:
                                    state.fieldsProps[FieldType.iin],
                                focusChangeCallback: _focusChangeCallback,
                                onChangedCallBack: _onChangeCallback,
                              ),
                              CustomTextField(
                                fieldType: FieldType.phone,
                                textFieldProps:
                                    state.fieldsProps[FieldType.phone],
                                focusChangeCallback: _focusChangeCallback,
                                onChangedCallBack: _onChangeCallback,
                              ),
                              AgreementWidget(
                                isChecked: state.dataUsageAgreed,
                                showWarning: state.showAgreementWarning,
                                checkBoxEvent: _onCheckBoxChangeCallback,
                              ),
                              CustomRoundedButton(
                                buttonText:
                                    AppLocalizations.of(context).register,
                                onPressed: () {
                                  FocusManager.instance.primaryFocus?.unfocus();
                                  _bloc.add(RegDataSubmitted());
                                },
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
