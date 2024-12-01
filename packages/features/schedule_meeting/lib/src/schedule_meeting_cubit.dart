import 'package:domain_models/domain_models.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_fields/form_fields.dart';
import 'package:meeting_repository/meeting_repository.dart';

part 'schedule_meeting_state.dart';

class ScheduleMeetingCubit extends Cubit<ScheduleMeetingState> {
  ScheduleMeetingCubit({
    required this.meetingRepository,
    required this.meeting,
    required this.locale,
    required this.onSchedulingSuccess,
  }) : super(
          const ScheduleMeetingState(),
        );
  final MeetingRepository meetingRepository;
  final Meeting meeting;
  final Locale locale;
  final VoidCallback onSchedulingSuccess;

  void getAvailableSlots(DateTime date) async {
    final loadingAvailableSlots = state.copyWith(
      availableSlotsInADayFetchStatus: AvailableSlotsFetchStatus.loading,
      selectedDay: date,
    );
    emit(loadingAvailableSlots);
    try {
      final availableSlots = await meetingRepository.getAvailableSlots(
        date: date,
      );
      final successAvailableSlots = state.copyWith(
        availableSlotsInADay: availableSlots,
        selectedDay: state.selectedDay,
        availableSlotsInADayFetchStatus: AvailableSlotsFetchStatus.success,
      );
      emit(successAvailableSlots);
    } catch (error) {
      final failureAvailableSlots = state.copyWith(
        availableSlotsInADayFetchStatus: AvailableSlotsFetchStatus.failure,
        selectedDay: state.selectedDay,
        availableSlotsInADay: const [],
      );
      emit(failureAvailableSlots);
    }
  }

  void selectMeetingSlot(MeetingSlot meetingSlot) {
    emit(
      state.copyWith(
        selectedSlot: meetingSlot,
      ),
    );
  }

  void scheduleMeeting() async {
    final loading = state.copyWith(
      submissionStatus: FormzSubmissionStatus.inProgress,
    );
    emit(loading);
    try {
      await meetingRepository.updateMeetingDate(
        id: meeting.id,
        meetingSlot: state.selectedSlot!,
        selectedDay: state.selectedDay!,
      );
      final success = state.copyWith(
        submissionStatus: FormzSubmissionStatus.success,
      );
      emit(success);
      onSchedulingSuccess();
    } catch (error) {
      final failure = state.copyWith(
        submissionStatus: FormzSubmissionStatus.failure,
      );
      emit(failure);
    }
  }

  void getAvailableSlotsForSelectedMonth(DateTime date) async {
    final loading = state.copyWith(
      availableSlotsInAMonthFetchStatus:
          AvailableSlotsInAMonthFetchStatus.loading,
      availableSlotsInAMonth: const [],
    );
    emit(loading);
    try {
      final availableSlotsInAMonth =
          await meetingRepository.getAvailableMeetingSlotsInAMonth(date: date);
      final success = state.copyWith(
        availableSlotsInAMonthFetchStatus:
            AvailableSlotsInAMonthFetchStatus.success,
        availableSlotsInAMonth: availableSlotsInAMonth,
      );
      emit(success);
    } catch (error) {
      final failure = state.copyWith(
        availableSlotsInAMonthFetchStatus:
            AvailableSlotsInAMonthFetchStatus.failure,
        availableSlotsInAMonth: const [],
      );
      emit(failure);
    }
  }

  // @override
  // Future<void> close() async {
  //   userRepository.deleteOtpVerificationTokenSupplierString();
  //   return super.close();
  // }
}
