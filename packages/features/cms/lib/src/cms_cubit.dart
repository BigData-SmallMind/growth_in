import 'package:cms_repository/cms_repository.dart';
import 'package:domain_models/domain_models.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';

part 'cms_state.dart';

class CmsCubit extends Cubit<CmsState> {
  CmsCubit({
    required this.userRepository,
    required this.cmsRepository,
    required this.navigateToPostDetails,
  }) : super(const CmsState()) {
    init();
  }

  final UserRepository userRepository;
  final CmsRepository cmsRepository;
  final ValueSetter<int> navigateToPostDetails;

  // get cms

  Future init() async {
    final loadingState = state.copyWith(
      campaignsFetchingStatus: CampaignsFetchingStatus.inProgress,
      postsFetchingStatus: PostsFetchingStatus.inProgress,
    );
    emit(loadingState);
    final user = await userRepository.getUser().first;
    final companyId =
        user!.companies.firstWhere((company) => company.isSelected).id;
    try {
      final campaigns = await cmsRepository.getCampaigns(companyId: companyId);
      final posts = await cmsRepository.getPosts();
      final successState = state.copyWith(
        campaigns: campaigns,
        posts: posts,
        campaignsFetchingStatus: CampaignsFetchingStatus.success,
        postsFetchingStatus: PostsFetchingStatus.success,
      );
      emit(successState);
    } catch (_) {
      final failureState = state.copyWith(
        campaignsFetchingStatus: CampaignsFetchingStatus.failure,
        postsFetchingStatus: PostsFetchingStatus.failure,
      );
      emit(failureState);
    }
  }

  void onRefreshPosts() async {

    try {
      final posts = await cmsRepository.getPosts();
      final successState = state.copyWith(
        posts: posts,
        postsFetchingStatus: PostsFetchingStatus.success,
      );
      emit(successState);
    } catch (_) {
      final failureState = state.copyWith(
        postsFetchingStatus: PostsFetchingStatus.failure,
      );
      emit(failureState);
    }
  }

  void onRefreshCampaigns() async {
    final user = await userRepository.getUser().first;
    final companyId =
        user!.companies.firstWhere((company) => company.isSelected).id;
    try {
      final campaigns = await cmsRepository.getCampaigns(companyId: companyId);
      final successState = state.copyWith(
        campaigns: campaigns,
        campaignsFetchingStatus: CampaignsFetchingStatus.success,
      );
      emit(successState);
    } catch (_) {
      final failureState = state.copyWith(
        campaignsFetchingStatus: CampaignsFetchingStatus.failure,
      );
      emit(failureState);
    }
  }

// Future onPostTapped(Folder folder) async {
//   cmsRepository.changeNotifier.setFolder(folder);
//   navigateToFiles(folder.id);
// }

// @override
// Future<void> close() {
//   return super.close();
// }
}
