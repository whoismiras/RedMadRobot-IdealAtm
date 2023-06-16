import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:ideal_atm/main/presentation/utils/design_widget_constants.dart';

class ConnectionErrorDialog extends StatelessWidget {
  const ConnectionErrorDialog({Key? key, this.onAccept}) : super(key: key);
  final VoidCallback? onAccept;

  static void show(BuildContext context, {Key? key, VoidCallback? onAccept}) =>
      showDialog<void>(
        context: context,
        useRootNavigator: false,
        builder: (_) => ConnectionErrorDialog(
          key: key,
          onAccept: onAccept,
        ),
      ).then((_) => FocusScope.of(context).requestFocus(FocusNode()));

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Center(
        child: Container(
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: const BorderRadius.all(
                  Radius.circular(errorDialogContainerRadius))),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: errorDialogMessagePadding,
                child: Text(
                  AppLocalizations.of(context).connectionError,
                  style: TextStyle(
                    fontSize: errorDialogFontSize,
                    color: Theme.of(context).colorScheme.onPrimary,
                    decoration: TextDecoration.none,
                  ),
                ),
              ),
              Padding(
                padding: errorDialogButtonPadding,
                child: MaterialButton(
                  onPressed: () {
                    onAccept;
                    Navigator.pop(context);
                  },
                  color: Theme.of(context).colorScheme.secondaryContainer,
                  shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(errorDialogButtonRadius)),
                  textColor: Theme.of(context).colorScheme.onPrimary,
                  child: Text(AppLocalizations.of(context).errorDialogAccept),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
