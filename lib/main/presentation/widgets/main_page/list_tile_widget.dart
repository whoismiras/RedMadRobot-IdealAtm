import 'package:flutter/material.dart';
import 'package:ideal_atm/core/constants/app_colors.dart';
import 'package:ideal_atm/core/constants/app_styles.dart';

class ListTileTransfer extends StatelessWidget {
  const ListTileTransfer({
    Key? key,
    this.transferName,
    this.date,
    this.image,
    this.amount,
  }) : super(key: key);

  final String? transferName;
  final String? date;
  final String? image;
  final String? amount;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 70,
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Row(
        children: [
          Expanded(
            child: ListTile(
              leading: Image.asset(
                image!,
              ),
              title: Text('$transferName', style: AppStyles.s16w700),
              subtitle: Text('$date', style: AppStyles.s16w700),
              trailing: Text('$amount', style: AppStyles.s16w700),
            ),
          ),
        ],
      ),
    );
  }
}
