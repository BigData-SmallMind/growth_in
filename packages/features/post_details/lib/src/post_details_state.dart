part of 'post_details_cubit.dart';

class PostDetailsState extends Equatable {
  const PostDetailsState({
    this.post,
    this.approvalStatus = ApprovalStatus.initial,
  });

  final Post? post;
  final ApprovalStatus approvalStatus;

  PostDetailsState copyWith({
    ApprovalStatus? approvalStatus,
    Post? post,
  }) {
    return PostDetailsState(
      post: post ?? this.post,
      approvalStatus: approvalStatus ?? this.approvalStatus,
    );
  }

  @override
  List<Object?> get props => [
        post,
        approvalStatus,
      ];
}

enum ApprovalStatus {
  initial,
  inProgress,
  success,
  failure,
}
