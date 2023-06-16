import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ideal_atm/core/constants/app_assets.dart';
import 'package:ideal_atm/main/presentation/utils/design_widget_constants.dart';

class BankLogo extends StatelessWidget {
  const BankLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: bankLogoPadding,
      child: SvgPicture.asset(
        AppAssets.idealBankLogoBig,
        color: Theme.of(context).colorScheme.onPrimary,
        width: bankLogoWidth,
      ),
    );
  }
}
