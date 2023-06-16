import 'package:ideal_atm/core/client/api_paths.dart';
import 'package:ideal_atm/core/either/either.dart';
import 'package:ideal_atm/core/exceptions/failure.dart';
import 'package:ideal_atm/core/client/base_repository.dart';
import 'package:ideal_atm/core/services/interactor/interactor.dart';
import 'package:ideal_atm/main/business/models/atm/atm.dart';
import 'package:ideal_atm/main/business/models/use_cases/api_response.dart';
import 'package:ideal_atm/main/business/models/user/user_data.dart';
import 'package:ideal_atm/interfaces/domain_interface/domain_interface_impl.dart';

class InteractorImpl extends BaseRepository implements Interactor {
  InteractorImpl() : _interface = DomainInterfaceImpl();
  final DomainInterfaceImpl _interface;

  @override
  getATMInfo() {
    // TODO: implement getATMInfo
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<Atm>>> getATMs() async {
    final result = call(RestMethod.get, 'api URL to ATMs comes here');
    return result.then<Either<Failure, List<Atm>>>((either) =>
        either.map<Failure, List<Atm>>((e) => Left<Failure, List<Atm>>(e),
            (r) => Right<Failure, List<Atm>>(r)
            //TODO parse json to list

            ));
  }

  @override
  Future<Either<Failure, ApiResponse>> requestAuth(UserData userData) async {
    final String loginWith =
        userData.email != null ? loginWithEmail : loginWithPhone;
    final data = _interface.handleAuthRequest(userData);
    final result = call(
        RestMethod.post, apiUrl + apiDev + userService + loginWith,
        body: data);
    return result.then<Either<Failure, ApiResponse>>(
      (either) => either.map<Failure, ApiResponse>(
        (e) => Left<Failure, ApiResponse>(e),
        (r) => Right<Failure, ApiResponse>(
          _interface.handleAuthApiResponse(r),
        ),
      ),
    );
  }

  @override
  Future<Either<Failure, ApiResponse>> requestReg(UserData userData) async {
    final result = call(
        RestMethod.post, apiUrl + apiDev + userService + register,
        body: _interface.handleRegRequest(userData));
    return result.then<Either<Failure, ApiResponse>>(
      (either) => either.map<Failure, ApiResponse>(
        (e) => Left<Failure, ApiResponse>(e),
        (r) => Right<Failure, ApiResponse>(
          _interface.handleRegApiResponse(r),
        ),
      ),
    );
  }
}
