import 'package:cms_repository/cms_repository.dart';
import 'package:domain_models/domain_models.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meeting_repository/meeting_repository.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:user_repository/user_repository.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({
    required this.userRepository,
    required this.cmsRepository,
    required this.meetingRepository,
    required this.onViewAllPostsTapped,
    required this.onMeetingTapped,
    required this.onPostTapped,
    required this.onRequestTapped,
    required this.onNavigateToFolders,
  }) : super(const HomeState()) {
    userRepository.getUser().listen((user) {
      emit(state.copyWith(user: user));
    });
    getHome();
  }

  final UserRepository userRepository;
  final CmsRepository cmsRepository;
  final MeetingRepository meetingRepository;
  final VoidCallback onViewAllPostsTapped;
  final VoidCallback onNavigateToFolders;
  final ValueSetter<int> onMeetingTapped;
  final ValueSetter<int> onPostTapped;
  final ValueSetter<int> onRequestTapped;

  void getHome() async {
    final loading =
        state.copyWith(fetchingStatus: HomeFetchingStatus.inProgress);
    emit(loading);
    try {
      final home = await userRepository.getHome();
      final homeWith3PostsOnly = home.copyWith(
        posts: home.posts.length > 3 ? home.posts.sublist(0, 3) : home.posts,
      );
      final success = state.copyWith(
        home: homeWith3PostsOnly,
        fetchingStatus: HomeFetchingStatus.success,
      );
      emit(success);
    } catch (_) {
      final error = state.copyWith(fetchingStatus: HomeFetchingStatus.failure);
      emit(error);
    }
  }

  void onNavigateToPost(Post post) {
    cmsRepository.changeNotifier.setPost(post);
    onPostTapped(post.id);
  }

  void onNavigateToMeeting(Meeting meeting) {
    meetingRepository.changeNotifier.setMeeting(meeting);
    meetingRepository.changeNotifier.setMeetingsVariation(MeetingCardVariation.upcoming);
    onMeetingTapped(meeting.id);
  }

  void onGoToDashboard() async {
    try {
      final Uri url = Uri.parse(state.home!.dashboardLink!);

      if (!await launchUrl(url)) {
        throw Exception('Could not launch $url');
      }
    } catch (e) {
      debugPrint('cant launch url!!!');
    }
  }

// @override
// Future<void> close() {
//   return super.close();
// }
}
