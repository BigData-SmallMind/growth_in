part of 'post_comments_cubit.dart';

class PostCommentsState extends Equatable {
  const PostCommentsState({
    this.comments = const [],
    this.commentsFetchStatus = CommentsFetchStatus.initial,
    this.addCommentStatus = AddCommentStatus.initial,
    this.comment,
  });

  final List<dm.Comment> comments;
  final CommentsFetchStatus commentsFetchStatus;
  final AddCommentStatus addCommentStatus;
  final String? comment;



  PostCommentsState copyWith({
    List<dm.Comment>? comments,
    CommentsFetchStatus? commentsFetchStatus,
    AddCommentStatus? addCommentStatus,
    String? comment,

  }) {
    return PostCommentsState(
      comments: comments ?? this.comments,
      commentsFetchStatus: commentsFetchStatus ?? this.commentsFetchStatus,
      addCommentStatus: addCommentStatus ?? this.addCommentStatus,
      comment: comment ?? this.comment,
    );
  }

  @override
  List<Object?> get props => [
        comments,
        commentsFetchStatus,
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
