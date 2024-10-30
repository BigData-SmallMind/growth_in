import 'package:cms_repository/cms_repository.dart';
import 'package:domain_models/domain_models.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'post_versions_state.dart';

class PostVersionDetailsCubit extends Cubit<PostVersionDetailsState> {
  PostVersionDetailsCubit({
    required this.cmsRepository,
    required this.onPostVersionTapped,
    required this.postId,
  }) : super(const PostVersionDetailsState()) {
    getPostVersions();
  }

  final CmsRepository cmsRepository;
  final VoidCallback onPostVersionTapped;
  final int postId;

  Future getPostVersions() async {
    final loadingState = state.copyWith(
      postVersionsFetchingStatus: PostVersionDetailsFetchingStatus.inProgress,
    );
    emit(loadingState);
    try {
      final postVersions =
          await cmsRepository.getPostVersions(postId: postId);
      final successState = state.copyWith(
        postVersions: postVersions,
        postVersionsFetchingStatus: PostVersionDetailsFetchingStatus.success,
      );
      emit(successState);
    } catch (error) {
      final failureState = state.copyWith(
        postVersionsFetchingStatus: PostVersionDetailsFetchingStatus.failure,
      );
      emit(failureState);
    }
  }

  void onPostVersionTap(PostVersion postVersion) {
    onPostVersionTapped();
    cmsRepository.changeNotifier.setPostVersion(postVersion);
  }
// @override
// Future<void> close() {
//   return super.close();
// }
}
