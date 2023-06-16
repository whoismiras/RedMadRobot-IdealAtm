import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AlertController {
  static void showMessage({
    required BuildContext context,
    String? title,
    required String content,
    bool barrierDismissable = true,
    TextStyle? titleStyle,
    TextStyle? contentStyle,
    void Function()? onDismissed,
  }) async {
    if (Platform.isIOS || Platform.isMacOS) {
      await showCupertinoDialog<void>(
        context: context,
        barrierDismissible: barrierDismissable,
        builder: (_) => CupertinoAlertDialog(
          title: title?.isEmpty ?? false
              ? null
              : Text(
                  title!,
                  style: titleStyle ?? Theme.of(context).textTheme.titleMedium,
                ),
          content: Text(
            content,
            style: contentStyle ?? Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      );
      if (onDismissed != null) onDismissed();
      return;
    }
    await showDialog<void>(
      context: context,
      barrierDismissible: barrierDismissable,
      builder: (_) => AlertDialog(
        title: title?.isEmpty ?? true
            ? null
            : Text(
                title!,
                style: titleStyle ?? Theme.of(context).textTheme.titleMedium,
              ),
        content: Text(
          content,
          style: contentStyle ?? Theme.of(context).textTheme.bodyMedium,
        ),
      ),
    );
    if (onDismissed != null) onDismissed();
    return;
  }

  static void showDecisionDialog({
    required BuildContext context,
    required void Function() onYes,
    required void Function() onNo,
    bool barrierDismissable = true,
    required String title,
    TextStyle? titleStyle,
    String? content,
    TextStyle? contentStyle,
  }) async {
    if (Platform.isIOS || Platform.isMacOS) {
      return await showCupertinoDialog(
        context: context,
        barrierDismissible: barrierDismissable,
        builder: (_) => CupertinoAlertDialog(
          title: Text(
            title,
            style: titleStyle ?? Theme.of(context).textTheme.titleMedium,
          ),
          content: (content?.isEmpty ?? true)
              ? null
              : Text(
                  content!,
                  style: contentStyle ?? Theme.of(context).textTheme.bodyMedium,
                ),
          actions: [
            CupertinoDialogAction(
              onPressed: onYes,
              child: Text(AppLocalizations.of(context).yes),
            ),
            CupertinoDialogAction(
              onPressed: onNo,
              child: Text(AppLocalizations.of(context).no),
            ),
          ],
        ),
      );
    }
    return await showDialog(
      context: context,
      barrierDismissible: barrierDismissable,
      builder: (_) => AlertDialog(
        title: Text(
          title,
          style: titleStyle ?? Theme.of(context).textTheme.titleMedium,
        ),
        content: (content?.isEmpty ?? true)
            ? null
            : Text(
                content!,
                style: contentStyle ?? Theme.of(context).textTheme.bodyMedium,
              ),
        actions: [
          TextButton(
            onPressed: onNo,
            child: Text(AppLocalizations.of(context).no),
          ),
          TextButton(
            onPressed: onYes,
            child: Text(AppLocalizations.of(context).yes),
          ),
        ],
      ),
    );
  }
}
