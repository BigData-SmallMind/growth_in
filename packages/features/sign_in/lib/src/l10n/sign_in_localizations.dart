import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'sign_in_localizations_ar.dart';
import 'sign_in_localizations_en.dart';

/// Callers can lookup localized strings with an instance of SignInLocalizations
/// returned by `SignInLocalizations.of(context)`.
///
/// Applications need to include `SignInLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/sign_in_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: SignInLocalizations.localizationsDelegates,
///   supportedLocales: SignInLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the SignInLocalizations.supportedLocales
/// property.
abstract class SignInLocalizations {
  SignInLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static SignInLocalizations of(BuildContext context) {
    return Localizations.of<SignInLocalizations>(context, SignInLocalizations)!;
  }

  static const LocalizationsDelegate<SignInLocalizations> delegate = _SignInLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en')
  ];

  /// No description provided for @signInSuccessSnackBarMessage.
  ///
  /// In en, this message translates to:
  /// **'Signed in successfully'**
  String get signInSuccessSnackBarMessage;

  /// No description provided for @chooseCompanyTitle.
  ///
  /// In en, this message translates to:
  /// **'Choose a company'**
  String get chooseCompanyTitle;

  /// No description provided for @chooseCompanyHintText.
  ///
  /// In en, this message translates to:
  /// **'You can change the company later as well'**
  String get chooseCompanyHintText;

  /// No description provided for @signInGreetingTitle.
  ///
  /// In en, this message translates to:
  /// **'Welcome'**
  String get signInGreetingTitle;

  /// No description provided for @generalErrorSnackBarMessage.
  ///
  /// In en, this message translates to:
  /// **'ٍSomething went wrong'**
  String get generalErrorSnackBarMessage;

  /// No description provided for @invalidCredentialsErrorMessage.
  ///
  /// In en, this message translates to:
  /// **'Incorrect email or password'**
  String get invalidCredentialsErrorMessage;

  /// No description provided for @requiredFieldErrorMessage.
  ///
  /// In en, this message translates to:
  /// **'Required*'**
  String get requiredFieldErrorMessage;

  /// No description provided for @emailTextFieldLabel.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get emailTextFieldLabel;

  /// No description provided for @invalidEmailFormatErrorMessage.
  ///
  /// In en, this message translates to:
  /// **'Invalid email format'**
  String get invalidEmailFormatErrorMessage;

  /// No description provided for @passwordTextFieldLabel.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get passwordTextFieldLabel;

  /// No description provided for @rememberMeCheckBoxLabel.
  ///
  /// In en, this message translates to:
  /// **'Remember Me'**
  String get rememberMeCheckBoxLabel;

  /// No description provided for @forgotMyPasswordButtonLabel.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password'**
  String get forgotMyPasswordButtonLabel;

  /// No description provided for @signInButtonLabel.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get signInButtonLabel;

  /// No description provided for @signInInProgressButtonLabel.
  ///
  /// In en, this message translates to:
  /// **'Signing In'**
  String get signInInProgressButtonLabel;
}

class _SignInLocalizationsDelegate extends LocalizationsDelegate<SignInLocalizations> {
  const _SignInLocalizationsDelegate();

  @override
  Future<SignInLocalizations> load(Locale locale) {
    return SynchronousFuture<SignInLocalizations>(lookupSignInLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_SignInLocalizationsDelegate old) => false;
}

SignInLocalizations lookupSignInLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar': return SignInLocalizationsAr();
    case 'en': return SignInLocalizationsEn();
  }

  throw FlutterError(
    'SignInLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
