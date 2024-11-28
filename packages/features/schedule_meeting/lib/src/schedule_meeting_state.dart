part of 'schedule_meeting_cubit.dart';

class ScheduleMeetingState extends Equatable {
  const ScheduleMeetingState({
    this.availableSlotsInADay,
    this.availableSlotsInADayFetchStatus = AvailableSlotsFetchStatus.initial,
    this.submissionStatus = FormzSubmissionStatus.initial,
    this.availableSlotsInAMonthFetchStatus =
        AvailableSlotsInAMonthFetchStatus.initial,
    this.availableSlotsInAMonth = const [],
    this.selectedSlot,
    this.selectedDay,
  });
  final List<MeetingSlot>? availableSlotsInADay;
  final AvailableSlotsFetchStatus availableSlotsInADayFetchStatus;
  final AvailableSlotsInAMonthFetchStatus availableSlotsInAMonthFetchStatus;
  final List<MeetingSlotAvailable> availableSlotsInAMonth;
  final FormzSubmissionStatus submissionStatus;
  final MeetingSlot? selectedSlot;
  final DateTime? selectedDay;
  ScheduleMeetingState copyWith({
    List<MeetingSlot>? availableSlotsInADay,
    AvailableSlotsFetchStatus? availableSlotsInADayFetchStatus,
    AvailableSlotsInAMonthFetchStatus? availableSlotsInAMonthFetchStatus,
    List<MeetingSlotAvailable>? availableSlotsInAMonth,
    FormzSubmissionStatus? submissionStatus,
    MeetingSlot? selectedSlot,
    DateTime? selectedDay,
  }) {
    return ScheduleMeetingState(
      availableSlotsInADay: availableSlotsInADay ?? this.availableSlotsInADay,
      availableSlotsInADayFetchStatus:
          availableSlotsInADayFetchStatus ?? this.availableSlotsInADayFetchStatus,
      availableSlotsInAMonthFetchStatus: availableSlotsInAMonthFetchStatus ??
          this.availableSlotsInAMonthFetchStatus,
      availableSlotsInAMonth: availableSlotsInAMonth ?? this.availableSlotsInAMonth,
      selectedSlot: selectedSlot ?? this.selectedSlot,
      submissionStatus: submissionStatus ?? this.submissionStatus,
      selectedDay: selectedDay ?? this.selectedDay,

    );
  }

  @override
  List<Object?> get props => [
        submissionStatus,
        availableSlotsInADayFetchStatus,
        availableSlotsInAMonthFetchStatus,
        availableSlotsInAMonth,
        availableSlotsInADay,
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

enum AvailableSlotsInAMonthFetchStatus {
  initial,
  loading,
  success,
  failure,
}