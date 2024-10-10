import 'package:domain_models/domain_models.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_fields/form_fields.dart';
import 'package:meeting_repository/meeting_repository.dart';

part 'delete_meeting_state.dart';

class DeleteMeetingCubit extends Cubit<DeleteMeetingState> {
  DeleteMeetingCubit({
    required this.meetingRepository,
    required this.meeting,
    required this.locale,
    required this.onCancellationSuccess,
  }) : super(
          const DeleteMeetingState(),
        );
  final MeetingRepository meetingRepository;
  final Meeting meeting;
  final Locale locale;
  final VoidCallback onCancellationSuccess;

  void onCancellationReasonChanged(MeetingCancellationReason? value) {
    final newState = state.copyWith(
      cancellationReason: Dynamic<MeetingCancellationReason?>.validated(
        value,
        isRequired: true,
      ),
    );
    emit(newState);
  }

  void onOtherCancellationTextFieldChanged(String value) {
    final shouldValidate = state.otherReasonText.isNotValid &&
        state.cancellationReason.value == MeetingCancellationReason.other;
    final newState = state.copyWith(
      otherReasonText: shouldValidate
          ? Dynamic<String?>.validated(
              value,
            )
          : Dynamic<String?>.unvalidated(
              value,
            ),
    );
    emit(newState);
  }

  void onSubmit() async {
    final cancellationReason = Dynamic<MeetingCancellationReason?>.validated(
      state.cancellationReason.value,
      isRequired: true,
    );
    final otherReasonText = Dynamic<String?>.validated(
      state.otherReasonText.value,
      isRequired: true,
    );
    final isFormValid = Formz.validate([
      cancellationReason,
      if (state.cancellationReason.value == MeetingCancellationReason.other)
        otherReasonText,
    ]);

    final newState = state.copyWith(
      cancellationReason: cancellationReason,
      otherReasonText: otherReasonText,
      submissionStatus: isFormValid
          ? FormzSubmissionStatus.inProgress
          : FormzSubmissionStatus.initial,
    );

    emit(newState);

    if (isFormValid) {
      try {
        final isArabic = locale.languageCode == 'ar';
        final localizedReason = isArabic
            ? state.cancellationReason.value!.nameAr
            : state.cancellationReason.value!.nameEn;
        final isOtherReason =
            state.cancellationReason.value == MeetingCancellationReason.other;
        await meetingRepository.deleteMeeting(
          id: meeting.id,
          reason:
              isOtherReason ? state.otherReasonText.value! : localizedReason,
        );
        final newState = state.copyWith(
          submissionStatus: FormzSubmissionStatus.success,
        );
        emit(newState);
      } catch (error) {
        final newState = state.copyWith(
          cancellationReason: Dynamic<MeetingCancellationReason?>.validated(
            state.cancellationReason.value,
            isRequired: true,
          ),
          otherReasonText: Dynamic<String?>.validated(
            state.otherReasonText.value,
            isRequired: state.cancellationReason.value ==
                MeetingCancellationReason.other,
          ),
          submissionStatus: FormzSubmissionStatus.failure,
        );
        emit(newState);
      }
    }
  }

// @override
// Future<void> close() async {
//   userRepository.deleteOtpVerificationTokenSupplierString();
//   return super.close();
// }
}
