import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:ideal_atm/core/constants/app_styles.dart';
import 'package:ideal_atm/main/presentation/utils/design_widget_constants.dart';

class CarouselButtonWidget extends StatelessWidget {
  const CarouselButtonWidget({
    Key? key,
    required this.image,
    required this.title,
  }) : super(key: key);

  final String image;
  final String title;

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    double iconSize = carouselButtonWidgetIconSize;
    return Column(
      children: [
        Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(carouselButtonWidgetRadius)),
          elevation: carouselButtonWidgetElevation,
          child: Container(
            height: carouselButtonWidgetContainerSize,
            width: carouselButtonWidgetContainerSize,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                  width: carouselButtonWidgetBorderWidth,
                  color: brightness == Brightness.dark
                      ? Theme.of(context).colorScheme.outline
                      : Colors.transparent),
              color: Theme.of(context).colorScheme.primaryContainer,
            ),
            child: IconButton(
              onPressed: () {},
              padding: carouselButtonWidgetImagePadding,
              icon: image.contains('.svg')
                  ? SvgPicture.asset(
                      image,
                      color: Theme.of(context).colorScheme.onPrimary,
                      width: iconSize,
                      height: iconSize,
                      fit: BoxFit.cover,
                    )
                  : Image.asset(
                      image,
                      fit: BoxFit.cover,
                      // allowDrawingOutsideViewBox: true,
                    ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.zero,
          child: Center(
            child: Text(
              title,
              style: AppStyles.s12w500
                  .copyWith(color: Theme.of(context).colorScheme.onSurface),
              textAlign: TextAlign.center,
            ),
          ),
        )
      ],
    );
  }
}
