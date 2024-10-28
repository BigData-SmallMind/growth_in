import 'package:domain_models/domain_models.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:folder_repository/folder_repository.dart';
import 'package:user_repository/user_repository.dart';

part 'files_state.dart';

class FilesCubit extends Cubit<FilesState> {
  FilesCubit({
    required this.userRepository,
    required this.folderRepository,
    required this.folderId,
    required this.navigateToFile,
  }) : super(const FilesState()) {
    getFiles();
  }

  final UserRepository userRepository;
  final FolderRepository folderRepository;
  final int folderId;
  final ValueSetter<int> navigateToFile;

  // get files

  Future getFiles() async {
    final loadingState =
        state.copyWith(fetchingStatus: FilesFetchingStatus.inProgress);
    emit(loadingState);
    try {
      final files = await folderRepository.getFiles(folderId: folderId);
      final successState = state.copyWith(
        fetchingStatus: FilesFetchingStatus.success,
        files: files,
      );
      emit(successState);
    } catch (_) {
      final failureState = state.copyWith(
        fetchingStatus: FilesFetchingStatus.failure,
      );
      emit(failureState);
    }
  }

  Future onFileTapped(FileV2DM file) async {
    folderRepository.changeNotifier.setFile(file);
    navigateToFile(file.id);
  }

// @override
// Future<void> close() {
//   return super.close();
// }

  void downloadFiles(List<String> slugs) async {
    try {
      await folderRepository.downloadFiles(slugs);
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
