import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as diox;
import 'package:flutter/material.dart';
import 'package:growth_in_api/growth_in_api.dart';
import 'package:growth_in_api/src/url_builder.dart';

typedef TokenSupplier = Future<String?> Function();

class GrowthInApi {
  static const _errorJsonKey = 'error';
  static const _errorsJsonKey = 'errors';
  static const _newEmailJsonKey = 'new_email';
  static const _otpJsonKey = 'otp';
  static const _tokenJsonKey = 'token';
  static const _messageJsonKey = 'message';
  static const _ticketsJsonKey = 'tickets';
  static const _messageTypeJsonKey = 'message_type';
  static const _messagesJsonKey = 'messages';
  static const _successJsonKey = 'success';
  static const _statusJsonKey = 'status';
  static const _otpExpiryTimeJsonKey = 'expired_time';
  static const _tasksJsonKey = 'tasks';
  static const _taskJsonKey = 'task';
  static const _commentsJsonKey = 'comments';

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
      if (responseStatus == 404) {
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

  Future changeEmail({
    required String newEmail,
    required String newEmailConfirmation,
    required String password,
  }) async {
    final url = urlBuilder.buildChangeEmailUrl();

    final requestJsonBody = ChangeEmailRM(
      newEmail: newEmail,
      newEmailConfirmation: newEmailConfirmation,
      password: password,
    ).toJson();

    final response = await _dio.post(
      url,
      data: requestJsonBody,
    );
    if (response.data[_statusJsonKey] == 200) {
      debugPrint('---otp ${response.data[_otpJsonKey].toString()}');
      return;
    }
    final error = response.data[_errorJsonKey];
    final errors = response.data[_errorsJsonKey];
    if (error != null &&
        error is String &&
        error.toLowerCase().contains('كلمة المرور الحالية')) {
      throw IncorrectPasswordGrowthInException();
    }
    if (errors != null && (errors[_newEmailJsonKey] != null)) {
      throw EmailAlreadyRegisteredGrowthInException();
    }
  }

  Future changePassword({
    required String currentPassword,
    required String newPassword,
    required String newPasswordConfirmation,
  }) async {
    final url = urlBuilder.buildChangePasswordUrl();

    final requestJsonBody = ChangePasswordRM(
      currentPassword: currentPassword,
      newPassword: newPassword,
      newPasswordConfirmation: newPasswordConfirmation,
    ).toJson();

    try {
      final response = await _dio.post(
        url,
        data: requestJsonBody,
      );
      final responseValue = response.data[_errorJsonKey];
      if (responseValue is String &&
          responseValue.toLowerCase().contains('كلمة المرور الحالية')) {
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

  Future changeEmailOtpVerification({
    required String userToken,
    required String email,
    required String otp,
  }) async {
    final url = urlBuilder.buildChangeEmailOtpVerificationUrl();

    final response = await _dio.post(
      url,
      data: {
        'email': email,
        'otp': otp,
      },
      options: Options(
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $userToken',
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

  Future verifyOtp({
    required String token,
    required String email,
    required String otp,
  }) async {
    final url = urlBuilder.buildVerifyOtpUrl(email, otp);

    final response = await _dio.post(
      url,
      options: Options(
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
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

  Future<List<TicketRM>> getTickets() async {
    final url = urlBuilder.buildGetTicketsUrl();
    final response = await _dio.get(
      url,
    );
    try {
      final tickets = response.data[_ticketsJsonKey] as List;
      return tickets.map((ticket) => TicketRM.fromJson(ticket)).toList();
    } catch (_) {
      rethrow;
    }
  }

  Future<List<TicketTypeRM>> getTicketsTypes() async {
    final url = urlBuilder.buildGetTicketsTypesUrl();
    final response = await _dio.get(
      url,
    );
    try {
      final ticketsTypes = response.data[_messageTypeJsonKey] as List;
      return ticketsTypes.map((ticketType) {
        return TicketTypeRM.fromJson(ticketType);
      }).toList();
    } catch (_) {
      rethrow;
    }
  }

  Future submitTicket({
    required String ticketType,
    required String ticketTitle,
    required String ticketDescription,
  }) async {
    final url = urlBuilder.buildSubmitTicketUrl();

    final requestJsonBody = CreateTicketRM(
      ticketType: ticketType,
      title: ticketTitle,
      description: ticketDescription,
    ).toJson();

    try {
      return _dio.post(
        url,
        data: requestJsonBody,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<List<TicketMessageRM>> getTicketMessages(
    int ticketId,
  ) async {
    final url = urlBuilder.buildGetTicketMessagesUrl(ticketId);
    final response = await _dio.get(
      url,
    );
    try {
      final ticketMessages = response.data[_messagesJsonKey] as List;
      return ticketMessages
          .map((ticketMessage) => TicketMessageRM.fromJson(ticketMessage))
          .toList();
    } catch (_) {
      rethrow;
    }
  }

  Future createMessage({
    required int ticketId,
    required String text,
    required File? file,
  }) async {
    final url = urlBuilder.buildCreateMessageUrl(ticketId);
    final fileExtension = file?.path.split('.').last;
    final now = DateTime.now().toString().split(" ").join("");
    final multipartFile = file != null
        ? await diox.MultipartFile.fromFile(
            file.path,
            filename: 'TICKET_#$ticketId' '_$now.$fileExtension',
          )
        : null;
    final requestJsonBody = {
      "message_text": text,
      if (multipartFile != null) "message_file[]": multipartFile,
    };

    final formData = diox.FormData.fromMap(requestJsonBody);

    try {
      await _dio.post(
        url,
        data: formData,
      );
      // debugPrint('---response: ${response.data}');
    } catch (_) {
      rethrow;
    }
  }

  Future<List<RequestV1RM>> getRequests() async {
    final url = urlBuilder.buildGetRequestsUrl();
    final response = await _dio.get(
      url,
    );
    try {
      final requests = response.data[_tasksJsonKey] as List;
      final requestsList =
          requests.map((request) => RequestV1RM.fromJson(request)).toList();
      return requestsList;
    } catch (_) {
      rethrow;
    }
  }

  Future<RequestRM> getRequest(int requestId) async {
    final url = urlBuilder.buildGetRequestUrl(requestId);
    final response = await _dio.get(
      url,
    );
    try {
      final jsonObject = response.data[_taskJsonKey];
      final request = RequestRM.fromJson(jsonObject);
      return request;
    } catch (_) {
      rethrow;
    }
  }

  Future<List<CommentRM>> getComments(int? requestId, int? actionId) async {
    final url = urlBuilder.buildGetCommentsUrl(requestId, actionId);
    final response = await _dio.get(
      url,
    );
    try {
      final status404 = response.data[_statusJsonKey] == 404;
      final emptyComments = status404 &&
          response.data[_messageJsonKey].contains('لا توجد تعليقات حتي الان');
      if (emptyComments) return [];
      final comments = response.data[_commentsJsonKey] as List;
      final commentsList =
          comments.map((comment) => CommentRM.fromJson(comment)).toList();
      return commentsList;
    } catch (_) {
      rethrow;
    }
  }

  Future toggleRequestComplete(
    bool isComplete,
    int requestId,
  ) async {
    final url = urlBuilder.buildToggleRequestCompleteUrl(isComplete, requestId);

    try {
      final response = await _dio.post(
        url,
      );
      debugPrint(response.toString());
    } catch (_) {
      rethrow;
    }
  }

  Future toggleActionStepsComplete(
    bool isComplete,
    int actionId,
  ) async {
    final url = urlBuilder.buildToggleActionStepsCompleteUrl(
      isComplete,
      actionId,
    );

    try {
      final response = await _dio.post(
        url,
      );
      debugPrint(response.toString());
    } catch (_) {
      rethrow;
    }
  }

  Future toggleSingleActionStepComplete(
    bool isComplete,
    int actionId,
    int actionStepId,
  ) async {
    final url = urlBuilder.buildToggleSingleActionStepCompleteUrl(
      isComplete,
      actionId,
      actionStepId,
    );

    try {
      final response = await _dio.post(
        url,
      );
      debugPrint(response.toString());
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
