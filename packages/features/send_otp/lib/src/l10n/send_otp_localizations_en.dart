import 'send_otp_localizations.dart';

/// The translations for English (`en`).
class SendOtpLocalizationsEn extends SendOtpLocalizations {
  SendOtpLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get sendOtpTitle => 'ٍSomething went wrong';

  @override
  String get sendOtpSubtitle => 'ٍSomething went wrong';

  @override
  String get otpSentSuccessfullySnackBarMessage => 'ٍSomething went wrong';

  @override
  String get generalErrorSnackBarMessage => 'ٍSomething went wrong';

  @override
  String get invalidCredentialsErrorMessage => 'Incorrect email or password';

  @override
  String get requiredFieldErrorMessage => 'Required*';

  @override
  String get emailTextFieldLabel => 'Email';

  @override
  String get invalidEmailFormatErrorMessage => 'Invalid email format';

  @override
  String get emailNotRegisteredErrorMessage => 'Email not registered';

  @override
  String get sendOtpProgressButtonLabel => 'Sending OTP';

  @override
  String get sendOtpButtonLabel => 'Send OTP';
}
