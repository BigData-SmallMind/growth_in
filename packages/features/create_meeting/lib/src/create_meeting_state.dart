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
    this.availableSlotsFetchStatus = AvailableSlotsFetchStatus.initial,
    this.availableSlots,
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
  final AvailableSlotsFetchStatus availableSlotsFetchStatus;
  final List<MeetingSlot>? availableSlots;
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
    AvailableSlotsFetchStatus? availableSlotsFetchStatus,
    List<MeetingSlot>? availableSlots,
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
      availableSlotsFetchStatus:
          availableSlotsFetchStatus ?? this.availableSlotsFetchStatus,
      availableSlots: availableSlots ?? this.availableSlots,
      selectedType: selectedType ?? this.selectedType,
      selectedDay: selectedDay ?? this.selectedDay,
      selectedSlot: selectedSlot ?? this.selectedSlot,
      submissionStatus: submissionStatus ?? this.submissionStatus,
    );
  }

  CreateMeetingState copyWithAvailableSlotsStatus({
    AvailableSlotsFetchStatus? availableSlotsFetchStatus,
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
      availableSlotsFetchStatus:
          availableSlotsFetchStatus ?? AvailableSlotsFetchStatus.loading,
      availableSlots: availableSlots,
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
        availableSlotsFetchStatus,
        availableSlots,
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

enum AvailableSlotsFetchStatus {
  initial,
  loading,
  success,
  failure,
}
