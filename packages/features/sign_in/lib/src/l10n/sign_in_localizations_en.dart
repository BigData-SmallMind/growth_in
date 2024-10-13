import 'sign_in_localizations.dart';

/// The translations for English (`en`).
class SignInLocalizationsEn extends SignInLocalizations {
  SignInLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get signInSuccessSnackBarMessage => 'Signed in successfully';

  @override
  String get chooseCompanyTitle => 'Choose a company';

  @override
  String get chooseCompanyHintText => 'You can change the company later as well';

  @override
  String get signInGreetingTitle => 'Welcome';

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
  String get passwordTextFieldLabel => 'Password';

  @override
  String get rememberMeCheckBoxLabel => 'Remember Me';

  @override
  String get forgotMyPasswordButtonLabel => 'Forgot Password';

  @override
  String get signInButtonLabel => 'Sign In';

  @override
  String get signInInProgressButtonLabel => 'Signing In';
}
