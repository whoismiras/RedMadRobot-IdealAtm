import 'package:flutter/material.dart';
import 'package:ideal_atm/core/l10n/l10n.dart';
import 'package:ideal_atm/core/services/get_flag.dart';
import 'package:ideal_atm/main/data/providers/local_provider.dart';
import 'package:ideal_atm/main/presentation/utils/design_widget_constants.dart';
import 'package:provider/provider.dart';

class ChangeLangButton extends StatelessWidget {
  const ChangeLangButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: changeLangButtWidgetPadding,
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          isDense: true,
          icon: Icon(Icons.language,
              color: Theme.of(context).colorScheme.onSurface),
          items: L10n.support.map((locale) {
            final flag = getFlag(locale.languageCode);
            return DropdownMenuItem(
              value: locale,
              child: Text(
                flag,
                style: changeLangButtWidgetFlagSize,
              ),
              onTap: () {
                final provider =
                    Provider.of<LocaleProvider>(context, listen: false);
                provider.setLocale(locale);
              },
            );
          }).toList(),
          onChanged: (locale) {},
        ),
      ),
    );
  }
}
