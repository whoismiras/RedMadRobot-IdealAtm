import 'dart:io';
import 'package:dio/dio.dart';
import 'package:ideal_atm/core/client/network_info.dart';
import 'package:ideal_atm/core/client/rest_client.dart';
import 'package:ideal_atm/core/either/either.dart';
import 'package:ideal_atm/core/exceptions/failure.dart';
import 'package:ideal_atm/di/dependency_injection.dart';

///Базовый класс сетевого слоя для репозиториев фич
abstract class BaseRepository {
  final NetworkInfo networkInfo = di<NetworkInfo>();
  final RestClientService restClientService = di<RestClientService>();

  Future<Either<Failure, dynamic>> call(
      RestMethod method,
      String url, {
        dynamic body,
        dynamic parametres,
        CancelToken? cancelToken,
        Options? options,
        Function(int, int)? onSendProgress,
      }) async {
    if (await networkInfo.isConnected) {
      try {
        dynamic response;
        switch (method) {
          case RestMethod.get:
            response = await restClientService.get(
              url,
              params: parametres,
              cancelToken: cancelToken,
              options: options,
            );
            break;

          case RestMethod.post:
            response = await restClientService.post(
              url,
              body: body,
              parameters: parametres,
              options: options,
            );
            break;

          case RestMethod.put:
            response =
            await restClientService.put(url, body: body, options: options);
            break;

          case RestMethod.delete:
            response = await restClientService.delete(
              url,
              body: body,
              options: options,
              params: parametres,
            );
            break;

          case RestMethod.patch:
            response = await restClientService.patch(
              url,
              body: body,
              options: options,
              onSendProgress: onSendProgress,
            );
            break;
        }

        return Right(response.data);
      } on ServerException catch (exception) {
        return Left(ServerFailure(response: exception.response));
      } on DioError catch (exception) {
        return Left(DioFailure(response: exception.response));
      } on SocketException {
        return Left(NoConnectionFailure());
      } on Exception {
        return Left(NoConnectionFailure());
      } catch (exception) {
        return Left(NoConnectionFailure());
      }
    } else {
      return Left(NoConnectionFailure());
    }
  }
}

enum RestMethod { get, post, put, delete, patch }