import 'change_password_localizations.dart';

/// The translations for English (`en`).
class ChangePasswordLocalizationsEn extends ChangePasswordLocalizations {
  ChangePasswordLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get changePasswordSuccessMessage => 'Your password has been reset successfully';

  @override
  String get changePasswordScreenTitle => 'Change Password';

  @override
  String get changePasswordScreenSubtitle => 'Change Password';

  @override
  String get submissionInProgressButtonLabel => 'Submitting';

  @override
  String get submitButtonLabel => 'Submit';

  @override
  String get newPasswordTextFieldLabel => 'New Password';

  @override
  String get requiredFieldErrorMessage => 'This field is required';

  @override
  String get currentPasswordTextFieldLabel => 'Current Password';

  @override
  String get currentPasswordTextFieldHint => 'Enter your current password';

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

  @override
  String get generalErrorSnackBarMessage => 'An error occurred. Please try again later';

  @override
  String get wrongPasswordErrorMessage => 'The password you entered is incorrect';

  @override
  String get passwordTextFieldWeakPasswordErrorDescription => 'The password must have At least 6 characters long, Contains at least one uppercase letter, Contains at least one lowercase letter, Contains at least one number, Contains at least one symbol (e.g., @, \$, !, etc.)';
}
