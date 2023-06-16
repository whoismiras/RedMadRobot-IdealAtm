import 'package:flutter/material.dart';
import 'package:ideal_atm/core/constants/app_colors.dart';

class SectionTitle extends StatelessWidget {
  const SectionTitle({Key? key, required this.title, this.icon})
      : super(key: key);

  final String title;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              title,
              textAlign: TextAlign.left,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold, color: AppColors.greyLight),
            ),
          ),
        ),
        if (icon != null)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: icon,
          ),
      ],
    );
  }
}
