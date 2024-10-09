import 'package:domain_models/domain_models.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meeting_repository/meeting_repository.dart';

part 'search_meetings_state.dart';

class SearchMeetingsCubit extends Cubit<SearchMeetingsState> {
  SearchMeetingsCubit({
    required this.meetingRepository,
    required this.oMeetingTapped,
  }) : super(
          SearchMeetingsState(
              variation: meetingRepository.changeNotifier.meetingCardVariation),
        ) {
    getSearchMeetings();
  }

  final MeetingRepository meetingRepository;
  final ValueSetter<int> oMeetingTapped;

  void getSearchMeetings() async {
    final loading = state.copyWith(
      searchMeetingsStatus: SearchMeetingsStatus.loading,
    );
    emit(loading);
    try {
      final searchMeetings = await meetingRepository.getMeetings();
      final success = state.copyWith(
        meetings: searchMeetings,
        searchMeetingsStatus: SearchMeetingsStatus.success,
      );
      emit(success);
    } catch (error) {
      final failure = state.copyWith(
        searchMeetingsStatus: SearchMeetingsStatus.failure,
      );
      emit(failure);
    }
  }

  void onMeetingDetailsTapped(Meeting meeting){
    meetingRepository.changeNotifier.setMeeting(meeting);
    oMeetingTapped(meeting.id);
  }

// @override
// Future<void> close() async {
//   userRepository.deleteOtpVerificationTokenSupplierString();
//   return super.close();
// }
}
