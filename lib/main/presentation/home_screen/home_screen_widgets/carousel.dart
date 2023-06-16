import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:ideal_atm/core/constants/app_assets.dart';
import 'package:ideal_atm/main/presentation/home_screen/home_screen_widgets/carousel_button_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:ideal_atm/main/presentation/utils/design_widget_constants.dart';

class CarouselWidget extends StatelessWidget {
  const CarouselWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Widget> buttonsList = [
      CarouselButtonWidget(
        title: AppLocalizations.of(context).marketplace,
        image: AppAssets.cartIcon,
      ),
      CarouselButtonWidget(
        title: AppLocalizations.of(context).convert,
        image: AppAssets.conversionIcon,
      ),
      CarouselButtonWidget(
        title: AppLocalizations.of(context).taxes,
        image: AppAssets.payments1Icon,
      ),
      CarouselButtonWidget(
        title: AppLocalizations.of(context).payments,
        image: AppAssets.payments2Icon,
      ),
    ];
    return CarouselSlider(
      options: CarouselOptions(
        viewportFraction: carouselWidgetViewportFraction,
        height: carouselWidgetHeight,
        scrollDirection: Axis.horizontal,
      ),
      items: buttonsList,
    );
  }
}
