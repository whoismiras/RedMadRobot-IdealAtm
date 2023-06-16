import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ideal_atm/core/constants/app_assets.dart';
import 'package:ideal_atm/main/business/bloc/user_state/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:ideal_atm/main/business/models/layout/navigatable_pages.dart';
import 'package:ideal_atm/main/presentation/utils/app_router.dart';
import 'package:ideal_atm/main/presentation/utils/design_widget_constants.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar(
      {Key? key, required this.navPage, this.isFABPresent = false})
      : super(key: key);
  final NavPages navPage;
  final bool isFABPresent;

  @override
  Widget build(BuildContext context) {
    UserBloc bloc = BlocProvider.of<UserBloc>(context);
    List<Widget> bottomAppBarItems = [
      BottomNavBarButton(
          icon: Icons.home_filled,
          route: () => AppRouter.toHomePage(context),
          isActive: navPage == NavPages.homeScreen ? true : false),
      BottomNavBarButton(
          icon: Icons.location_on,
          route: () => AppRouter.toMapScreen(context),
          isActive: navPage == NavPages.findATMScreen ? true : false),
      BottomNavBarButton(
          icon: Icons.payments,
          route: () {},
          isActive: navPage == NavPages.payments ? true : false),
      BottomNavBarButton(
          icon: Icons.person,
          route: () => bloc.state.loginState == LoginState.loggedIn
              ? AppRouter.toProfile(context)
              : AppRouter.toAuth(context),
          isActive: navPage == NavPages.userProfileScreen ? true : false),
    ];
    if (isFABPresent) {
      bottomAppBarItems.insert(
          2,
          const SizedBox(
            width: bottomNavBarSpacer,
          ));
    }
    return ClipRRect(
      borderRadius: bottomNavBarCornersRadius,
      child: Theme(
        data: ThemeData(
            bottomAppBarTheme: BottomAppBarTheme(
                color: Theme.of(context).colorScheme.secondary)),
        child: BottomAppBar(
          padding: bottomNavBarPadding,
          elevation: bottomNavBarElevation,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: bottomAppBarItems,
          ),
        ),
      ),
    );
  }
}

class BottomNavBarButton extends StatelessWidget {
  const BottomNavBarButton(
      {Key? key,
      required this.icon,
      required this.route,
      required this.isActive})
      : super(key: key);
  final dynamic icon;
  final VoidCallback route;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    Color inactiveColor;
    Color activeColor;
    double iconSplashRadius = bottomNavBarIconSplashRadius;
    var brightness = MediaQuery.of(context).platformBrightness;
    if (brightness == Brightness.light) {
      inactiveColor = Colors.black.withOpacity(bottomNavBarColorOpacity);
      activeColor = Colors.black;
    } else {
      inactiveColor = Theme.of(context).colorScheme.onPrimary.withOpacity(bottomNavBarColorOpacity);
      activeColor = Theme.of(context).colorScheme.onPrimary;
    }
    return Material(
      color: Colors.transparent,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(iconSplashRadius)),
      child: InkWell(
          borderRadius: BorderRadius.circular(iconSplashRadius),
          onTap: () => isActive ? {} : route(),
          child: Container(
              decoration: const BoxDecoration(shape: BoxShape.circle),
              width: iconSplashRadius * 2,
              height: iconSplashRadius * 2,
              child: icon is IconData
                  ? Icon(
                      icon,
                      color: isActive ? activeColor : inactiveColor,
                      size: 30,
                    )
                  : SvgPicture.asset(
                      icon,
                      color: isActive ? activeColor : inactiveColor,
                      width: 30,
                      height: 30,
                    ))),
    );
  }
}

class QRScreenFloatingActionButton extends StatelessWidget {
  const QRScreenFloatingActionButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double qrIconSize = 35;
    return FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        child: SvgPicture.asset(
          AppAssets.qrCodeIcon,
          color: Theme.of(context).colorScheme.onPrimary,
          fit: BoxFit.cover,
          height: qrIconSize,
          width: qrIconSize,
        ),
        onPressed: () => AppRouter.toScanQr(context));
  }
}
