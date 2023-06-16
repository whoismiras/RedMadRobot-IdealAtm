import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ideal_atm/core/services/alert_controller.dart';
import 'package:ideal_atm/main/business/cubit/internet_cubit/internet_cubit.dart';
import 'package:ideal_atm/main/business/cubit/internet_cubit/internet_state.dart';
import 'package:ideal_atm/main/business/models/layout/navigatable_pages.dart';
import 'package:ideal_atm/main/presentation/home_screen/home_screen_widgets/card_ad_widget.dart';
import 'package:ideal_atm/main/presentation/home_screen/home_screen_widgets/carousel.dart';
import 'package:ideal_atm/main/presentation/home_screen/home_screen_widgets/change_lang_button.dart';
import 'package:ideal_atm/main/presentation/home_screen/home_screen_widgets/ideal_bank_logo.dart';
import 'package:ideal_atm/main/presentation/home_screen/home_screen_widgets/news_feed_widget.dart';
import 'package:ideal_atm/main/presentation/home_screen/home_screen_widgets/onWillPopHandler.dart';
import 'package:ideal_atm/main/presentation/widgets/app_widgets/app_bar.dart';
import 'package:ideal_atm/main/presentation/widgets/app_widgets/custom_nav_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late OnWillPopHandler onWillPopHandler;

  @override
  void initState() {
    onWillPopHandler = OnWillPopHandler();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => onWillPopHandler.handlePop(context),
      child: GestureDetector(
        onTap: FocusScope.of(context).hasFocus
            ? () => FocusScope.of(context).unfocus()
            : null,
        child: BlocListener<InternetCubit, InternetState>(
          listener: (context, state) {
            switch (state.type) {
              case InternetTypes.offline:
                AlertController.showMessage(
                  context: context,
                  content: 'No Internet Connection',
                );
                break;
              default:
            }
          },
          child: Scaffold(
            appBar: const CustomAppBar(
              elevation: 0,
              isPoppable: false,
              actions: [ChangeLangButton()],
            ),
            floatingActionButton: const QRScreenFloatingActionButton(),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            bottomNavigationBar: const BottomNavBar(
              navPage: NavPages.homeScreen,
              isFABPresent: true,
            ),
            extendBody: true,
            body: Column(
              children: const [
                BankLogo(),
                CardADWidget(),
                CarouselWidget(),
                NewsFeedWidget()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
