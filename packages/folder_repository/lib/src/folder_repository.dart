import 'package:domain_models/domain_models.dart';
import 'package:folder_repository/src/folders_change_notifier.dart';
import 'package:folder_repository/src/mappers/mappers.dart';
import 'package:growth_in_api/growth_in_api.dart';
import 'package:key_value_storage/key_value_storage.dart';

class FolderRepository {
  FolderRepository({
    required KeyValueStorage noSqlStorage,
    required this.remoteApi,
  }) : changeNotifier = FolderChangeNotifier();

  final GrowthInApi remoteApi;
  final FolderChangeNotifier changeNotifier;

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
}
