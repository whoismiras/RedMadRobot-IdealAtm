import 'package:flutter/material.dart';
import 'package:ideal_atm/core/constants/app_styles.dart';
import 'package:ideal_atm/main/presentation/home_screen/home_screen_widgets/news_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:ideal_atm/main/presentation/utils/design_widget_constants.dart';

class NewsFeedWidget extends StatelessWidget {
  const NewsFeedWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.tertiary,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: newsFeedWidgetPadding,
              child: Text(AppLocalizations.of(context).news,
                  style: AppStyles.s18w600.copyWith(
                      color: Theme.of(context).colorScheme.inversePrimary)),
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: const [
                    NewsWidget(
                      title:
                          'Появилась новая функция поиска банкоматов, заходи в раздел и найди свой идеальный банкомат.',
                      icon: Icons.atm,
                    ),
                    NewsWidget(
                      title:
                          'Открой виртуальную карту в 2 клика, переходи в раздел открытия счета в Личном кабинете.',
                      icon: Icons.add_card_rounded,
                    ),
                    NewsWidget(
                      title:
                          'Оплачивай автострахование и другие услуги в разделе Платежи!',
                      icon: Icons.taxi_alert,
                    ),
                    SizedBox(height: newsFeedWidgetBottomSpacer),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
