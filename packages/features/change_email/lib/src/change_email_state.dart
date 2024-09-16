part of 'change_email_cubit.dart';

class ChangeEmailState extends Equatable {
  const ChangeEmailState({
    this.newEmail = const Email.unvalidated(),
    this.newEmailConfirmation = const EmailConfirmation.unvalidated(),
    this.password = const Password.unvalidated(),
    this.submissionStatus = FormzSubmissionStatus.initial,
  });

  final Email newEmail;
  final EmailConfirmation newEmailConfirmation;
  final Password password;
  final FormzSubmissionStatus submissionStatus;

  ChangeEmailState copyWith({
    Email? newEmail,
    EmailConfirmation? newEmailConfirmation,
    Password? password,
    FormzSubmissionStatus? submissionStatus,
  }) {
    return ChangeEmailState(
      newEmail: newEmail ?? this.newEmail,
      newEmailConfirmation: newEmailConfirmation ?? this.newEmailConfirmation,
      password: password ?? this.password,
      submissionStatus: submissionStatus ?? this.submissionStatus,
    );
  }

  @override
  List<Object?> get props => [
        newEmail,
        newEmailConfirmation,
        password,
        submissionStatus,
      ];
}
