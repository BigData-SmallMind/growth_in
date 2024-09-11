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

  Future<User> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final userRM = await remoteApi.signIn(
        email: email,
        password: password,
      );
      // PII data should be stored in the secure storage
      await _secureStorage.upsertUser(
        id: userRM.info.id,
        name: userRM.info.name,
        email: userRM.info.email,
        phone: userRM.info.phone,
        image: userRM.info.image,
        token: userRM.token,
      );
      final user = userRM.toDomainModel();
      final userCompaniesCM = user.companies.toCacheModel();
      await _localStorage.upsertUserCompanies(
        userCompaniesCM,
      );
      return user;
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

  Future chooseAccountCompany({
    required int companyId,
  }) async {
    try {
      final user = await getUser().first;
      await remoteApi.chooseAccountCompany(
        companyId: companyId,
      );
      //update cached user companies
      final userCompanies = user!.companies
          .map(
            (company) {
              return company.copyWith(
                isSelected: company.id == companyId ? true : false,
              );
            },
          )
          .toList()
          .toCacheModel();
      _localStorage.upsertUserCompanies(userCompanies);
      _userSubject.add(user);
    } catch (error) {
      rethrow;
    }
  }

  Future<String> sendOtp(String email) async {
    try {
      final token = await remoteApi.sendOtp(
        email: email,
      );
      await upsertOtpVerificationTokenSupplierToken(token);
      return token;
    } catch (error) {
      if (error is EmailNotRegisteredGrowthInException) {
        throw EmailNotRegisteredException();
      }
      rethrow;
    }
  }

  Future<int> reSendOtp() async {
    try {
      final token = await getOtpVerificationTokenSupplierToken();
      final totalTimeInMinutes =
          await remoteApi.reSendOtp(otpVerificationToken: token!);
      return totalTimeInMinutes;
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
      final token = await getOtpVerificationTokenSupplierToken();
      await remoteApi.verifyOtp(
        otpVerificationToken: token!,
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
    required String newPasswordConfirmation,
  }) async {
    try {
      final otpVerificationToken = await getOtpVerificationTokenSupplierToken();
      await remoteApi.resetPassword(
        otpVerificationToken: otpVerificationToken!,
        newPassword: newPassword,
        newPasswordConfirmation: newPasswordConfirmation,
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

  Future<String?> getOtpVerificationTokenSupplierToken() async =>
      await _secureStorage.getOtpVerificationTokenSupplierToken();

  Future upsertOtpVerificationTokenSupplierToken(String token) async =>
      await _secureStorage.upsertOtpVerificationTokenSupplierToken(
        token: token,
      );

  Future deleteOtpVerificationTokenSupplierToken() async =>
      await _secureStorage.deleteOtpVerificationTokenSupplierToken();

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
    final userImage = await _secureStorage.getUserImage();
    final userCompanies = await _localStorage.getUserCompanies();
    if (userId != null && userName != null) {
      final user = User(
        id: userId,
        name: userName,
        email: userEmail!,
        phone: userPhone!,
        image: userImage,
        companies: userCompanies!.toDomainModel(),
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
