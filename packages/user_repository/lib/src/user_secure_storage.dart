import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserSecureStorage {
  static const _userIdKey = 'user-id';
  static const _userNameKey = 'user-name';
  static const _userEmailKey = 'user-email';
  static const _userPhoneKey = 'user-phone';
  static const _userImageKey = 'user-image';
  static const _userToken = 'user-token';
  static const _rememberEmailKey = 'remember-email';
  static const _rememberPasswordKey = 'remember-password';

  const UserSecureStorage({
    FlutterSecureStorage? secureStorage,
  }) : _secureStorage = secureStorage ?? const FlutterSecureStorage();

  final FlutterSecureStorage _secureStorage;

  Future<void> upsertUser({
    required int id,
    required String name,
    required String email,
    required String phone,
    String? image,
    required String token,
  }) async {
    await _secureStorage.write(
      key: _userIdKey,
      value: id.toString(),
    );
    await _secureStorage.write(
      key: _userNameKey,
      value: name,
    );

    await _secureStorage.write(
      key: _userEmailKey,
      value: email,
    );

    await _secureStorage.write(
      key: _userPhoneKey,
      value: phone,
    );

    await _secureStorage.write(
      key: _userImageKey,
      value: phone,
    );

    await _secureStorage.write(
      key: _userToken,
      value: token,
    );
  }

  Future<void> deleteUser() async {
    await _secureStorage.delete(key: _userIdKey);
    await _secureStorage.delete(key: _userNameKey);
    await _secureStorage.delete(key: _userEmailKey);
    await _secureStorage.delete(key: _userPhoneKey);
    await _secureStorage.delete(key: _userToken);
  }

  Future<int?> getUserId() async {
    final idString = await _secureStorage.read(key: _userIdKey);
    return idString != null ? int.tryParse(idString) : null;
  }

  Future<String?> getUserName() => _secureStorage.read(key: _userNameKey);

  Future<String?> getUserEmail() => _secureStorage.read(key: _userEmailKey);

  Future<String?> getUserPhone() => _secureStorage.read(key: _userPhoneKey);

  Future<String?> getUserToken() => _secureStorage.read(key: _userToken);

  Future<void> upsertRememberEmail({required String? email}) async {
    await _secureStorage.write(
      key: _rememberEmailKey,
      value: email,
    );
  }

  Future<String?> getRememberEmail() => _secureStorage.read(
        key: _rememberEmailKey,
      );

  Future<void> deleteRememberEmail() async =>
      await _secureStorage.delete(key: _rememberEmailKey);

  Future<void> upsertRememberPassword({required String? password}) async {
    await _secureStorage.write(
      key: _rememberPasswordKey,
      value: password,
    );
  }

  Future<String?> getRememberPassword() => _secureStorage.read(
        key: _rememberPasswordKey,
      );

  Future<void> deleteRememberPassword() async =>
      await _secureStorage.delete(key: _rememberPasswordKey);
}
