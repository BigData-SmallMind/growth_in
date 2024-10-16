import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'create_meeting_localizations_ar.dart';
import 'create_meeting_localizations_en.dart';

/// Callers can lookup localized strings with an instance of CreateMeetingLocalizations
/// returned by `CreateMeetingLocalizations.of(context)`.
///
/// Applications need to include `CreateMeetingLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/create_meeting_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: CreateMeetingLocalizations.localizationsDelegates,
///   supportedLocales: CreateMeetingLocalizations.supportedLocales,
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
/// be consistent with the languages listed in the CreateMeetingLocalizations.supportedLocales
/// property.
abstract class CreateMeetingLocalizations {
  CreateMeetingLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static CreateMeetingLocalizations of(BuildContext context) {
    return Localizations.of<CreateMeetingLocalizations>(context, CreateMeetingLocalizations)!;
  }

  static const LocalizationsDelegate<CreateMeetingLocalizations> delegate = _CreateMeetingLocalizationsDelegate();

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

  /// No description provided for @descriptionTextFieldLabel.
  ///
  /// In en, this message translates to:
  /// **'Meeting Plan Details'**
  String get descriptionTextFieldLabel;

  /// No description provided for @descriptionTextFieldHint.
  ///
  /// In en, this message translates to:
  /// **'Meeting plan or key points'**
  String get descriptionTextFieldHint;

  /// No description provided for @titleTextFieldLabel.
  ///
  /// In en, this message translates to:
  /// **'Meeting Title'**
  String get titleTextFieldLabel;

  /// No description provided for @requiredFieldErrorMessage.
  ///
  /// In en, this message translates to:
  /// **'Required'**
  String get requiredFieldErrorMessage;

  /// No description provided for @titleTextFieldHint.
  ///
  /// In en, this message translates to:
  /// **'Enter the title here'**
  String get titleTextFieldHint;

  /// No description provided for @nextStepButtonLabel.
  ///
  /// In en, this message translates to:
  /// **'Next Step'**
  String get nextStepButtonLabel;

  /// No description provided for @lastStepButtonLabel.
  ///
  /// In en, this message translates to:
  /// **'Book'**
  String get lastStepButtonLabel;

  /// No description provided for @stepOneLabel.
  ///
  /// In en, this message translates to:
  /// **'Fill in the general details'**
  String get stepOneLabel;

  /// No description provided for @stepTwoLabel.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get stepTwoLabel;

  /// No description provided for @stepThreeLabel.
  ///
  /// In en, this message translates to:
  /// **'Meeting Details'**
  String get stepThreeLabel;
}

class _CreateMeetingLocalizationsDelegate extends LocalizationsDelegate<CreateMeetingLocalizations> {
  const _CreateMeetingLocalizationsDelegate();

  @override
  Future<CreateMeetingLocalizations> load(Locale locale) {
    return SynchronousFuture<CreateMeetingLocalizations>(lookupCreateMeetingLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_CreateMeetingLocalizationsDelegate old) => false;
}

CreateMeetingLocalizations lookupCreateMeetingLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar': return CreateMeetingLocalizationsAr();
    case 'en': return CreateMeetingLocalizationsEn();
  }

  throw FlutterError(
    'CreateMeetingLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
