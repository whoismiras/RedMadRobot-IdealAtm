import 'package:flutter/material.dart';
import 'package:ideal_atm/core/constants/app_styles.dart';
import 'package:ideal_atm/main/presentation/utils/design_widget_constants.dart';

class CustomRoundedButton extends StatelessWidget {
  const CustomRoundedButton({
    Key? key,
    required this.buttonText,
    this.onPressed,
  }) : super(key: key);
  final String buttonText;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: customRoundedButtonPadding,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: SizedBox(
          width: double.infinity,
          height: customRoundedButtonHeight,
          child: MaterialButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(customRoundedButtonRadius)),
            color: Theme.of(context).colorScheme.primary,
            padding: EdgeInsets.zero,
            child: Text(
              buttonText,
              style: AppStyles.s16w700.copyWith(
                  fontSize: customRoundedButtonFontSize,
                  color: Theme.of(context).colorScheme.onPrimary),
            ),
            onPressed: () {
              if (onPressed != null) {
                onPressed!();
              }
            },
          ),
        ),
      ),
    );
  }
}
