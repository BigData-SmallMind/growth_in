import 'package:domain_models/domain_models.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:cms_repository/src/folders_change_notifier.dart';
import 'package:cms_repository/src/mappers/mappers.dart';
import 'package:growth_in_api/growth_in_api.dart';
import 'package:key_value_storage/key_value_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:request_repository/request_repository.dart';

class FolderRepository {
  FolderRepository({
    required KeyValueStorage noSqlStorage,
    required this.remoteApi,
    required this.downloadUrl,
  }) : changeNotifier = FolderChangeNotifier();

  final GrowthInApi remoteApi;
  final FolderChangeNotifier changeNotifier;
  final String downloadUrl;

  Future<Folders> getFolders({
    required int companyId,
  }) async {
    try {
      final folders = await remoteApi.filesAndFoldersApi.getFolders(
        companyId: companyId,
      );

      final domainFolders = folders.toDomainModel();
      return domainFolders;
    } catch (error) {
      rethrow;
    }
  }

  Future<List<FileV2DM>> getFiles({
    required int folderId,
  }) async {
    try {
      final files = await remoteApi.filesAndFoldersApi.getFiles(
        folderId: folderId,
      );

      final domainFiles = files.map((e) => e.toDomainModel()).toList();
      return domainFiles;
    } catch (error) {
      rethrow;
    }
  }

  Future approveFile({
    required int fileId,
    required bool shouldApprove,
  }) async {
    try {
      await remoteApi.filesAndFoldersApi.approveFile(
        fileId: fileId,
        shouldApprove: shouldApprove,
      );
    } catch (error) {
      rethrow;
    }
  }

  Future<List<Comment>> getFileComments({
    required int fileId,
  }) async {
    try {
      final comments = await remoteApi.filesAndFoldersApi.getFileComments(
        fileId: fileId,
      );

      final domainComments = comments.map((e) => e.toDomainModel()).toList();
      return domainComments;
    } catch (error) {
      rethrow;
    }
  }

  Future addComment({
    required int fileId,
    required String comment,
  }) async {
    try {
      remoteApi.filesAndFoldersApi.addComment(
        fileId: fileId,
        comment: comment,
      );
    } catch (error) {
      rethrow;
    }
  }

  Future downloadFiles(List<String> slugs) async {
    try {
      final downloadPermissionStatus = await Permission.storage.request();
      if (downloadPermissionStatus.isGranted) {
        for (final slug in slugs) {
          final fileUrl = '$downloadUrl/$slug';
          final downloadPath = await getExternalStorageDirectory();
          final taskId = await FlutterDownloader.enqueue(
            url: fileUrl,
            savedDir: downloadPath?.path ?? '/storage/emulated/0/Download',
            fileName: slug,
            showNotification: true,
            openFileFromNotification: true,
          );
          debugPrint(taskId.toString());
          debugPrint(fileUrl.toString());
        }
        return;
      } else {
        debugPrint('Permission denied');
      }
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }
}
