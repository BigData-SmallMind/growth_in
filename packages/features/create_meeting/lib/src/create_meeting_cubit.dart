import 'dart:io';

import 'package:domain_models/domain_models.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_fields/form_fields.dart';
import 'package:meeting_repository/meeting_repository.dart';
import 'package:user_repository/user_repository.dart';

part 'create_meeting_state.dart';

class CreateMeetingCubit extends Cubit<CreateMeetingState> {
  CreateMeetingCubit({
    required this.meetingRepository,
    required this.userRepository,
  }) : super(
          const CreateMeetingState(),
        ) {
    getMeetingTypes();
  }

  final MeetingRepository meetingRepository;
  final UserRepository userRepository;

  void getMeetingTypes() async {
    final loadingMeetingTypes = state.copyWith(
        meetingTypesFetchStatus: MeetingTypesFetchStatus.inProgress);
    emit(loadingMeetingTypes);
    try {
      final meetingTypes = await meetingRepository.getMeetingTypes();
      final newState = state.copyWith(
        meetingTypes: meetingTypes,
        meetingTypesFetchStatus: MeetingTypesFetchStatus.success,
      );
      emit(newState);
    } catch (error) {
      final newState = state.copyWith(
        meetingTypesFetchStatus: MeetingTypesFetchStatus.failure,
      );
      emit(newState);
    }
  }

  void onTitleChanged(String? newValue) {
    final previousScreenState = state;
    final previousTitleState = previousScreenState.title;
    final shouldValidate = previousTitleState.isNotValid;
    final newTitleState = shouldValidate
        ? Dynamic<String>.validated(
            newValue,
            isRequired: true,
          )
        : Dynamic<String>.unvalidated(
            newValue,
          );

    final newScreenState = state.copyWith(
      title: newTitleState,
    );

    emit(newScreenState);
  }

  void onTitleUnfocused() {
    final previousScreenState = state;
    final previousTitleState = previousScreenState.title;
    final previousTitleValue = previousTitleState.value;

    final newTitleState = Dynamic<String>.validated(
      previousTitleValue,
      isRequired: true,
    );
    final newScreenState = previousScreenState.copyWith(
      title: newTitleState,
    );
    emit(newScreenState);
  }

  void onDescriptionChanged(String? newValue) {
    final newScreenState = state.copyWith(
      description: newValue,
    );
    emit(newScreenState);
  }

  Future pickFiles() async {
    final FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
    );

    if (result != null) {
      final files =
          result.files.map((platformFile) => File(platformFile.path!)).toList();
      final newState = state.copyWith(
        files: files,
      );
      emit(newState);
    } else {
      // User canceled the picker
    }
  }

  void deletePickedFiles() {
    final newState = state.copyWith(
      files: [],
    );
    emit(newState);
  }

  onMeetingTypeChanged(MeetingType meetingType) {
    final newState = state.copyWith(
      selectedType: Dynamic<MeetingType?>.validated(
        meetingType,
        isRequired: true,
      ),
    );
    emit(newState);
  }

  void getAvailableSlotsForSelectedMonth(DateTime date) async {
    final loading = state.copyWithAvailableSlotsInMonthStatus(
      availableSlotsInMonthFetchStatus:
          AvailableSlotsInAMonthFetchStatus.loading,
      availableSlotsInAMonth: const [],
    );
    emit(loading);
    try {
      final availableSlotsInAMonth =
          await meetingRepository.getAvailableMeetingSlotsInAMonth(date: date);
      final success = state.copyWithAvailableSlotsInMonthStatus(
        availableSlotsInMonthFetchStatus:
            AvailableSlotsInAMonthFetchStatus.success,
        availableSlotsInAMonth: availableSlotsInAMonth,
      );
      emit(success);
    } catch (error) {
      final failure = state.copyWithAvailableSlotsInMonthStatus(
        availableSlotsInMonthFetchStatus:
            AvailableSlotsInAMonthFetchStatus.failure,
        availableSlotsInAMonth: const [],
      );
      emit(failure);
    }
  }

  void getAvailableSlots(DateTime date) async {
    final loadingAvailableSlots = state.copyWithAvailableSlotsInADayStatus(
      availableSlotsFetchStatus: AvailableSlotsInADayFetchStatus.loading,
      availableSlots: const [],
      selectedDay: date,
    );
    emit(loadingAvailableSlots);
    try {
      final availableSlots = await meetingRepository.getAvailableSlots(
        date: date,
      );
      final successAvailableSlots = state.copyWithAvailableSlotsInADayStatus(
        availableSlots: availableSlots,
        selectedDay: state.selectedDay,
        availableSlotsFetchStatus: AvailableSlotsInADayFetchStatus.success,
      );
      emit(successAvailableSlots);
    } catch (error) {
      final failureAvailableSlots = state.copyWithAvailableSlotsInADayStatus(
        availableSlotsFetchStatus: AvailableSlotsInADayFetchStatus.failure,
        selectedDay: state.selectedDay,
        availableSlots: const [],
      );
      emit(failureAvailableSlots);
    }
  }

  void selectMeetingSlot(MeetingSlot meetingSlot) {
    final newState = state.copyWith(
      selectedSlot: meetingSlot,
    );
    emit(newState);
  }

  void onFirstStepSubmit() async {
    final title = Dynamic<String>.validated(
      state.title.value,
      isRequired: true,
    );
    final selectedType = Dynamic<MeetingType?>.validated(
      state.selectedType.value,
      isRequired: true,
    );

    final isFormValid = Formz.validate([
      title,
      selectedType,
    ]);

    final newState = state.copyWith(
      title: title,
      selectedType: selectedType,
      currentStep: 0,
    );

    emit(newState);
    if (isFormValid) {
      final newState = state.copyWith(
        currentStep: 1,
      );
      emit(newState);
      getAvailableSlotsForSelectedMonth(state.selectedDay ?? DateTime.now());
      // getAvailableSlots(state.selectedDay ?? DateTime.now());
    }
  }

  void onSecondStepSubmit() async {
    final newState = state.copyWith(
      currentStep: 2,
    );
    emit(newState);
  }

  void onLastStepSubmit() async {
    final newState = state.copyWith(
      submissionStatus: FormzSubmissionStatus.inProgress,
    );

    emit(newState);

    try {
      await meetingRepository.createMeeting(
        title: state.title.value!,
        description: state.description,
        files: state.files,
        type: state.selectedType.value!,
        meetingSlot: state.selectedSlot!,
        selectedDay: state.selectedDay!,
      );

      final newState = state.copyWith(
        submissionStatus: FormzSubmissionStatus.success,
      );
      emit(newState);
    } catch (error) {
      final newState = state.copyWith(
        submissionStatus: FormzSubmissionStatus.failure,
      );
      emit(newState);
    }
  }

  void onStepContinue() {
    if (state.currentStep == 0) {
      onFirstStepSubmit();
      return;
    }
    if (state.currentStep == 1) {
      onSecondStepSubmit();
      return;
    }
    if (state.currentStep == 2) onLastStepSubmit();
  }

  void onStepTapped(int newValue) {
    if (newValue > state.currentStep) return;
    final newState = state.copyWith(
      currentStep: newValue,
    );
    emit(newState);
  }
}
