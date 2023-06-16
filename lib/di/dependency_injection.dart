import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:ideal_atm/core/client/network_info.dart';
import 'package:ideal_atm/core/client/rest_client.dart';
import 'package:ideal_atm/core/services/dio_settings.dart';

import 'package:ideal_atm/main/data/shared_oreferences/app_shared_preferences.dart';

final GetIt di = GetIt.instance;

Future<void> init() async {
  di.registerLazySingleton(() => Connectivity());
  di.registerLazySingleton(() => Dio(baseOptions));

  di.registerLazySingleton(() => RestClientService(di<Dio>()));

  di.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(connectivity: di<Connectivity>()),
  );
  di.registerLazySingleton(() => const FlutterSecureStorage());
  di.registerSingletonAsync(() async {
    return await AppSharedPreferences.init();
  });
}
