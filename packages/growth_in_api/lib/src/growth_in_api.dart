import 'dart:async';
import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as diox;
import 'package:flutter/material.dart';
import 'package:growth_in_api/growth_in_api.dart';
import 'package:growth_in_api/src/url_builder.dart';

import 'models/auth/request/update_account_rm.dart';

typedef TokenSupplier = Future<String?> Function();

class GrowthInApi {
  static const _errorJsonKey = 'error';
  static const _otpJsonKey = 'otp';
  static const _tokenJsonKey = 'token';
  static const _messageJsonKey = 'message';
  static const _successJsonKey = 'success';
  static const _statusJsonKey = 'status';
  static const _otpExpiryTimeJsonKey = 'expired_time';

  GrowthInApi({
    required TokenSupplier userTokenSupplier,
    required TokenSupplier otpVerificationTokenSupplier,
    required this.isUserUnAuthenticatedVN,
    required this.internetConnectionErrorVN,
  })  : urlBuilder = UrlBuilder(),
        _dio = Dio() {
    _dio.setUpAuthHeaders(
      userTokenSupplier: userTokenSupplier,
      otpVerificationTokenSupplier: otpVerificationTokenSupplier,
      isUserUnAuthSC: isUserUnAuthenticatedVN,
      internetConnectionErrorVN: internetConnectionErrorVN,
    );
    _dio.interceptors.add(
      LogInterceptor(
        error: false,
        request: false,
        requestBody: false,
        requestHeader: false,
        responseBody: false,
        responseHeader: false,
        logPrint: (_) {},
      ),
    );
  }

  // final FirebaseMessaging _firebaseMessaging;
  final Dio _dio;
  final ValueNotifier<bool> isUserUnAuthenticatedVN;
  final ValueNotifier internetConnectionErrorVN;
  final UrlBuilder urlBuilder;

  Future<UserRM> signIn({
    required String email,
    required String password,
  }) async {
    final url = urlBuilder.buildSignInUrl();
    final requestJsonBody = UserCredentialsRM(
      email: email,
      password: password,
    ).toJson();
    final response = await _dio.post(
      url,
      data: requestJsonBody,
    );
    try {
      final jsonObject = response.data;
      final user = UserRM.fromJson(jsonObject);
      return user;
    } catch (_) {
      final error = response.data[_errorJsonKey];
      final errorString = error.toString().toLowerCase();
      final invalidCredentials = errorString.contains('خطأ') == true;
      if (invalidCredentials) throw InvalidCredentialsGrowthInException();
      rethrow;
    }
  }

  Future chooseAccountCompany({
    required int companyId,
  }) async {
    final url = urlBuilder.buildChooseAccountCompanyUrl(companyId);

    try {
      final response = await _dio.post(
        url,
      );
      final responseJsonObject = response.data;
      final responseStatus = responseJsonObject[_statusJsonKey];
      if(responseStatus == 404) {
        final error = responseJsonObject[_errorJsonKey];
        final errorString = error.toString().toLowerCase();
        final companyNotFound = errorString.contains('غير مرتبط');
        if (companyNotFound) throw CompanyNotAssociatedGrowthInException();
      }
    } catch (_) {
      rethrow;
    }
  }

  Future updateProfile({
    required int userId,
    String? firstName,
    String? lastName,
    String? email,
    String? phone,
    String? jobTitle,
    String? image,
  }) async {
    final url = urlBuilder.buildUpdateUserUrl();

    final requestJsonBody = UpdateProfileUpRM(
      id: userId,
      firstName: firstName,
      lastName: lastName,
      email: email,
      phone: phone,
      jobTitle: jobTitle,
      image: image,
    ).toJson();

    try {
      await _dio.post(
        url,
        data: requestJsonBody,
      );
    } catch (_) {
      rethrow;
    }
  }

  Future updateAccount({
    required int userId,
    String? accountName,
    String? companyName,
    String? companyAddress,
    String? companyCountry,
  }) async {
    final url = urlBuilder.buildUpdateAccountUrl();

    final requestJsonBody = UpdateAccountRM(
      id: userId,
      accountName: accountName,
      companyName: companyName,
      companyAddress: companyAddress,
      companyCountry: companyCountry,
    ).toJson();

    try {
      await _dio.post(
        url,
        data: requestJsonBody,
      );
    } catch (_) {
      rethrow;
    }
  }

  Future changePassword({
    required String email,
    required String oldPassword,
    required String newPassword,
  }) async {
    final url = urlBuilder.buildChangePasswordUrl();

    final requestJsonBody = ChangePasswordRM(
      email: email,
      oldPassword: oldPassword,
      newPassword: newPassword,
    ).toJson();

    try {
      final response = await _dio.post(
        url,
        data: requestJsonBody,
      );
      final responseValue = response.data[_errorJsonKey];
      if (responseValue is String &&
          responseValue.toLowerCase().contains('token invalid')) {
        throw IncorrectPasswordGrowthInException();
      }
    } catch (_) {
      rethrow;
    }
  }

  Future<String> sendOtp({
    required String email,
  }) async {
    final url = urlBuilder.buildSendOtpUrl(email);

    final response = await _dio.post(
      url,
    );
    try {
      final successObject = response.data[_successJsonKey];
      final otp = successObject[_otpJsonKey].toString();
      final token = successObject[_tokenJsonKey].toString();
      debugPrint('----otp: $otp');
      return token;
    } catch (_) {
      final error = response.data[_errorJsonKey];
      final emailNotRegistered =
          error.toString().toLowerCase().contains('غير مسجل');
      if (emailNotRegistered) throw EmailNotRegisteredGrowthInException();
      rethrow;
    }
  }

  Future<int> reSendOtp({
    required String otpVerificationToken,
  }) async {
    final url = urlBuilder.buildReSendOtpUrl();

    final response = await _dio.get(
      url,
      options: Options(
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $otpVerificationToken',
        },
      ),
    );
    try {
      final successObject = response.data[_successJsonKey];
      final otpExpiryTime = successObject[_otpExpiryTimeJsonKey] as int;
      return otpExpiryTime;
    } catch (_) {
      final error = response.data[_errorJsonKey];
      final emailNotRegistered =
          error.toString().toLowerCase().contains('غير مسجل');
      if (emailNotRegistered) throw EmailNotRegisteredGrowthInException();
      rethrow;
    }
  }

  Future verifyOtp({
    required String otpVerificationToken,
    required String email,
    required String otp,
  }) async {
    final url = urlBuilder.buildVerifyOtpUrl(email, otp);

    final response = await _dio.post(
      url,
      options: Options(
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $otpVerificationToken',
        },
      ),
    );
    try {
      final successObject = response.data[_successJsonKey];
      if (successObject == null) throw Exception();
      return successObject;
    } catch (_) {
      final error = response.data[_errorJsonKey];
      final message = error[_messageJsonKey];
      final invalidOtp = message.isNotEmpty;
      if (invalidOtp) throw InvalidOtpGrowthInException();
      rethrow;
    }
  }

  Future resetPassword({
    required String otpVerificationToken,
    required String newPassword,
    required String newPasswordConfirmation,
  }) async {
    final url = urlBuilder.buildResetPasswordUrl(
      newPassword,
      newPasswordConfirmation,
    );
    try {
      await _dio.post(
        url,
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $otpVerificationToken',
          },
        ),
      );
    } catch (_) {
      rethrow;
    }
  }
}

extension on Dio {
  void setUpAuthHeaders({
    required TokenSupplier userTokenSupplier,
    required TokenSupplier otpVerificationTokenSupplier,
    required ValueNotifier<bool> isUserUnAuthSC,
    required ValueNotifier internetConnectionErrorVN,
  }) async {
    options = diox.BaseOptions(
      contentType: Headers.jsonContentType,
      responseType: ResponseType.json,
      connectTimeout: const Duration(seconds: 120),
      sendTimeout: const Duration(seconds: 120),
      receiveTimeout: const Duration(seconds: 120),
    );
    interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await userTokenSupplier();

          options.headers.addAll(
            {
              "Accept": "application/json",
              if (token != null) 'Authorization': 'Bearer $token',
            },
          );

          return handler.next(options);
        },
        onError: (error, handler) {
          final isCustomerUnAuth = error.response?.statusCode == 401;
          final internetConnectionError =
              error.type == DioExceptionType.connectionError;
          if (isCustomerUnAuth) isUserUnAuthSC.value = (true);
          if (internetConnectionError) {
            final internetConnectionException =
                InternetConnectionGrowthInException();
            internetConnectionErrorVN.value = internetConnectionException;
            internetConnectionErrorVN.value = null;
          }
          return handler.next(error);
        },
        onResponse: (response, handler) {
          handler.next(response);
        },
      ),
    );
  }
}
