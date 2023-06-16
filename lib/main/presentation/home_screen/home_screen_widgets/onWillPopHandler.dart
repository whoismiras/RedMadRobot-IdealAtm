import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:ideal_atm/main/presentation/utils/design_widget_constants.dart';

class OnWillPopHandler {
  OnWillPopHandler() : _lastTapTime = null;
  DateTime? _lastTapTime;

  Future<bool> handlePop(BuildContext context) async {
    bool showExitWarning = true;
    if (_lastTapTime != null) {
      final timeDifference = DateTime.now().difference(_lastTapTime!);
      showExitWarning = timeDifference >= onWillPopToastDuration;
    }
    _lastTapTime = DateTime.now();
    if (showExitWarning) {
      Fluttertoast.showToast(
        msg: AppLocalizations.of(context).exitMassage,
        gravity: ToastGravity.CENTER,
        textColor: Theme.of(context).colorScheme.onPrimary,
        backgroundColor: Theme.of(context).colorScheme.primary,
      );
      return false;
    } else {
      Fluttertoast.cancel();
      return true;
    }
  }
}
