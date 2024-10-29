part of 'post_details_cubit.dart';

class PostDetailsState extends Equatable {
  const PostDetailsState({
    this.post,
  });

  final Post? post;

  PostDetailsState copyWith() {
    return const PostDetailsState();
  }

  @override
  List<Object?> get props => [];
}

enum PostDetailsFetchingStatus {
  initial,
  inProgress,
  success,
  failure,
}
