import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ideal_atm/main/business/models/atm/atm.dart';
import 'package:ideal_atm/main/presentation/widgets/section_title.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AtmAdditionalInfoWidget extends StatelessWidget {
  const AtmAdditionalInfoWidget({
    super.key,
    required this.atm,
  });

  final Atm atm;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(
          title: AppLocalizations.of(context).opening_hours,
        ),
        const SizedBox(height: 16),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 1,
          separatorBuilder: (_, sep) => const SizedBox(height: 8),
          itemBuilder: (_, i) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      AppLocalizations.of(context).everyday,
                      style: Theme.of(context).textTheme.bodySmall?.apply(
                          color: Theme.of(context).colorScheme.onSurface),
                    ),
                  ),
                  Flexible(
                    child: Text(
                      '11:00 - 22:00',
                      style: Theme.of(context).textTheme.bodySmall?.apply(
                          color: Theme.of(context).colorScheme.onSurface),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  AppLocalizations.of(context).status,
                  style: Theme.of(context).textTheme.bodySmall?.apply(
                      color: Theme.of(context).colorScheme.onSurface),
                ),
              ),
              Flexible(
                child: Text(
                  atm.status ?? '',
                  style: Theme.of(context).textTheme.bodySmall?.apply(
                      color: Theme.of(context).colorScheme.onSurface),
                ),
              ),
            ],
          ),
        ),
        SectionTitle(title: AppLocalizations.of(context).contact_info),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context).phone_number,
                    style: Theme.of(context).textTheme.bodySmall?.apply(
                        color: Theme.of(context).colorScheme.onSurface),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    '+7 777 011 01 01',
                    style: Theme.of(context).textTheme.bodyLarge?.apply(
                        color: Theme.of(context).colorScheme.onSurface),
                  ),
                ],
              ),
              Icon(CupertinoIcons.phone,
                  color: Theme.of(context).colorScheme.outline),
            ],
          ),
        ),
      ],
    );
  }
}
