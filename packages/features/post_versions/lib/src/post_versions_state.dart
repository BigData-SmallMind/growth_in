part of 'post_versions_cubit.dart';

class PostVersionDetailsState extends Equatable {
  const PostVersionDetailsState({
    this.postVersions,
    this.postVersionsFetchingStatus = PostVersionDetailsFetchingStatus.initial,
  });

  final List<PostVersion>? postVersions;
  final PostVersionDetailsFetchingStatus postVersionsFetchingStatus;

  PostVersionDetailsState copyWith({
    List<PostVersion>? postVersions,
    PostVersionDetailsFetchingStatus? postVersionsFetchingStatus ,
  }) {
    return PostVersionDetailsState(
      postVersions: postVersions ?? this.postVersions,
      postVersionsFetchingStatus: postVersionsFetchingStatus ?? this.postVersionsFetchingStatus,
    );
  }

  @override
  List<Object?> get props => [
        postVersions,
    postVersionsFetchingStatus,
      ];
}

enum PostVersionDetailsFetchingStatus {
  initial,
  inProgress,
  success,
  failure,
}
