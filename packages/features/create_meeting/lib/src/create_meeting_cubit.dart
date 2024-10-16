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
    );

    emit(newState);

    if (isFormValid) {
      final newState = state.copyWith(
        currentStep: 1,
      );
      emit(newState);
    }
  }

  void getAvailableSlots(DateTime date) async {
    final loadingAvailableSlots = state.copyWithAvailableSlotsStatus(
      availableSlotsFetchStatus: AvailableSlotsFetchStatus.loading,
      availableSlots: const [],
      selectedDay: date,
    );
    emit(loadingAvailableSlots);
    try {
      final availableSlots = await meetingRepository.getAvailableSlots(
        date: date,
      );
      final successAvailableSlots = state.copyWithAvailableSlotsStatus(
        availableSlots: availableSlots,
        selectedDay: state.selectedDay,
        availableSlotsFetchStatus: AvailableSlotsFetchStatus.success,
      );
      emit(successAvailableSlots);
    } catch (error) {
      final failureAvailableSlots = state.copyWithAvailableSlotsStatus(
        availableSlotsFetchStatus: AvailableSlotsFetchStatus.failure,
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

  void onSecondStepSubmit() async {
    final newState = state.copyWith(
      currentStep: 2,
    );
    emit(newState);
  }

// void onLastStepSubmit() async {
//   final title = Dynamic<String>.validated(
//     state.title.value,
//     isRequired: true,
//   );
//   final selectedType = Dynamic<MeetingType?>.validated(
//     state.selectedType.value,
//     isRequired: true,
//   );
//
//   final isFormValid = Formz.validate([
//     title,
//     selectedType,
//   ]);
//
//   final newState = state.copyWith(
//     title: title,
//     selectedType: selectedType,
//     submissionStatus: isFormValid
//         ? FormzSubmissionStatus.inProgress
//         : FormzSubmissionStatus.initial,
//   );
//
//   emit(newState);
//
//   if (isFormValid) {
//     final user = await userRepository.getUser().first;
//     try {
//       await meetingRepository.createMeeting(
//         title: title.value!,
//         description: state.description,
//         files: state.files,
//         type: selectedType.value!.name,
//         userId: user!.id,
//       );
//
//       final newState = state.copyWith(currentStep: 2,);
//       emit(newState);
//     } catch (error) {
//       final newState = state.copyWith(
//         title: Dynamic<String>.validated(
//           title.value,
//           isRequired: true,
//         ),
//         selectedType: Dynamic<MeetingType?>.validated(
//           selectedType.value,
//           isRequired: true,
//         ),
//       );
//       emit(newState);
//     }
//   }
// }

// @override
// Future<void> close() async {
//   return super.close();
// }
//   @override
//   Future<void> onChange(change) async {
//     print('+++++++${change.currentState.email}');
//     print('-------${change.nextState.email}');
//     super.onChange(change);
//   }
  void onStepContinue() {
    if (state.currentStep == 0) onFirstStepSubmit();
    if (state.currentStep == 1) onSecondStepSubmit();
    // if (state.currentStep == 2) onLastStepSubmit();
  }
}
