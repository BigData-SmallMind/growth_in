import 'package:domain_models/domain_models.dart' as dm;
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:folder_repository/folder_repository.dart';

part 'file_comments_state.dart';

class FileCommentsCubit extends Cubit<FileCommentsState> {
  FileCommentsCubit({
    required this.folderRepository,
    required this.fileId,
  }) : super(
          const FileCommentsState(),
        ) {
    getComments();
  }

  final FolderRepository folderRepository;
  final TextEditingController commentController = TextEditingController();
  final int fileId;

  void getComments() async {
    final loadingState = state.copyWith(
      commentsFetchStatus: CommentsFetchStatus.loading,
    );
    emit(loadingState);
    try {
      final comments = await folderRepository.getFileComments(
        fileId: fileId,
      );
      final successState = state.copyWith(
        commentsFetchStatus: CommentsFetchStatus.success,
        comments: comments,
      );
      emit(successState);
    } catch (error) {
      final errorState = state.copyWith(
        commentsFetchStatus: CommentsFetchStatus.failure,
      );
      emit(errorState);
    }
  }

  void onCommentChanged(String newValue) {
    commentController.text = newValue;
    emit(state.copyWith(comment: newValue));
  }

  void addComment() async {
    final loadingState = state.copyWith(
      addCommentStatus: AddCommentStatus.loading,
    );
    emit(loadingState);
    try {
      final comment = commentController.text;
      await folderRepository.addComment(
        fileId: fileId,
        comment: comment,
      );
      final successState = state.copyWith(
        addCommentStatus: AddCommentStatus.success,
      );
      emit(successState);
      getComments();
      commentController.clear();
    } catch (error) {
      final errorState = state.copyWith(
        addCommentStatus: AddCommentStatus.error,
      );
      emit(errorState);
    }
  }

// @override
// Future<void> close() {
//   return super.close();
// }
}
