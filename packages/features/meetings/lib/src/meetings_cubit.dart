import 'package:domain_models/domain_models.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meeting_repository/meeting_repository.dart';

part 'meetings_state.dart';

class MeetingsCubit extends Cubit<MeetingsState> {
  MeetingsCubit({
    required this.meetingRepository,
    required this.onViewAllTapped,
    required this.onMeetingTapped,
    required this.onCancelMeetingTapped,
    required this.onCreateMeetingTapped,
    required this.onScheduleMeetingTapped,

  }) : super(
          const MeetingsState(),
        ) {
    getMeetings();
    meetingRepository.changeNotifier.addListener(() {
      if (meetingRepository.changeNotifier.shouldReFetchMeetings == true) {
        getMeetings().then((_) {
          meetingRepository.changeNotifier.clearShouldReFetchMeetings();
        });
      }
    });
  }

  final VoidCallback onViewAllTapped;
  final MeetingRepository meetingRepository;
  final ValueSetter<int> onMeetingTapped;
  final ValueSetter<Meeting> onCancelMeetingTapped;
  final VoidCallback onCreateMeetingTapped;
  final ValueSetter<Meeting> onScheduleMeetingTapped;

  Future getMeetings() async {
    final loading = state.copyWith(
      meetingsStatus: MeetingsStatus.loading,
    );
    emit(loading);
    try {
      final meetings = await meetingRepository.getMeetings();
      final success = state.copyWith(
        meetings: meetings,
        meetingsStatus: MeetingsStatus.success,
      );
      emit(success);
    } catch (error) {
      final failure = state.copyWith(
        meetingsStatus: MeetingsStatus.failure,
      );
      emit(failure);
    }
  }

  void setMeetingsCardsType(MeetingCardVariation variation) =>
      meetingRepository.changeNotifier.setMeetingsVariation(variation);

  void onMeetingDetailsTapped(Meeting meeting, MeetingCardVariation variation) {
    meetingRepository.changeNotifier.setMeeting(meeting);
    setMeetingsCardsType(variation);
    onMeetingTapped(meeting.id);
  }

  // @override
  // Future<void> close() async {
  //   debugPrint('asdasdas');
  //   return super.close();
  // }
}
