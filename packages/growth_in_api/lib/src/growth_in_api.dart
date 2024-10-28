import 'dart:async';
import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as diox;
import 'package:flutter/material.dart';
import 'package:growth_in_api/growth_in_api.dart';
import 'package:growth_in_api/src/cms_api.dart';
import 'package:growth_in_api/src/files_and_folders_api.dart';
import 'package:growth_in_api/src/forms_api.dart';
import 'package:growth_in_api/src/meetings_api.dart';
import 'package:growth_in_api/src/pusher_api.dart';

typedef TokenSupplier = Future<String?> Function();

class GrowthInApi {
  GrowthInApi({
    required TokenSupplier userTokenSupplier,
    required TokenSupplier otpVerificationTokenSupplier,
    required this.isUserUnAuthenticatedVN,
    required this.internetConnectionErrorVN,
    required this.dio,
    required this.urlBuilder,
  })  : auth = AuthApi(dio, urlBuilder),
        requests = RequestsApi(dio, urlBuilder),
        filesAndFoldersApi = FilesAndFoldersApi(dio, urlBuilder),
        cmsApi = CmsApi(dio, urlBuilder),
        meetings = MeetingsApi(dio, urlBuilder),
        openLineChatApi = OpenLineChatApi(dio, urlBuilder),
        formsApi = FormsApi(dio, urlBuilder),
        pusherApi = PusherApi() {
    dio.setUpAuthHeaders(
      userTokenSupplier: userTokenSupplier,
      otpVerificationTokenSupplier: otpVerificationTokenSupplier,
      isUserUnAuthSC: isUserUnAuthenticatedVN,
      internetConnectionErrorVN: internetConnectionErrorVN,
    );
    dio.interceptors.add(
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
  final Dio dio;
  final ValueNotifier<bool> isUserUnAuthenticatedVN;
  final ValueNotifier internetConnectionErrorVN;
  final UrlBuilder urlBuilder;
  final AuthApi auth;
  final RequestsApi requests;
  final FilesAndFoldersApi filesAndFoldersApi;
  final CmsApi cmsApi;
  final MeetingsApi meetings;
  final OpenLineChatApi openLineChatApi;
  final FormsApi formsApi;
  final PusherApi pusherApi;
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
