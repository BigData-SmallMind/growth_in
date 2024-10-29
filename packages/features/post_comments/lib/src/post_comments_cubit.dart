import 'package:cms_repository/cms_repository.dart';
import 'package:domain_models/domain_models.dart' as dm;
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'post_comments_state.dart';

class PostCommentsCubit extends Cubit<PostCommentsState> {
  PostCommentsCubit({
    required this.cmsRepository,
    required this.postId,
  }) : super(
          const PostCommentsState(),
        ) {
    getComments();
  }

  final CmsRepository cmsRepository;
  final TextEditingController commentController = TextEditingController();
  final int postId;

  void getComments() async {
    final loadingState = state.copyWith(
      commentsFetchStatus: CommentsFetchStatus.loading,
    );
    emit(loadingState);
    try {
      final comments = await cmsRepository.getPostComments(postId: postId);
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
      await cmsRepository.addComment(
        postId: postId,
        comment: comment,
      );
      final successState = state.copyWith(
        addCommentStatus: AddCommentStatus.success,
      );
      emit(successState);
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
