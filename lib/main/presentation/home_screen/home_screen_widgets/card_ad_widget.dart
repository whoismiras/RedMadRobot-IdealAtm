import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ideal_atm/core/constants/app_assets.dart';
import 'package:ideal_atm/main/business/bloc/user_state/user_bloc.dart';
import 'package:ideal_atm/main/presentation/utils/design_widget_constants.dart';
import 'package:ideal_atm/main/presentation/widgets/animation/slider_dot.dart';

class CardADWidget extends StatelessWidget {
  const CardADWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(builder: (context, state) {
      return state.loginState == LoginState.loggedOff
          ? const ADWidget()
          : const CardSlider();
    });
  }
}

class CardSlider extends StatefulWidget {
  const CardSlider({Key? key}) : super(key: key);

  @override
  State<CardSlider> createState() => _CardSliderState();
}

class _CardSliderState extends State<CardSlider> {
  late final PageController pageController;
  int pageNo = cardSliderInitPage;

  @override
  void initState() {
    pageController = PageController(
      initialPage: cardSliderInitPage,
      viewportFraction: cardSliderViewportFraction,
    );
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: cardWidgetVerticalPadding,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (int i = 0; i < cardSliderTotalPages; i++)
                if (i == pageNo) SliderDot(true) else SliderDot(false)
            ],
          ),
          Padding(
            padding: cardWidgetInnerVerticalPadding,
            child: SizedBox(
              height: cardWidgetSizedBoxHeight,
              child: PageView.builder(
                onPageChanged: (index) {
                  pageNo = index;
                  setState(() {});
                },
                controller: pageController,
                itemBuilder: (_, int index) {
                  return AnimatedBuilder(
                    animation: pageController,
                    builder: (ctx, child) {
                      return child!;
                    },
                    child: Padding(
                      padding: cardWidgetHorizontalPadding,
                      child: Image.asset(AppAssets.bank),
                    ),
                  );
                },
                itemCount: cardSliderTotalPages,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ADWidget extends StatelessWidget {
  const ADWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    return Padding(
      padding: adWidgetPadding,
      child: ClipRRect(
          borderRadius: BorderRadius.circular(adWidgetBorderCropRadius),
          child: Image.asset(brightness == Brightness.dark
              ? AppAssets.adPromoDark
              : AppAssets.adPromoLight)),
    );
  }
}
