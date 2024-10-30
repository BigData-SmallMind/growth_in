import 'package:cms_repository/cms_repository.dart';
import 'package:domain_models/domain_models.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'post_version_details_state.dart';

class PostVersionDetailsCubit extends Cubit<PostVersionDetailsState> {
  PostVersionDetailsCubit({
    required this.cmsRepository,
  }) : super(PostVersionDetailsState(
          postVersion: cmsRepository.changeNotifier.postVersion,
        )) {
    getPostVersionDetails();
  }

  final CmsRepository cmsRepository;

  Future getPostVersionDetails() async {
    final loadingState = state.copyWith(
      postVersionFetchingStatus: PostVersionDetailsFetchingStatus.inProgress,
    );
    emit(loadingState);
    try {
      final post = await cmsRepository.getPostVersionDetails(
        versionId: state.postVersion!.id,
      );
      final successState = state.copyWith(
        post: post,
        postVersionFetchingStatus: PostVersionDetailsFetchingStatus.success,
      );
      emit(successState);
    } catch (error) {
      final failureState = state.copyWith(
        postVersionFetchingStatus: PostVersionDetailsFetchingStatus.failure,
      );
      emit(failureState);
    }
  }

  void approvePostVersion() async {
    try {
      final loading = state.copyWith(
        approvalStatus: ApprovalStatus.inProgress,
      );
      emit(loading);
      await cmsRepository.approvePostVersion(
        versionId: state.postVersion!.id,
      );

      final successState = state.copyWith(
        approvalStatus: ApprovalStatus.success,
      );
      emit(successState);
    } catch (error) {
      final errorState = state.copyWith(
        approvalStatus: ApprovalStatus.failure,
      );
      emit(errorState);
    }
  }
// @override
// Future<void> close() {
//   return super.close();
// }
}
