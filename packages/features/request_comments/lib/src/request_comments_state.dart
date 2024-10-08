part of 'request_comments_cubit.dart';

class RequestCommentsState extends Equatable {
  const RequestCommentsState({
    this.comments = const [],
    this.commentsFetchStatus = CommentsFetchStatus.initial,
    this.actionId,
    this.addCommentStatus = AddCommentStatus.initial,
    this.comment,
  });

  final List<dm.Comment> comments;
  final CommentsFetchStatus commentsFetchStatus;
  final int? actionId;
  final AddCommentStatus addCommentStatus;
  final String? comment;



  RequestCommentsState copyWith({
    dm.Request? request,
    List<dm.Comment>? comments,
    CommentsFetchStatus? commentsFetchStatus,
    AddCommentStatus? addCommentStatus,
    String? comment,

  }) {
    return RequestCommentsState(
      comments: comments ?? this.comments,
      commentsFetchStatus: commentsFetchStatus ?? this.commentsFetchStatus,
      actionId: actionId,

      addCommentStatus: addCommentStatus ?? this.addCommentStatus,
      comment: comment ?? this.comment,
    );
  }

  @override
  List<Object?> get props => [
        comments,
        commentsFetchStatus,
        actionId,
        addCommentStatus,
        comment,
      ];
}

enum CommentsFetchStatus {
  initial,
  loading,
  success,
  failure,
}


enum AddCommentStatus {
  initial,
  loading,
  success,
  error,
}
