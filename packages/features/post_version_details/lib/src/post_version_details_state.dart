part of 'post_version_details_cubit.dart';

class PostVersionDetailsState extends Equatable {
  const PostVersionDetailsState({
    this.post,
    this.postVersion,
    this.approvalStatus = ApprovalStatus.initial,
    this.postVersionFetchingStatus = PostVersionDetailsFetchingStatus.initial,
  });

  final Post? post;
  final PostVersion? postVersion;
  final ApprovalStatus approvalStatus;
  final PostVersionDetailsFetchingStatus postVersionFetchingStatus;

  PostVersionDetailsState copyWith({
    Post? post,
    PostVersion? postVersion,
    ApprovalStatus? approvalStatus,
    PostVersionDetailsFetchingStatus? postVersionFetchingStatus,
  }) {
    return PostVersionDetailsState(
      post: post ?? this.post,
      postVersion: postVersion ?? this.postVersion,
      approvalStatus: approvalStatus ?? this.approvalStatus,
      postVersionFetchingStatus:
          postVersionFetchingStatus ?? this.postVersionFetchingStatus,
    );
  }

  @override
  List<Object?> get props => [
        post,
        postVersion,
        approvalStatus,
        postVersionFetchingStatus,
      ];
}

enum PostVersionDetailsFetchingStatus {
  initial,
  inProgress,
  success,
  failure,
}

enum ApprovalStatus {
  initial,
  inProgress,
  success,
  failure,
}
