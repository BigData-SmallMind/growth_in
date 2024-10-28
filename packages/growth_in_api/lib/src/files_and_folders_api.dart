import 'dart:async';
import 'package:dio/dio.dart';
import 'package:growth_in_api/growth_in_api.dart';

class FilesAndFoldersApi {
  final Dio _dio;
  final UrlBuilder _urlBuilder;
  static const _filesJsonKey = 'files';
  static const _commentsJsonKey = 'comments';

  FilesAndFoldersApi(
    this._dio,
    this._urlBuilder,
  );

  Future<FoldersRM> getFolders({
    required int companyId,
  }) async {
    final url = _urlBuilder.buildGetFoldersUrl(
      companyId,
    );
    try {
      final response = await _dio.get(
        url,
      );
      final folders = FoldersRM.fromJson(response.data);

      return folders;
    } catch (_) {
      rethrow;
    }
  }

  Future<List<FileV2RM>> getFiles({
    required int folderId,
  }) async {
    final url = _urlBuilder.buildGetFilesUrl(
      folderId,
    );
    try {
      final response = await _dio.get(
        url,
      );
      final responseJsonBody =
          (response.data[_filesJsonKey] as List)[0][_filesJsonKey] as List;
      final files = responseJsonBody.map((e) => FileV2RM.fromJson(e)).toList();

      return files;
    } catch (_) {
      rethrow;
    }
  }

  Future approveFile({
    required int fileId,
    required bool shouldApprove,
  }) async {
    final url = _urlBuilder.buildVerifyFileUrl(
      fileId,
      shouldApprove,
    );
    try {
      await _dio.post(
        url,
      );
    } catch (_) {
      rethrow;
    }
  }

  Future<List<CommentRM>> getFileComments({
    required int fileId,
  }) async {
    final url = _urlBuilder.buildGetFileCommentsUrl(
      fileId,
    );
    try {
      final response = await _dio.get(
        url,
      );
      final comments = response.data[_commentsJsonKey] as List;
      final commentsList =
          comments.map((comment) => CommentRM.fromJson(comment)).toList();
      return commentsList;
    } catch (_) {
      rethrow;
    }
  }

  void addComment({
    required int fileId,
    required String comment,
  }) {
    final url = _urlBuilder.buildAddFileCommentUrl(
      fileId,
    );
    try {
      _dio.post(
        url,
        data: {
          'comment': comment,
        },
      );
    } catch (_) {
      rethrow;
    }
  }
}
