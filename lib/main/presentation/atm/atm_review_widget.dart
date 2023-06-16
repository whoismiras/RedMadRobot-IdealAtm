import 'package:carousel_slider/carousel_slider.dart';
import 'package:expandable/expandable.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:ideal_atm/core/constants/app_assets.dart';
import 'package:ideal_atm/core/constants/app_colors.dart';
import 'package:ideal_atm/core/constants/app_styles.dart';
import 'package:ideal_atm/main/business/models/atm/atm.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:vertical_barchart/vertical-barchart.dart';
import 'package:vertical_barchart/vertical-barchartmodel.dart';

class AtmReviewWidget extends StatefulWidget {
  const AtmReviewWidget({super.key, required this.atm});

  @override
  State<AtmReviewWidget> createState() => _AtmReviewWidgetState();
  final Atm atm;
}

class _AtmReviewWidgetState extends State<AtmReviewWidget> {
  bool _reviewsView = false;
  @override
  Widget build(BuildContext context) {
    return ExpandableNotifier(
      child: Padding(
        padding: EdgeInsets.zero,
        child: ExpansionTileCard(
          elevation: 0,
          onExpansionChanged: (bool one) {
            setState(() {
              _reviewsView = !_reviewsView;
            });
          },
          borderRadius: BorderRadius.circular(10),
          expandedTextColor: AppColors.transparent,
          expandedColor: AppColors.transparent,
          baseColor: AppColors.transparent,
          title: Text(AppLocalizations.of(context).reviews,
              style: _reviewsView
                  ? AppStyles.s18w600.apply(color: AppColors.bgColor)
                  : AppStyles.s18w600.apply(color: AppColors.black)),
          children: [
            const Divider(
              thickness: 1,
              color: AppColors.grey,
              indent: 0,
              endIndent: 0,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Row(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: RatingBarIndicator(
                      rating: 3,
                      itemCount: 5,
                      itemSize: 16,
                      itemBuilder: (context, _) => const Icon(
                        Icons.star_outlined,
                        color: AppColors.bgColor,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    '3.5',
                    style: AppStyles.s12w500.apply(color: AppColors.bgColor),
                  ),
                  const SizedBox(width: 10),
                  Text('894 ${AppLocalizations.of(context).product_reviews}',
                      style: AppStyles.s12w500.apply(color: AppColors.grey))
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 30),
              child: VerticalBarchart(
                background: Theme.of(context).colorScheme.surface,
                maxX: 500,
                data: bardata,
                showLegend: true,
                showBackdrop: true,
                barStyle: BarStyle.DEFAULT,
                alwaysShowDescription: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  width: double.infinity,
                  child: Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(8)),
                    child: ExpansionTileCard(
                      title: Text(
                        AppLocalizations.of(context).write_review,
                        textAlign: TextAlign.center,
                      ),
                      // trailing: SizedBox(),
                      children: [
                        Text(
                          AppLocalizations.of(context).tech_state,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: RatingBar.builder(
                            itemBuilder: (context, _) => const Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (rating) {
                              print(rating);
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Container(
                            width: 350,
                            height: 170,
                            padding:
                                const EdgeInsets.symmetric(horizontal: 24.0),
                            decoration: BoxDecoration(
                              color: AppColors.almostTransparent,
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(
                                  color: AppColors.grey.withOpacity(0.4),
                                  width: 1.0),
                              // gradient: const LinearGradient(
                              //     colors: [AppColors.gradientEnd, AppColors.layerBlur]),
                            ),
                            child: TextFormField(
                              decoration: InputDecoration(
                                labelStyle: AppStyles.s18w600,
                                floatingLabelStyle: AppStyles.s18w600,
                                floatingLabelAlignment:
                                    FloatingLabelAlignment.start,
                                hintMaxLines: 10,
                                hintStyle: AppStyles.s16w500
                                    .apply(color: AppColors.greyLight),
                                hintText:
                                    AppLocalizations.of(context).review_hint,
                                border: InputBorder.none,
                                focusColor: AppColors.grey,
                                focusedErrorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                counterText: '',
                                errorBorder: InputBorder.none,
                                fillColor: AppColors.grey,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: CupertinoButton(
                              onPressed: () {},
                              child: Text(
                                AppLocalizations.of(context).send,
                                style: AppStyles.s16w500
                                    .apply(color: AppColors.black),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, top: 8),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  AppLocalizations.of(context).customers_photos,
                  style: AppStyles.s18w600,
                ),
              ),
            ),
            CarouselSlider(
              items: photoList,
              options: CarouselOptions(
                viewportFraction: 0.3,
                height: 60,
                scrollDirection: Axis.horizontal,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: ListTile(
                    leading: const CircleAvatar(
                      backgroundImage: AssetImage(AppAssets.avatar),
                      radius: 35,
                    ),
                    title: const Text(
                      'Робот Роботович',
                      style: AppStyles.s18w600,
                    ),
                    subtitle: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            '4 апреля 2023, 12:12',
                            style:
                                AppStyles.s16w500.apply(color: AppColors.grey),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: RatingBarIndicator(
                            rating: 3,
                            itemCount: 5,
                            itemSize: 16,
                            itemBuilder: (context, _) => const Icon(
                              Icons.star_outlined,
                              color: AppColors.bgColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    isThreeLine: true,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(AppLocalizations.of(context).pros,
                      style: AppStyles.s16w500)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  AppLocalizations.of(context).review_text,
                  style: AppStyles.s14w400.apply(color: AppColors.darkGrey),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(AppLocalizations.of(context).cons,
                      style: AppStyles.s16w500)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  AppLocalizations.of(context).review_text,
                  style: AppStyles.s14w400.apply(color: AppColors.darkGrey),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<VBarChartModel> bardata = [
    VBarChartModel(
      index: 0,
      label: "5",
      colors: [AppColors.bgColor, AppColors.bgColor.withOpacity(0.9)],
      jumlah: 500,
      tooltip: "285",
    ),
    VBarChartModel(
      index: 1,
      label: "4",
      colors: [AppColors.bgColor, AppColors.bgColor.withOpacity(0.9)],
      jumlah: 356,
      tooltip: "356",
    ),
    VBarChartModel(
      index: 2,
      label: "3",
      colors: [AppColors.bgColor, AppColors.bgColor.withOpacity(0.9)],
      jumlah: 130,
      tooltip: "130",
    ),
    VBarChartModel(
      index: 3,
      label: "2",
      colors: [AppColors.bgColor, AppColors.bgColor.withOpacity(0.9)],
      jumlah: 90,
      tooltip: "90",
    ),
    VBarChartModel(
      index: 4,
      label: "1",
      colors: [AppColors.bgColor, AppColors.bgColor.withOpacity(0.9)],
      jumlah: 33,
      tooltip: "33",
    ),
  ];

  final List<Widget>? photoList = [
    Image.asset(AppAssets.atms),
  ];
}
