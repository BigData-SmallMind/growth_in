part of 'schedule_meeting_cubit.dart';

class ScheduleMeetingState extends Equatable {
  const ScheduleMeetingState({
    this.availableSlots,
    this.availableSlotsFetchStatus = AvailableSlotsFetchStatus.initial,
    this.submissionStatus = FormzSubmissionStatus.initial,
    this.selectedSlot,
    this.selectedDay,
  });
  final List<MeetingSlot>? availableSlots;
  final AvailableSlotsFetchStatus availableSlotsFetchStatus;
  final FormzSubmissionStatus submissionStatus;
  final MeetingSlot? selectedSlot;
  final DateTime? selectedDay;
  ScheduleMeetingState copyWith({
    List<MeetingSlot>? availableSlots,
    AvailableSlotsFetchStatus? availableSlotsFetchStatus,
    FormzSubmissionStatus? submissionStatus,
    MeetingSlot? selectedSlot,
    DateTime? selectedDay,
  }) {
    return ScheduleMeetingState(
      availableSlots: availableSlots ?? this.availableSlots,
      availableSlotsFetchStatus:
          availableSlotsFetchStatus ?? this.availableSlotsFetchStatus,
      selectedSlot: selectedSlot ?? this.selectedSlot,
      submissionStatus: submissionStatus ?? this.submissionStatus,
      selectedDay: selectedDay ?? this.selectedDay,
    );
  }

  @override
  List<Object?> get props => [
        submissionStatus,
        availableSlotsFetchStatus,
        availableSlots,
        selectedSlot,
        selectedDay,
      ];
}

enum AvailableSlotsFetchStatus {
  initial,
  loading,
  success,
  failure,
}
