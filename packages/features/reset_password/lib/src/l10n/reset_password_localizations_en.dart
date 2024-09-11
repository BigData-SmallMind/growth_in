import 'reset_password_localizations.dart';

/// The translations for English (`en`).
class ResetPasswordLocalizationsEn extends ResetPasswordLocalizations {
  ResetPasswordLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get resetPasswordSuccessMessage => 'Your password has been reset successfully';

  @override
  String get resetPasswordScreenTitle => 'Reset Password';

  @override
  String get resetPasswordScreenSubtitle => 'Reset Password';

  @override
  String get submissionInProgressButtonLabel => 'Submitting';

  @override
  String get submitButtonLabel => 'Submit';

  @override
  String get newPasswordTextFieldLabel => 'New Password';

  @override
  String get requiredFieldErrorMessage => 'This field is required';

  @override
  String get passwordTextFieldWeakPasswordError => 'The password is too weak';

  @override
  String get passwordTextFieldHint => 'Enter your new password';

  @override
  String get newPasswordConfirmationTextFieldLabel => 'Confirm New Password';

  @override
  String get newPasswordConfirmationTextFieldHint => 'Re-enter your new password';

  @override
  String get passwordConfirmationTextFieldDoesNotMatchError => 'Passwords do not match';
}
