import 'package:domain_models/domain_models.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:folder_repository/folder_repository.dart';

import 'package:user_repository/user_repository.dart';

part 'file_state.dart';

class FileCubit extends Cubit<FileState> {
  FileCubit({
    required this.userRepository,
    required this.folderRepository,
    required this.onCommentsTapped,
  }) : super(
          FileState(
            file: folderRepository.changeNotifier.file,
            folder: folderRepository.changeNotifier.folder,
          ),
        );

  final UserRepository userRepository;
  final FolderRepository folderRepository;
  final VoidCallback onCommentsTapped;

  void downloadFiles(List<String> slugs) {
    try {
      folderRepository.downloadFiles(slugs);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void approveFile({
    required bool shouldApprove,
  }) async {
    final isRejecting = !shouldApprove;
    final isApproving = shouldApprove;
    try {
      final loading = state.copyWith(
        approvalStatus:
            isApproving ? ApprovalStatus.inProgress : ApprovalStatus.initial,
        rejectionStatus:
            isRejecting ? RejectionStatus.inProgress : RejectionStatus.initial,
      );
      emit(loading);
      await folderRepository.approveFile(
        fileId: state.file!.id,
        shouldApprove: shouldApprove,
      );
      final successState = state.copyWith(
        approvalStatus:
            isApproving ? ApprovalStatus.success : ApprovalStatus.initial,
        rejectionStatus:
            isRejecting ? RejectionStatus.success : RejectionStatus.initial,
      );
      emit(successState);
    } catch (error) {
      final errorState = state.copyWith(
        approvalStatus:
            isApproving ? ApprovalStatus.failure : ApprovalStatus.initial,
        rejectionStatus:
            isRejecting ? RejectionStatus.failure : RejectionStatus.initial,
      );
      emit(errorState);
    }
  }

// @override
// Future<void> close() async {
//   return super.close();
// }
// @override
// Future<void> onChange(change) async {
//   print('+++++++${change.currentState.email}');
//   print('-------${change.nextState.email}');
//   super.onChange(change);
// }
}
