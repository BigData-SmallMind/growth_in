import 'package:domain_models/domain_models.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:folder_repository/folder_repository.dart';
import 'package:user_repository/user_repository.dart';

part 'cms_state.dart';

class CmsCubit extends Cubit<CmsState> {
  CmsCubit({
    required this.userRepository,
    required this.folderRepository,
    required this.navigateToFiles,
  }) : super(const CmsState()) {
    getCms();
  }

  final UserRepository userRepository;
  final FolderRepository folderRepository;
  final ValueSetter<int> navigateToFiles;

  // get cms

  Future getCms() async {
    final loadingState =
        state.copyWith(fetchingStatus: CmsFetchingStatus.inProgress);
    emit(loadingState);
    final user = await userRepository.getUser().first;
    final companyId =
        user!.companies.firstWhere((company) => company.isSelected).id;
    try {
      final cms = await folderRepository.getCms(companyId: companyId);
      final successState = state.copyWith(
        fetchingStatus: CmsFetchingStatus.success,
        cms: cms,
      );
      emit(successState);
    } catch (_) {
      final failureState = state.copyWith(
        fetchingStatus: CmsFetchingStatus.failure,
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
