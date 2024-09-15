part of 'change_password_cubit.dart';

class ChangePasswordState extends Equatable {
  const ChangePasswordState({
    this.passwordInfoOverlayShown = false,
    this.passwordInfoOverlayYOffset = 0.0,
    this.currentPassword = const Password.unvalidated(),
    this.newPassword = const Password.unvalidated(),
    this.newPasswordConfirmation = const PasswordConfirmation.unvalidated(),
    this.submissionStatus = FormzSubmissionStatus.initial,
  });

  final bool passwordInfoOverlayShown;
  final double passwordInfoOverlayYOffset;
  final Password currentPassword;
  final Password newPassword;
  final PasswordConfirmation newPasswordConfirmation;
  final FormzSubmissionStatus submissionStatus;

  ChangePasswordState copyWith({
    bool? passwordInfoOverlayShown,
    double? passwordInfoOverlayYOffset,
    Password? currentPassword,
    Password? newPassword,
    PasswordConfirmation? newPasswordConfirmation,
    FormzSubmissionStatus? submissionStatus,
  }) {
    return ChangePasswordState(
      passwordInfoOverlayShown:
          passwordInfoOverlayShown ?? this.passwordInfoOverlayShown,
      passwordInfoOverlayYOffset:
          passwordInfoOverlayYOffset ?? this.passwordInfoOverlayYOffset,
      currentPassword: currentPassword ?? this.currentPassword,
      newPassword: newPassword ?? this.newPassword,
      newPasswordConfirmation:
          newPasswordConfirmation ?? this.newPasswordConfirmation,
      submissionStatus: submissionStatus ?? this.submissionStatus,
    );
  }

  @override
  List<Object?> get props => [
        passwordInfoOverlayShown,
        passwordInfoOverlayYOffset,
        currentPassword,
        newPassword,
        newPasswordConfirmation,
        submissionStatus,
      ];
}
