import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ideal_atm/core/constants/app_colors.dart';

import 'package:ideal_atm/main/business/bloc/user_state/user_bloc.dart';
import 'package:ideal_atm/main/business/models/layout/navigatable_pages.dart';
import 'package:ideal_atm/main/presentation/profile/app_bar_leading_profile.dart';
import 'package:ideal_atm/main/presentation/utils/app_router.dart';
import 'package:ideal_atm/main/presentation/widgets/app_widgets/app_bar.dart';
import 'package:ideal_atm/main/presentation/widgets/app_widgets/custom_nav_bar.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {
        if (state.loginState == LoginState.loggedOff) {
          AppRouter.toHomePage(context);
        }
      },
      child: Scaffold(
          appBar: const CustomAppBar(actions: [AppBarLeadingProfileScreen()]),
          bottomNavigationBar: const BottomNavBar(
            navPage: NavPages.userProfileScreen,
          ),
          body: Padding(
            padding: const EdgeInsets.fromLTRB(15, 10, 10, 10),
            child: Column(
              children: const [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Добро пожаловать \n Тут могла быть ваша реклама',
                    style: TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                ),
                ProfileTextField(
                  isEditable: true,
                  initialText: 'Взять Email с модели',
                  icon: Icons.mail,
                ),
                ProfileTextField(
                    isEditable: true,
                    initialText: 'Взять пароль с модели',
                    icon: Icons.key),
                ProfileTextField(
                    isEditable: true,
                    initialText: 'Взять телефон с модели',
                    icon: Icons.phone),
              ],
            ),
          )),
    );
  }
}

class ProfileTextField extends StatefulWidget {
  const ProfileTextField(
      {Key? key, this.icon, this.isEditable = false, this.initialText})
      : super(key: key);
  final bool isEditable;
  final IconData? icon;
  final String? initialText;

  @override
  State<ProfileTextField> createState() => _ProfileTextFieldState();
}

//#TODO convert to stateless when BLoc is added
class _ProfileTextFieldState extends State<ProfileTextField> {
  final TextEditingController controller = TextEditingController();
  bool wantsToBeEdited = false;
  Color fieldBackGroundColor = AppColors.grey;
  double iconsSize = 20;
  final FocusNode fieldFocus = FocusNode();

  @override
  void dispose() {
    fieldFocus.dispose();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    controller.text = widget.initialText == null ? '' : widget.initialText!;
    double iconsSize = 30;
    Widget trailing = widget.isEditable
        ? IconButton(
            iconSize: iconsSize,
            onPressed: () {
              //#TODO Add Bloc callback, SetState is TEMP
              setState(() {
                if (wantsToBeEdited == false) {
                  wantsToBeEdited = true;
                  fieldBackGroundColor = AppColors.white;
                  WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                    FocusScope.of(context).requestFocus(fieldFocus);
                  });
                } else {
                  wantsToBeEdited = false;
                  fieldBackGroundColor = AppColors.grey;
                }
              });
            },
            icon: const Icon(
              Icons.edit,
            ))
        : IconButton(onPressed: () {}, icon: const Icon(null));
    return Padding(
      padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            widget.icon,
            size: iconsSize,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 10),
            child: Container(
              width: 250,
              decoration: BoxDecoration(
                color: fieldBackGroundColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextFormField(
                focusNode: fieldFocus,
                initialValue: controller.text,
                enabled: wantsToBeEdited,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          trailing,
        ],
      ),
    );
  }
}
