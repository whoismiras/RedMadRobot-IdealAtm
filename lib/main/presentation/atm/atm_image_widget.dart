import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ideal_atm/core/constants/app_assets.dart';
import 'package:ideal_atm/main/business/models/atm/atm.dart';

class AtmImageWidget extends StatelessWidget {
  const AtmImageWidget({
    super.key,
    required this.atm,
  });

  final Atm atm;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondaryContainer,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: SvgPicture.asset(
              AppAssets.idealBankLogoBig,
              color: Theme.of(context).colorScheme.onSurface,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}
