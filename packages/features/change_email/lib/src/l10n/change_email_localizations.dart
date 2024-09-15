import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'change_email_localizations_ar.dart';
import 'change_email_localizations_en.dart';

/// Callers can lookup localized strings with an instance of ChangeEmailLocalizations
/// returned by `ChangeEmailLocalizations.of(context)`.
///
/// Applications need to include `ChangeEmailLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/change_email_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: ChangeEmailLocalizations.localizationsDelegates,
///   supportedLocales: ChangeEmailLocalizations.supportedLocales,
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
/// be consistent with the languages listed in the ChangeEmailLocalizations.supportedLocales
/// property.
abstract class ChangeEmailLocalizations {
  ChangeEmailLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static ChangeEmailLocalizations of(BuildContext context) {
    return Localizations.of<ChangeEmailLocalizations>(context, ChangeEmailLocalizations)!;
  }

  static const LocalizationsDelegate<ChangeEmailLocalizations> delegate = _ChangeEmailLocalizationsDelegate();

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

  /// No description provided for @changeEmailSuccessMessage.
  ///
  /// In en, this message translates to:
  /// **'Your email has been reset successfully'**
  String get changeEmailSuccessMessage;

  /// No description provided for @changeEmailScreenTitle.
  ///
  /// In en, this message translates to:
  /// **'Change Email'**
  String get changeEmailScreenTitle;

  /// No description provided for @changeEmailScreenSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Change Email'**
  String get changeEmailScreenSubtitle;

  /// No description provided for @submissionInProgressButtonLabel.
  ///
  /// In en, this message translates to:
  /// **'Submitting'**
  String get submissionInProgressButtonLabel;

  /// No description provided for @submitButtonLabel.
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get submitButtonLabel;

  /// No description provided for @newEmailTextFieldLabel.
  ///
  /// In en, this message translates to:
  /// **'New Email'**
  String get newEmailTextFieldLabel;

  /// No description provided for @requiredFieldErrorMessage.
  ///
  /// In en, this message translates to:
  /// **'This field is required'**
  String get requiredFieldErrorMessage;

  /// No description provided for @emailTextFieldHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your new email'**
  String get emailTextFieldHint;

  /// No description provided for @newEmailConfirmationTextFieldLabel.
  ///
  /// In en, this message translates to:
  /// **'Confirm New Email'**
  String get newEmailConfirmationTextFieldLabel;

  /// No description provided for @newEmailConfirmationTextFieldHint.
  ///
  /// In en, this message translates to:
  /// **'Re-enter your new email'**
  String get newEmailConfirmationTextFieldHint;

  /// No description provided for @emailConfirmationTextFieldDoesNotMatchError.
  ///
  /// In en, this message translates to:
  /// **'Emails do not match'**
  String get emailConfirmationTextFieldDoesNotMatchError;

  /// No description provided for @generalErrorSnackBarMessage.
  ///
  /// In en, this message translates to:
  /// **'An error occurred. Please try again later'**
  String get generalErrorSnackBarMessage;

  /// No description provided for @invalidEmailFormatErrorMessage.
  ///
  /// In en, this message translates to:
  /// **'The email you entered is incorrect'**
  String get invalidEmailFormatErrorMessage;

  /// No description provided for @emailTextFieldAlreadyRegisteredError.
  ///
  /// In en, this message translates to:
  /// **'This email is already registered'**
  String get emailTextFieldAlreadyRegisteredError;
}

class _ChangeEmailLocalizationsDelegate extends LocalizationsDelegate<ChangeEmailLocalizations> {
  const _ChangeEmailLocalizationsDelegate();

  @override
  Future<ChangeEmailLocalizations> load(Locale locale) {
    return SynchronousFuture<ChangeEmailLocalizations>(lookupChangeEmailLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_ChangeEmailLocalizationsDelegate old) => false;
}

ChangeEmailLocalizations lookupChangeEmailLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar': return ChangeEmailLocalizationsAr();
    case 'en': return ChangeEmailLocalizationsEn();
  }

  throw FlutterError(
    'ChangeEmailLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
