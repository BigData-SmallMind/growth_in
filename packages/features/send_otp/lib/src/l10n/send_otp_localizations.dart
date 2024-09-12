import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'send_otp_localizations_ar.dart';
import 'send_otp_localizations_en.dart';

/// Callers can lookup localized strings with an instance of SendOtpLocalizations
/// returned by `SendOtpLocalizations.of(context)`.
///
/// Applications need to include `SendOtpLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/send_otp_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: SendOtpLocalizations.localizationsDelegates,
///   supportedLocales: SendOtpLocalizations.supportedLocales,
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
/// be consistent with the languages listed in the SendOtpLocalizations.supportedLocales
/// property.
abstract class SendOtpLocalizations {
  SendOtpLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static SendOtpLocalizations of(BuildContext context) {
    return Localizations.of<SendOtpLocalizations>(context, SendOtpLocalizations)!;
  }

  static const LocalizationsDelegate<SendOtpLocalizations> delegate = _SendOtpLocalizationsDelegate();

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

  /// No description provided for @sendOtpTitle.
  ///
  /// In en, this message translates to:
  /// **'ٍSomething went wrong'**
  String get sendOtpTitle;

  /// No description provided for @sendOtpSubtitle.
  ///
  /// In en, this message translates to:
  /// **'ٍSomething went wrong'**
  String get sendOtpSubtitle;

  /// No description provided for @otpSentSuccessfullySnackBarMessage.
  ///
  /// In en, this message translates to:
  /// **'ٍSomething went wrong'**
  String get otpSentSuccessfullySnackBarMessage;

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

  /// No description provided for @emailNotRegisteredErrorMessage.
  ///
  /// In en, this message translates to:
  /// **'Email not registered'**
  String get emailNotRegisteredErrorMessage;

  /// No description provided for @sendOtpProgressButtonLabel.
  ///
  /// In en, this message translates to:
  /// **'Sending OTP'**
  String get sendOtpProgressButtonLabel;

  /// No description provided for @sendOtpButtonLabel.
  ///
  /// In en, this message translates to:
  /// **'Send OTP'**
  String get sendOtpButtonLabel;
}

class _SendOtpLocalizationsDelegate extends LocalizationsDelegate<SendOtpLocalizations> {
  const _SendOtpLocalizationsDelegate();

  @override
  Future<SendOtpLocalizations> load(Locale locale) {
    return SynchronousFuture<SendOtpLocalizations>(lookupSendOtpLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_SendOtpLocalizationsDelegate old) => false;
}

SendOtpLocalizations lookupSendOtpLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar': return SendOtpLocalizationsAr();
    case 'en': return SendOtpLocalizationsEn();
  }

  throw FlutterError(
    'SendOtpLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
