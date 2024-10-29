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
  }) : super(
          CmsState(
            timelineTabDate: DateTime.now(),
            calendarTabDate: DateTime.now(),
          ),
        ) {
    init();
  }

  final UserRepository userRepository;
  final CmsRepository cmsRepository;
  final ValueSetter<int> navigateToPostDetails;

  // get cms

  Future init() async {
    getPosts();
    getCampaigns();
  }

  Future getPosts() async {
    final loadingState = state.copyWith(
      postsFetchingStatus: PostsFetchingStatus.inProgress,
    );
    emit(loadingState);
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

  Future getCampaigns() async {
    final loadingState = state.copyWith(
      campaignsFetchingStatus: CampaignsFetchingStatus.inProgress,
    );
    emit(loadingState);
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

  void setTimelineTabMonth(DateTime dateTime) {
    emit(state.copyWith(
      timelineTabDate: dateTime,
    ));
  }

  bool hasPost(DateTime date) {
    // Check if the date is in the list of post dates
    return state.postDates.any((postDate) =>
        postDate.year == date.year &&
        postDate.month == date.month &&
        postDate.day == date.day);
  }

  bool hasAcceptedPost(DateTime date) {
    return state.posts!.any((post) =>
        post.publicationDate.year == date.year &&
        post.publicationDate.month == date.month &&
        post.publicationDate.day == date.day &&
        post.status == PostStatus.accepted);
  }

  bool hasNewPost(DateTime date) {
    return state.posts!.any((post) =>
        post.publicationDate.year == date.year &&
        post.publicationDate.month == date.month &&
        post.publicationDate.day == date.day &&
        post.status == PostStatus.newPost);
  }

  bool hasEditingPost(DateTime date) {
    return state.posts!.any((post) =>
        post.publicationDate.year == date.year &&
        post.publicationDate.month == date.month &&
        post.publicationDate.day == date.day &&
        post.status == PostStatus.editing);
  }

  void setCalendarTabDate(DateTime value) {
    emit(state.copyWith(calendarTabDate: value));
  }

  void setCalendarTabViewType(CalendarTabViewType? value) {
    emit(state.copyWith(calendarTabViewType: value));
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
