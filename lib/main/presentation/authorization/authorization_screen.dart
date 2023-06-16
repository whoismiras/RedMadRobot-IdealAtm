import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ideal_atm/core/constants/app_assets.dart';
import 'package:ideal_atm/main/business/bloc/user_state/user_bloc.dart';
import 'package:ideal_atm/main/business/models/layout/navigatable_pages.dart';
import 'package:ideal_atm/main/business/models/layout/text_field_model.dart';
import 'package:ideal_atm/main/presentation/authorization/auth_screen_widgets/login_type_selection_button.dart';
import 'package:ideal_atm/main/presentation/utils/app_router.dart';
import 'package:ideal_atm/main/presentation/utils/design_widget_constants.dart';
import 'package:ideal_atm/main/presentation/utils/response_status_handler.dart';
import 'package:ideal_atm/main/presentation/widgets/app_widgets/app_bar.dart';
import 'package:ideal_atm/main/presentation/widgets/app_widgets/auth_reg_button.dart';
import 'package:ideal_atm/main/presentation/widgets/app_widgets/custom_nav_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:ideal_atm/main/business/bloc/auth/auth_bloc.dart';
import 'package:ideal_atm/main/presentation/widgets/app_widgets/reg_auth_textfield.dart';

class AuthorizationScreen extends StatefulWidget {
  const AuthorizationScreen({Key? key}) : super(key: key);

  @override
  State<AuthorizationScreen> createState() => _AuthorizationScreenState();
}

class _AuthorizationScreenState extends State<AuthorizationScreen> {
  late AuthBloc _authBloc;
  late UserBloc _userBloc;

  @override
  void initState() {
    _authBloc = AuthBloc();
    _userBloc = BlocProvider.of<UserBloc>(context);
    super.initState();
  }

  _focusChangeCallback(FieldType fieldType, bool hasFocus) {
    hasFocus
        ? _authBloc.add(AuthFieldFocused(fieldType))
        : _authBloc.add(AuthFieldUnfocused(fieldType));
  }

  _onChangeCallback(FieldType fieldType, String? fieldText) {
    _authBloc.add(AuthFieldChanged(fieldType, fieldText));
  }

  _changeLoginType() => _authBloc.add(ChangeLoginType());

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
        bloc: _authBloc,
        listener: (context, state) {
          handleResponseStatus(context,
              responseStatus: state.responseStatus,
              onCompleted: () {
                _userBloc.add(UserLoggedIn());
                AppRouter.toHomePage(context);
              },
              onErrorShown: () => _authBloc.add(AuthErrorWasShown()));
        },
        builder: (context, state) {
          return GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: Scaffold(
              appBar: const CustomAppBar(),
              bottomNavigationBar: const BottomNavBar(
                navPage: NavPages.userProfileScreen,
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding: authScreenScrollViewPadding,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: authScreenTopSpacer,
                      ),
                      Padding(
                        padding: authScreenBankLogoPadding,
                        child: SvgPicture.asset(
                          AppAssets.idealBankLogoBig,
                          color: Theme.of(context).colorScheme.onPrimary,
                          width: authScreenBankLogoWidth,
                        ),
                      ),
                      const SizedBox(
                        height: authScreenSecondSpacer,
                      ),
                      Padding(
                        padding: authScreenSelectorButtonGroupWidgetPadding,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            LoginTypeSelectorButton(
                              loginTypeText:
                                  AppLocalizations.of(context).loginWithEmail,
                              event: () => _changeLoginType(),
                              fieldType: FieldType.email,
                              loginType: state.loginType,
                            ),
                            LoginTypeSelectorButton(
                              loginTypeText:
                                  AppLocalizations.of(context).loginWithPhone,
                              event: () => _changeLoginType(),
                              fieldType: FieldType.phone,
                              loginType: state.loginType,
                            ),
                          ],
                        ),
                      ),
                      CustomTextField(
                        key: ValueKey(state.loginType),
                        textFieldProps: state.fieldsProps[state.loginType],
                        fieldType: state.loginType,
                        focusChangeCallback: _focusChangeCallback,
                        onChangedCallBack: _onChangeCallback,
                      ),
                      CustomTextField(
                        textFieldProps: state.fieldsProps[FieldType.password],
                        fieldType: FieldType.password,
                        canBeObscured: true,
                        focusChangeCallback: _focusChangeCallback,
                        onChangedCallBack: _onChangeCallback,
                      ),
                      CustomRoundedButton(
                        buttonText: AppLocalizations.of(context).login,
                        onPressed: () {
                          FocusManager.instance.primaryFocus?.unfocus();
                          _authBloc.add(AuthDataSubmitted());
                        },
                      ),
                      CustomRoundedButton(
                        buttonText: AppLocalizations.of(context).register,
                        onPressed: () {
                          AppRouter.toReg(context);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
