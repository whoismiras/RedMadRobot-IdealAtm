import 'package:ideal_atm/core/either/either.dart';
import 'package:ideal_atm/core/exceptions/failure.dart';
import 'package:ideal_atm/main/business/models/use_cases/api_response.dart';
import 'package:ideal_atm/main/business/models/user/user_data.dart';

abstract class Interactor {
  getATMInfo();
  getATMs();
  Future<Either<Failure, ApiResponse>> requestAuth(UserData userData);
  Future<Either<Failure, ApiResponse>> requestReg(UserData userData);
}
