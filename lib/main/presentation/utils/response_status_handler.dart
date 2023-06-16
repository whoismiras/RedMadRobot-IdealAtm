import 'package:flutter/material.dart';
import 'package:ideal_atm/main/business/models/use_cases/response_error.dart';
import 'package:ideal_atm/main/business/models/use_cases/response_status.dart';
import 'package:ideal_atm/main/presentation/widgets/dialogs/connection_error_dialog.dart';
import 'package:ideal_atm/main/presentation/widgets/dialogs/loading_dialog.dart';
import 'package:ideal_atm/main/presentation/widgets/dialogs/server_error_dialog.dart';

void handleResponseStatus(BuildContext context,
    {required ResponseStatus responseStatus,
    VoidCallback? onCompleted,
    VoidCallback? onErrorShown}) {
  switch (responseStatus.status) {
    case ResponseStatusType.inProgress:
      LoadingDialog.show(context);
      break;
    case ResponseStatusType.completed:
      LoadingDialog.hide(context);
      onCompleted != null ? onCompleted() : {};
      break;
    case ResponseStatusType.error:
      LoadingDialog.hide(context);
      switch (responseStatus.error) {
        case ResponseErrorType.connectionError:
          ConnectionErrorDialog.show(context);
          break;
        case ResponseErrorType.internalServerError:
          ServerErrorDialog.show(context);
          break;
        default:
      }
      onErrorShown != null ? onErrorShown() : {};
      break;
    default:
  }
}
