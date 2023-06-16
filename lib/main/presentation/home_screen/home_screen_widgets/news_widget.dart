import 'package:flutter/material.dart';
import 'package:ideal_atm/main/presentation/utils/design_widget_constants.dart';

class NewsWidget extends StatelessWidget {
  const NewsWidget({Key? key, required this.title, required this.icon})
      : super(key: key);

  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: newsWidgetPadding,
      child: Card(
        color: Theme.of(context).colorScheme.secondaryContainer,
        elevation: newsWidgetElevation,
        child: Padding(
          padding: newsWidgetCardPadding,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(newsWidgetCardRadius),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: newsWidgetIconPadding,
                  child: Icon(icon,
                      color: Theme.of(context).colorScheme.onSecondaryContainer,
                      size: 40),
                ),
                Expanded(
                  child: Padding(
                    padding: newsWidgetTextPadding,
                    child: Text(
                      title,
                      textAlign: TextAlign.left,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.onPrimary),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
