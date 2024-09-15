part of 'change_email_cubit.dart';

class ChangeEmailState extends Equatable {
  const ChangeEmailState({
    this.emailInfoOverlayShown = false,
    this.emailInfoOverlayYOffset = 0.0,
    this.currentEmail = const Email.unvalidated(),
    this.newEmail = const Email.unvalidated(),
    this.newEmailConfirmation = const EmailConfirmation.unvalidated(),
    this.submissionStatus = FormzSubmissionStatus.initial,
  });

  final bool emailInfoOverlayShown;
  final double emailInfoOverlayYOffset;
  final Email currentEmail;
  final Email newEmail;
  final EmailConfirmation newEmailConfirmation;
  final FormzSubmissionStatus submissionStatus;

  ChangeEmailState copyWith({
    bool? emailInfoOverlayShown,
    double? emailInfoOverlayYOffset,
    Email? currentEmail,
    Email? newEmail,
    EmailConfirmation? newEmailConfirmation,
    FormzSubmissionStatus? submissionStatus,
  }) {
    return ChangeEmailState(
      emailInfoOverlayShown:
          emailInfoOverlayShown ?? this.emailInfoOverlayShown,
      emailInfoOverlayYOffset:
          emailInfoOverlayYOffset ?? this.emailInfoOverlayYOffset,
      currentEmail: currentEmail ?? this.currentEmail,
      newEmail: newEmail ?? this.newEmail,
      newEmailConfirmation:
          newEmailConfirmation ?? this.newEmailConfirmation,
      submissionStatus: submissionStatus ?? this.submissionStatus,
    );
  }

  @override
  List<Object?> get props => [
        emailInfoOverlayShown,
        emailInfoOverlayYOffset,
        currentEmail,
        newEmail,
        newEmailConfirmation,
        submissionStatus,
      ];
}
