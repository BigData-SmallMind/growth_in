import 'package:domain_models/domain_models.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:folder_repository/folder_repository.dart';
import 'package:user_repository/user_repository.dart';

part 'folders_state.dart';

class FoldersCubit extends Cubit<FoldersState> {
  FoldersCubit({
    required this.userRepository,
    required this.folderRepository,
    required this.navigateToFiles,
  }) : super(const FoldersState()) {
    getFolders();
  }

  final UserRepository userRepository;
  final FolderRepository folderRepository;
  final ValueSetter<int> navigateToFiles;

  // get folders

  Future getFolders() async {
    final loadingState =
        state.copyWith(fetchingStatus: FoldersFetchingStatus.inProgress);
    emit(loadingState);
    final user = await userRepository.getUser().first;
    final companyId =
        user!.companies.firstWhere((company) => company.isSelected).id;
    try {
      final folders = await folderRepository.getFolders(companyId: companyId);
      final successState = state.copyWith(
        fetchingStatus: FoldersFetchingStatus.success,
        folders: folders,
      );
      emit(successState);
    } catch (_) {
      final failureState = state.copyWith(
        fetchingStatus: FoldersFetchingStatus.failure,
      );
      emit(failureState);
    }
  }

  Future onFolderTapped(Folder folder) async {
    folderRepository.changeNotifier.setFolder(folder);
    navigateToFiles(folder.id);
  }

// @override
// Future<void> close() {
//   return super.close();
// }
}
