part of 'delete_meeting_cubit.dart';

class DeleteMeetingState extends Equatable {
  const DeleteMeetingState({
    this.submissionStatus = FormzSubmissionStatus.initial,
    this.cancellationReason = const Dynamic<MeetingCancellationReason?>.unvalidated(),
    this.otherReasonText = const Dynamic<String?>.unvalidated(),
  });

  final Dynamic<MeetingCancellationReason?> cancellationReason;
  final FormzSubmissionStatus submissionStatus;
  final Dynamic<String?> otherReasonText;

  DeleteMeetingState copyWith({
    Dynamic<MeetingCancellationReason?>? cancellationReason,
    FormzSubmissionStatus? submissionStatus,
    Dynamic<String?>? otherReasonText,
  }) {
    return DeleteMeetingState(
      cancellationReason: cancellationReason ?? this.cancellationReason,
      submissionStatus: submissionStatus ?? this.submissionStatus,
      otherReasonText: otherReasonText ?? this.otherReasonText,
    );
  }

  @override
  List<Object?> get props => [
        cancellationReason,
        submissionStatus,
        otherReasonText,
      ];
}

enum CancellationStatus {
  initial,
  loading,
  success,
  failure,
}
