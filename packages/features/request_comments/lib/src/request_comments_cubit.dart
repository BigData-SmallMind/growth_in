import 'package:domain_models/domain_models.dart' as dm;
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:request_repository/request_repository.dart';

part 'request_comments_state.dart';

class RequestCommentsCubit extends Cubit<RequestCommentsState> {
  RequestCommentsCubit({
    required this.requestRepository,
    required this.requestId,
  }) : super(
          RequestCommentsState(),
        ) {
    getComments();
  }

  final RequestRepository requestRepository;
  final TextEditingController commentController = TextEditingController();
  final int requestId;

  void getComments() async {
    final loadingState = state.copyWith(
      commentsFetchStatus: CommentsFetchStatus.loading,
    );
    emit(loadingState);
    try {
      final comments = await requestRepository.getRequestComments(requestId);
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
      await requestRepository.addComment(
        actionId: null,
        requestId: requestId,
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

  @override
  Future<void> close() {
    return super.close();
  }
}
