import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:growth_in_api/growth_in_api.dart';

class OpenLineChatApi {
  final Dio _dio;
  final UrlBuilder _urlBuilder;

  OpenLineChatApi(
    this._dio,
    this._urlBuilder,
  );

  Future<DateGroupedChatsRM> getChatMessages() async {
    final url = _urlBuilder.buildGetChatMessagesUrl();
    try {
      final response = await _dio.get(
        url,
      );
      final messages = response.data;
      final messagesRM = DateGroupedChatsRM.fromJson(messages);
      return messagesRM;
    } catch (_) {
      rethrow;
    }
  }

  Future sendMessage({
    required int companyId,
    String? message,
    List<File>? files,
  }) async {
    final url = _urlBuilder.buildSendChatMessageUrl(companyId: companyId);
    final now = DateTime.now().toIso8601String();
    List<MultipartFile> multipartFiles = [];
    if (files != null) {
      for (var file in files) {
        final fileExtension = file.path.split('.').last;
        final multipartFile = await MultipartFile.fromFile(
          file.path,
          filename:
              '${file.path.split('.')[file.path.split('.').length - 2]}$now.$fileExtension',
        );
        multipartFiles.add(multipartFile);
      }
    }

    final requestJsonBody = {
      if (files != null)
        for (var i = 0; i < multipartFiles.length; i++)
          'message_file[$i]': multipartFiles[i],
      'content': message ?? '',
    };

    final formData = FormData.fromMap(
      requestJsonBody,
      ListFormat.multiCompatible,
    );
    try {
      await _dio.post(
        url,
        data: formData,
      );
    } catch (_) {
      rethrow;
    }
  }
}
