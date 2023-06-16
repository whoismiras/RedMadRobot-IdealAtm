// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ideal_atm/core/constants/app_assets.dart';
import 'package:ideal_atm/main/business/models/atm/atm.dart';
import 'package:ideal_atm/main/presentation/atm/atm_detail_screen.dart';

class MarkerBuilder extends StatelessWidget {
  const MarkerBuilder({
    super.key,
    required this.atm,
  });

  final Atm atm;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: () {
        showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return AtmDetailScreen(atm: atm);
          },
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          shape: BoxShape.circle,
          //borderRadius: BorderRadius.circular(30)
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SvgPicture.asset(AppAssets.idealBankLogoSmall,
              color: Theme.of(context).colorScheme.onPrimary,
              height: 12,
              fit: BoxFit.fitWidth
              // width: double.maxFinite,
              ),
        ),
      ),
    );
  }
}
