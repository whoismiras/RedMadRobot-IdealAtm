import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ideal_atm/main/presentation/utils/app_router.dart';

class AppIconButton extends StatelessWidget {
  const AppIconButton({
    super.key,
    required this.child,
    required this.onPressed,
    this.padding,
  });

  final Widget child;
  final void Function() onPressed;
  final EdgeInsets? padding;

  factory AppIconButton.back(BuildContext context,
      {void Function()? onPressed, Color? color}) {
    return AppIconButton(
      onPressed: onPressed ?? () => AppRouter.back(context),
      child: const Icon(Icons.keyboard_arrow_left_outlined),
      // SvgPicture.asset(
      //   AppAssets.arrowLeft,
      //   color: color ?? AppColors.blueDark,
      //   height: 18,
      //   width: 18,
      // ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: padding ?? const EdgeInsets.all(8),
      onPressed: onPressed,
      child: child,
    );
  }
}
