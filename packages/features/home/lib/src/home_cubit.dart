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
    required this.onViewAllMeetingsTapped,
    required this.onMeetingTapped,
    required this.onPostTapped,
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
  final VoidCallback onViewAllMeetingsTapped;
  final VoidCallback onNavigateToFolders;
  final ValueSetter<int> onMeetingTapped;
  final ValueSetter<int> onPostTapped;

  void getHome() async {
    final loading =
        state.copyWith(fetchingStatus: HomeFetchingStatus.inProgress);
    emit(loading);
    try {
      final home = await userRepository.getHome();
      final success = state.copyWith(
        home: home,
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
