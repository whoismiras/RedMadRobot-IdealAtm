import 'package:flutter/material.dart';

///
///HomeScreen Widget Constants
///
///Card&Ad Widget
    ///Card Widget
const int cardSliderInitPage = 0;
const double cardSliderViewportFraction = 1;
const int cardSliderTotalPages = 3;
const EdgeInsetsGeometry cardWidgetVerticalPadding = EdgeInsets.only(top: 8);
const EdgeInsetsGeometry cardWidgetInnerVerticalPadding =
    EdgeInsets.symmetric(vertical: 16);
const double cardWidgetSizedBoxHeight = 200;
const EdgeInsetsGeometry cardWidgetHorizontalPadding =
    EdgeInsets.symmetric(horizontal: 16);
    ///Ad Widget
const EdgeInsetsGeometry adWidgetPadding = EdgeInsets.only(top: 10, bottom: 20);
const double adWidgetBorderCropRadius = 15;
///Carousel Widget
const double carouselWidgetViewportFraction = 0.265;
const double carouselWidgetHeight = 120;
///CarouselButton Widget
const double carouselButtonWidgetIconSize = 50;
const double carouselButtonWidgetRadius = 50;
const double carouselButtonWidgetContainerSize = 80;
const double carouselButtonWidgetElevation = 2;
const double carouselButtonWidgetBorderWidth = 2;
const EdgeInsetsGeometry carouselButtonWidgetImagePadding = EdgeInsets.all(16);
///ChangeLangButton Widget
const EdgeInsetsGeometry changeLangButtWidgetPadding =
    EdgeInsets.only(right: 16);
const TextStyle changeLangButtWidgetFlagSize = TextStyle(fontSize: 20);
///BankLogo Widget
const EdgeInsetsGeometry bankLogoPadding = EdgeInsets.only(bottom: 10);
const double bankLogoWidth = 200;
///NewsFeed Widget
const EdgeInsetsGeometry newsFeedWidgetPadding = EdgeInsets.fromLTRB(20, 10, 10, 0);
const double newsFeedWidgetBottomSpacer = 100;
///News Widget
const EdgeInsetsGeometry newsWidgetPadding = EdgeInsets.symmetric(horizontal: 16, vertical: 8);
const double newsWidgetElevation = 2;
const EdgeInsetsGeometry newsWidgetCardPadding = EdgeInsets.all(16);
const double newsWidgetCardRadius = 10;
const EdgeInsetsGeometry newsWidgetIconPadding = EdgeInsets.symmetric(horizontal: 2);
const EdgeInsetsGeometry newsWidgetTextPadding = EdgeInsets.symmetric(horizontal: 16);
///OnWillPopHandler
const Duration onWillPopToastDuration = Duration(seconds: 2);
///
/// AuthorizationScreen Constants
///
const EdgeInsetsGeometry authScreenScrollViewPadding = EdgeInsets.all(15.0);
const double authScreenTopSpacer = 70;
const EdgeInsetsGeometry authScreenBankLogoPadding = EdgeInsets.all(8.0);
const double authScreenBankLogoWidth = 300;
const double authScreenSecondSpacer = 50;
const EdgeInsetsGeometry authScreenSelectorButtonGroupWidgetPadding = EdgeInsets.all(8.0);
///LoginTypeSelectorButtonWidget
const EdgeInsetsGeometry loginTypeSelectorButtonPadding = EdgeInsets.all(20.0);
const double loginTypeSelectorButtonFontSize = 15;
const double loginTypeSelectorButtonUnderlineWidth = 2;
///
/// RegistrationScreen Constants
///
const TextStyle regScreenPasswordHintTextStyle = TextStyle(fontSize: 20);
const int regScreenAppBarTextMaxLines = 2;
const EdgeInsets regScreenScrollBarPadding = EdgeInsets.symmetric(vertical: 8);
const Radius regScreenScrollBarRadius = Radius.circular(5);
const EdgeInsetsGeometry regScreenBodyPadding = EdgeInsets.fromLTRB(15, 0, 25, 0);
///PersonalDataAgreement Widget
const EdgeInsetsGeometry persDataAgreementWidgetPadding = EdgeInsets.fromLTRB(16, 8, 16, 8);
const TextStyle persDataAgreementWidgetClickableTextStyle = TextStyle(color: Colors.deepOrange);
const TextStyle persDataAgreementWidgetWarningTextStyle = TextStyle(color: Colors.red);
///
/// ProfileScreen Constatnts
///
/// TODO after screen rework
///

///
/// SharedWidgets
///

///TextFieldWidget
const double textFieldBorderWidth = 3;
const double textFieldBorderRadius = 50;
const EdgeInsetsGeometry textFieldPadding = EdgeInsets.fromLTRB(16, 8, 16, 8);
const int textFieldTheEarliestPickYear = 1920;
const double textFieldLabelFontSize = 20;
const double textFieldIconSpacer = 70;
///CustomRoundedButton Widget
const EdgeInsetsGeometry customRoundedButtonPadding = EdgeInsets.fromLTRB(16, 8, 16, 8);
const double customRoundedButtonHeight = 60;
const double customRoundedButtonFontSize = 20;
const double customRoundedButtonRadius = 50;
///CustomAppBar
const double appBarHeight = 52;
///BottomNavBar
const double bottomNavBarSpacer = 25;
const BorderRadiusGeometry bottomNavBarCornersRadius = BorderRadius.only(
    topLeft: Radius.circular(25), topRight: Radius.circular(25));
const bottomNavBarPadding = EdgeInsets.all(10);
const double bottomNavBarElevation = 10;
const double bottomNavBarIconSplashRadius = 30;
const double bottomNavBarColorOpacity = 0.4;
///Error dialogs
const EdgeInsetsGeometry errorDialogMessagePadding = EdgeInsets.fromLTRB(18, 18, 18, 8);
const EdgeInsetsGeometry errorDialogButtonPadding = EdgeInsets.fromLTRB(18, 8, 18, 8);
const double errorDialogContainerRadius = 20;
const double errorDialogButtonRadius = 20;
const double errorDialogFontSize = 15;