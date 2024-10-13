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
      availableSlotsFetchStatus: AvailableSlotsFetchStatus.loading,
    );
    emit(loadingAvailableSlots);
    try {
      final availableSlots = await meetingRepository.getAvailableSlots(
        date: date,
      );
      final successAvailableSlots = ScheduleMeetingState(
        availableSlots: availableSlots,
        availableSlotsFetchStatus: AvailableSlotsFetchStatus.success,
      );
      emit(successAvailableSlots);
    } catch (error) {
      final failureAvailableSlots = state.copyWith(
        availableSlotsFetchStatus: AvailableSlotsFetchStatus.failure,
        availableSlots: [],
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

// @override
// Future<void> close() async {
//   userRepository.deleteOtpVerificationTokenSupplierString();
//   return super.close();
// }
}
