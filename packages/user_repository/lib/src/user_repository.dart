import 'dart:async';
import 'dart:io';

import 'package:growth_in_api/growth_in_api.dart';
import 'package:domain_models/domain_models.dart';
import 'package:key_value_storage/key_value_storage.dart';
import 'package:rxdart/rxdart.dart';
import 'package:user_repository/src/mappers/mappers.dart';
import 'package:user_repository/src/user_change_notifier.dart';
import 'package:user_repository/src/user_local_storage.dart';
import 'package:user_repository/src/user_secure_storage.dart';

class UserRepository {
  UserRepository({
    required KeyValueStorage noSqlStorage,
    required this.remoteApi,
  })  : _secureStorage = const UserSecureStorage(),
        changeNotifier = UserChangeNotifier(),
        _localStorage = UserLocalStorage(noSqlStorage: noSqlStorage);

  final GrowthInApi remoteApi;
  final UserSecureStorage _secureStorage;
  final UserLocalStorage _localStorage;
  final BehaviorSubject<User?> _userSubject = BehaviorSubject();
  final UserChangeNotifier changeNotifier;
  final BehaviorSubject<LocalePreferenceDM?> _localePreferenceSubject =
      BehaviorSubject();

  Future<void> upsertLocalePreference(LocalePreferenceDM preference) async {
    await _localStorage.upsertLocalePreference(
      preference.toCacheModel(),
    );
    _localePreferenceSubject.add(preference);
  }

  Stream<LocalePreferenceDM?> getLocalePreference() async* {
    if (!_localePreferenceSubject.hasValue) {
      final storedPreferenceCM = await _localStorage.getLocalePreference();
      final storedPreference = storedPreferenceCM?.toDomainModel();
      // final storedPreference = LocalePreferenceCM.arabic.toDomainModel();
      if (storedPreferenceCM == null) {
        final String systemLocale = Platform.localeName;
        final defaultLocalePreference = strToLocalePreferenceDM(systemLocale);
        upsertLocalePreference(defaultLocalePreference);
      } else {
        _localePreferenceSubject.add(storedPreference);
      }
    }

    yield* _localePreferenceSubject.stream;
  }

  Future signIn({
    required String email,
    required String password,
  }) async {
    try {
      final userRM = await remoteApi.signIn(
        email: email,
        password: password,
      );
      await _secureStorage.upsertUser(
        id: userRM.info.id,
        name: userRM.info.name,
        email: userRM.info.email,
        phone: userRM.info.phone,
        token: userRM.token,
      );

      _userSubject.add(
        User(
          id: userRM.info.id,
          name: userRM.info.name,
          email: userRM.info.email,
          phone: userRM.info.phone,
        ),
      );
    } catch (error) {
      if (error is InvalidCredentialsGrowthInException) {
        throw InvalidCredentialsException();
      }
      if (error is InvalidEmailFormatGrowthInException) {
        throw InvalidEmailFormatException();
      }
      rethrow;
    }
  }

  Future sendOtp(String email) async {
    try {
      await remoteApi.sendOtp(
        email: email,
      );
    } catch (error) {
      if (error is EmailNotRegisteredGrowthInException) {
        throw EmailNotRegisteredException();
      }
      rethrow;
    }
  }

  Future verifyOtp(
    String email,
    String otp,
  ) async {
    try {
      await remoteApi.verifyOtp(
        email: email,
        otp: otp,
      );
    } catch (error) {
      if (error is InvalidOtpGrowthInException) {
        throw InvalidOtpException();
      }
      rethrow;
    }
  }

  Future<void> resetPassword({
    required String newPassword,
  }) async {
    try {
      final email = changeNotifier.otpVerification!.email;

      await remoteApi.resetPassword(
        email: email,
        newPassword: newPassword,
      );
    } catch (error) {
      rethrow;
    }
  }

  Future updateUser({
    String? firstName,
    String? lastName,
    String? email,
    String? phone,
    String? jobTitle,
    String? image,
  }) async {
    try {
      final user = await getUser().first;
      await remoteApi.updateProfile(
        userId: user!.id,
        firstName: firstName,
        lastName: lastName,
        email: email,
        phone: phone,
        jobTitle: jobTitle,
        image: image,
      );
    } catch (error) {
      rethrow;
    }
  }

  Future changePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    try {
      final user = await getUser().first;
      await remoteApi.changePassword(
        email: user!.email,
        oldPassword: oldPassword,
        newPassword: newPassword,
      );
    } catch (error) {
      if (error is IncorrectPasswordGrowthInException) {
        throw WrongPasswordException();
      }
      rethrow;
    }
  }

  Future<String?> getUserToken() async => await _secureStorage.getUserToken();

  Future logout() async {
    try {
      await _secureStorage.deleteUser();
      _userSubject.add(null);
    } catch (error) {
      rethrow;
    }
  }

  Stream<User?> getUser() async* {
    // Check if there is a [User] value added to the stream, if not,
    // this means that we need to first get the [User] data from
    // the secure storage in order to be able to add a [User].
    // if (!_userSubject.hasValue) {
    final userId = await _secureStorage.getUserId();
    final userName = await _secureStorage.getUserName();
    final userEmail = await _secureStorage.getUserEmail();
    final userPhone = await _secureStorage.getUserPhone();


    if (userId != null && userName != null ) {
      final user = User(
        id: userId,
        name: userName,
        email: userEmail!,
        phone: userPhone!,

      );
      _userSubject.add(user);
    } else {
      _userSubject.add(null);
    }
    yield* _userSubject.stream;
  }

  Future cacheRememberedCredentials({
    required String email,
    required String password,
  }) async {
    await _secureStorage.upsertRememberEmail(email: email);
    await _secureStorage.upsertRememberPassword(password: password);
  }

  Future<RememberMe> getRememberedCredentials() async {
    final email = await _secureStorage.getRememberEmail();
    final password = await _secureStorage.getRememberPassword();
    final rememberMe = RememberMe(
      password: password,
      email: email,
    );
    return rememberMe;
  }

  Future deleteRememberedCredentials() async {
    await _secureStorage.deleteRememberEmail();
    await _secureStorage.deleteRememberPassword();
  }
}
