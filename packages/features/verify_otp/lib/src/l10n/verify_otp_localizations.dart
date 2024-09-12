import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'verify_otp_localizations_ar.dart';
import 'verify_otp_localizations_en.dart';

/// Callers can lookup localized strings with an instance of VerifyOtpLocalizations
/// returned by `VerifyOtpLocalizations.of(context)`.
///
/// Applications need to include `VerifyOtpLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/verify_otp_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: VerifyOtpLocalizations.localizationsDelegates,
///   supportedLocales: VerifyOtpLocalizations.supportedLocales,
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
/// be consistent with the languages listed in the VerifyOtpLocalizations.supportedLocales
/// property.
abstract class VerifyOtpLocalizations {
  VerifyOtpLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static VerifyOtpLocalizations of(BuildContext context) {
    return Localizations.of<VerifyOtpLocalizations>(context, VerifyOtpLocalizations)!;
  }

  static const LocalizationsDelegate<VerifyOtpLocalizations> delegate = _VerifyOtpLocalizationsDelegate();

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

  /// No description provided for @verifyOtpTitle.
  ///
  /// In en, this message translates to:
  /// **'Verify OTP'**
  String get verifyOtpTitle;

  /// No description provided for @otpResentSuccessfullySnackBarMessage.
  ///
  /// In en, this message translates to:
  /// **'OTP resent successfully'**
  String get otpResentSuccessfullySnackBarMessage;

  /// No description provided for @otpResentErrorSnackBarMessage.
  ///
  /// In en, this message translates to:
  /// **'Error occurred while resending OTP'**
  String get otpResentErrorSnackBarMessage;

  /// No description provided for @otpVerifiedSuccessfullySnackBarMessage.
  ///
  /// In en, this message translates to:
  /// **'OTP verified successfully'**
  String get otpVerifiedSuccessfullySnackBarMessage;

  /// No description provided for @generalErrorSnackBarMessage.
  ///
  /// In en, this message translates to:
  /// **'An error occurred'**
  String get generalErrorSnackBarMessage;

  /// No description provided for @verifyOtpSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Enter the OTP sent to your phone number'**
  String get verifyOtpSubtitle;

  /// No description provided for @requiredFieldErrorMessage.
  ///
  /// In en, this message translates to:
  /// **'Required*'**
  String get requiredFieldErrorMessage;

  /// No description provided for @incorrectOtpCodeErrorMessage.
  ///
  /// In en, this message translates to:
  /// **'The OTP you entered is incorrect, please try again'**
  String get incorrectOtpCodeErrorMessage;

  /// No description provided for @verifyingOtpButtonLabel.
  ///
  /// In en, this message translates to:
  /// **'Verifying'**
  String get verifyingOtpButtonLabel;

  /// No description provided for @verifyOtpButtonLabel.
  ///
  /// In en, this message translates to:
  /// **'Verify OTP'**
  String get verifyOtpButtonLabel;

  /// No description provided for @emailNotRegisteredErrorMessage.
  ///
  /// In en, this message translates to:
  /// **'The email you entered is not registered'**
  String get emailNotRegisteredErrorMessage;

  /// No description provided for @resendOtpButtonLabel.
  ///
  /// In en, this message translates to:
  /// **'Resend OTP'**
  String get resendOtpButtonLabel;
}

class _VerifyOtpLocalizationsDelegate extends LocalizationsDelegate<VerifyOtpLocalizations> {
  const _VerifyOtpLocalizationsDelegate();

  @override
  Future<VerifyOtpLocalizations> load(Locale locale) {
    return SynchronousFuture<VerifyOtpLocalizations>(lookupVerifyOtpLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_VerifyOtpLocalizationsDelegate old) => false;
}

VerifyOtpLocalizations lookupVerifyOtpLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar': return VerifyOtpLocalizationsAr();
    case 'en': return VerifyOtpLocalizationsEn();
  }

  throw FlutterError(
    'VerifyOtpLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
