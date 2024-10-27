import 'dart:async';
import 'package:dio/dio.dart';
import 'package:growth_in_api/growth_in_api.dart';

class FilesAndFoldersApi {
  final Dio _dio;
  final UrlBuilder _urlBuilder;
  static const _filesJsonKey = 'files';

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
      final responseJsonBody = (response.data[_filesJsonKey] as List)[0][_filesJsonKey] as List;
      final files = responseJsonBody.map((e) => FileV2RM.fromJson(e)).toList();

      return files;
    } catch (_) {
      rethrow;
    }
  }
}
