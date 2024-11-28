part of 'create_meeting_cubit.dart';

class CreateMeetingState extends Equatable {
  const CreateMeetingState({
    this.currentStep = 0,
    this.meetingTypesFetchStatus = MeetingTypesFetchStatus.initial,
    this.title = const Dynamic<String>.unvalidated(),
    this.description,
    this.files = const [],
    this.meetingTypes = const [],
    this.selectedType = const Dynamic<MeetingType?>.unvalidated(),
    this.availableSlotsInADayFetchStatus =
        AvailableSlotsInADayFetchStatus.initial,
    this.availableSlotsInADay,
    this.availableSlotsInAMonthFetchStatus =
        AvailableSlotsInAMonthFetchStatus.initial,
    this.availableSlotsInAMonth = const [],
    this.selectedDay,
    this.selectedSlot,
    this.submissionStatus = FormzSubmissionStatus.initial,
  });

  final int currentStep;
  final MeetingTypesFetchStatus meetingTypesFetchStatus;
  final Dynamic<String> title;
  final String? description;
  final List<File> files;
  final List<MeetingType> meetingTypes;
  final Dynamic<MeetingType?> selectedType;
  final AvailableSlotsInADayFetchStatus availableSlotsInADayFetchStatus;
  final List<MeetingSlot>? availableSlotsInADay;
  final AvailableSlotsInAMonthFetchStatus availableSlotsInAMonthFetchStatus;
  final List<MeetingSlotAvailable> availableSlotsInAMonth;
  final DateTime? selectedDay;
  final MeetingSlot? selectedSlot;
  final FormzSubmissionStatus submissionStatus;

  List<FileDM> get filesDM => files
      .map(
        (file) => FileDM(
          name: file.path.split('/').last,
          size: file.lengthSync(),
          extension: file.path.split('.').last,
        ),
      )
      .toList();

  CreateMeetingState copyWith({
    int? currentStep,
    MeetingTypesFetchStatus? meetingTypesFetchStatus,
    Dynamic<String>? title,
    String? description,
    List<File>? files,
    List<MeetingType>? meetingTypes,
    Dynamic<MeetingType?>? selectedType,
    AvailableSlotsInADayFetchStatus? availableSlotsInADayFetchStatus,
    List<MeetingSlot>? availableSlotsInADay,
    DateTime? selectedDay,
    MeetingSlot? selectedSlot,
    FormzSubmissionStatus? submissionStatus,
  }) {
    return CreateMeetingState(
      currentStep: currentStep ?? this.currentStep,
      meetingTypesFetchStatus:
          meetingTypesFetchStatus ?? this.meetingTypesFetchStatus,
      title: title ?? this.title,
      description: description ?? this.description,
      files: files ?? this.files,
      meetingTypes: meetingTypes ?? this.meetingTypes,
      availableSlotsInADayFetchStatus: availableSlotsInADayFetchStatus ??
          this.availableSlotsInADayFetchStatus,
      availableSlotsInADay: availableSlotsInADay ?? this.availableSlotsInADay,
      selectedType: selectedType ?? this.selectedType,
      selectedDay: selectedDay ?? this.selectedDay,
      selectedSlot: selectedSlot ?? this.selectedSlot,
      availableSlotsInAMonthFetchStatus: availableSlotsInAMonthFetchStatus,
      availableSlotsInAMonth: availableSlotsInAMonth,
      submissionStatus: submissionStatus ?? this.submissionStatus,
    );
  }

  CreateMeetingState copyWithAvailableSlotsInADayStatus({
    AvailableSlotsInADayFetchStatus? availableSlotsFetchStatus,
    List<MeetingSlot>? availableSlots,
    DateTime? selectedDay,
  }) {
    return CreateMeetingState(
      currentStep: currentStep,
      meetingTypesFetchStatus: meetingTypesFetchStatus,
      title: title,
      description: description,
      files: files,
      meetingTypes: meetingTypes,
      selectedType: selectedType,
      availableSlotsInADayFetchStatus:
          availableSlotsFetchStatus ?? AvailableSlotsInADayFetchStatus.loading,
      availableSlotsInAMonth: availableSlotsInAMonth,
      availableSlotsInAMonthFetchStatus: availableSlotsInAMonthFetchStatus,
      availableSlotsInADay: availableSlots,
      selectedDay: selectedDay,
      selectedSlot: null,
      submissionStatus: submissionStatus,
    );
  }

  CreateMeetingState copyWithAvailableSlotsInMonthStatus({
    required AvailableSlotsInAMonthFetchStatus availableSlotsInMonthFetchStatus,
    required List<MeetingSlotAvailable> availableSlotsInAMonth,
  }) {
    return CreateMeetingState(
      currentStep: currentStep,
      meetingTypesFetchStatus: meetingTypesFetchStatus,
      title: title,
      description: description,
      files: files,
      meetingTypes: meetingTypes,
      selectedType: selectedType,
      availableSlotsInADayFetchStatus: availableSlotsInADayFetchStatus,
      availableSlotsInADay: availableSlotsInADay,
      availableSlotsInAMonthFetchStatus: availableSlotsInMonthFetchStatus,
      availableSlotsInAMonth: availableSlotsInAMonth,
      selectedDay: selectedDay,
      selectedSlot: null,
      submissionStatus: submissionStatus,

    );
  }

  @override
  List<Object?> get props => [
        currentStep,
        meetingTypesFetchStatus,
        title,
        description,
        files,
        meetingTypes,
        selectedType,
        availableSlotsInADayFetchStatus,
        availableSlotsInADay,
        availableSlotsInAMonthFetchStatus,
        availableSlotsInAMonth,
        selectedDay,
        selectedSlot,
        submissionStatus,
      ];
}

enum MeetingTypesFetchStatus {
  initial,
  inProgress,
  success,
  failure,
}

enum AvailableSlotsInADayFetchStatus {
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
