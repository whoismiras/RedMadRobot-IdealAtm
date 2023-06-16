import 'package:ideal_atm/main/business/models/use_cases/response_error.dart';

enum ResponseStatusType { none, inProgress, completed, error }

class ResponseStatus {
  const ResponseStatus({this.status = ResponseStatusType.none, this.error});

  final ResponseStatusType status;
  final ResponseErrorType? error;

  ResponseStatus copyWith({
    ResponseStatusType? status,
    ResponseErrorType? error,
  }) {
    return ResponseStatus(
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }

  ResponseStatus resetError() {
    return const ResponseStatus(
      status: ResponseStatusType.none,
      error: null,
    );
  }
}
