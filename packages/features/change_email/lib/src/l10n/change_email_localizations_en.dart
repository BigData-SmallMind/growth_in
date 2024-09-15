import 'change_email_localizations.dart';

/// The translations for English (`en`).
class ChangeEmailLocalizationsEn extends ChangeEmailLocalizations {
  ChangeEmailLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get changeEmailSuccessMessage => 'Your email has been reset successfully';

  @override
  String get changeEmailScreenTitle => 'Change Email';

  @override
  String get changeEmailScreenSubtitle => 'Change Email';

  @override
  String get submissionInProgressButtonLabel => 'Submitting';

  @override
  String get submitButtonLabel => 'Submit';

  @override
  String get newEmailTextFieldLabel => 'New Email';

  @override
  String get requiredFieldErrorMessage => 'This field is required';

  @override
  String get emailTextFieldHint => 'Enter your new email';

  @override
  String get newEmailConfirmationTextFieldLabel => 'Confirm New Email';

  @override
  String get newEmailConfirmationTextFieldHint => 'Re-enter your new email';

  @override
  String get emailConfirmationTextFieldDoesNotMatchError => 'Emails do not match';

  @override
  String get generalErrorSnackBarMessage => 'An error occurred. Please try again later';

  @override
  String get invalidEmailFormatErrorMessage => 'The email you entered is incorrect';

  @override
  String get emailTextFieldAlreadyRegisteredError => 'This email is already registered';
}
