import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:ideal_atm/core/services/secure_storage/secure_storage.dart';
import 'package:ideal_atm/di/dependency_injection.dart';

enum StorageKeys { apiAccess, userData }

class SecureStorageImpl implements SecureStorage {
  final FlutterSecureStorage _secureStorage = di<FlutterSecureStorage>();

  @override
  Future<String?> readAccessToken() async {
    return await _secureStorage.read(key: StorageKeys.apiAccess.toString());
  }

  @override
  writeAccessToken(String data) async {
    await _secureStorage.write(
        key: StorageKeys.apiAccess.toString(), value: data);
  }

  @override
  Future<String?> readUserData() async {
    return await _secureStorage.read(key: StorageKeys.userData.toString());
  }

  @override
  writeUserData(String data) async {
    await _secureStorage.write(
        key: StorageKeys.userData.toString(), value: data);
  }

  @override
  clearSession() async {
    await _secureStorage.deleteAll();
  }
}
