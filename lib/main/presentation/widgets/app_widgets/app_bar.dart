import 'package:flutter/material.dart';
import 'package:ideal_atm/main/presentation/utils/app_router.dart';
import 'package:ideal_atm/main/presentation/utils/design_widget_constants.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  const CustomAppBar(
      {Key? key,
      this.titleWidget,
      this.leadingWidget,
      this.isPoppable = true,
      this.leadingWight,
      this.actions,
      this.elevation})
      : super(key: key);
  final Widget? leadingWidget;
  final double? leadingWight;
  final bool isPoppable;
  final Widget? titleWidget;
  final List<Widget>? actions;
  final double? elevation;

  @override
  Size get preferredSize => const Size.fromHeight(appBarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      scrolledUnderElevation: elevation,
      centerTitle: true,
      title: titleWidget,
      automaticallyImplyLeading: false,
      leading: isPoppable ? const AppBarBackButton() : leadingWidget,
      leadingWidth: leadingWight,
      actions: actions,
    );
  }
}

class AppBarBackButton extends StatelessWidget {
  const AppBarBackButton({Key? key, this.customRoute}) : super(key: key);
  final VoidCallback? customRoute;

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () => customRoute ?? AppRouter.back(context),
        icon: Icon(Icons.arrow_back_ios,
            color: Theme.of(context).colorScheme.onSurface));
  }
}
