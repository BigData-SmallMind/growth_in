import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'meetings_localizations_ar.dart';
import 'meetings_localizations_en.dart';

/// Callers can lookup localized strings with an instance of MeetingsLocalizations
/// returned by `MeetingsLocalizations.of(context)`.
///
/// Applications need to include `MeetingsLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/meetings_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: MeetingsLocalizations.localizationsDelegates,
///   supportedLocales: MeetingsLocalizations.supportedLocales,
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
/// be consistent with the languages listed in the MeetingsLocalizations.supportedLocales
/// property.
abstract class MeetingsLocalizations {
  MeetingsLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static MeetingsLocalizations of(BuildContext context) {
    return Localizations.of<MeetingsLocalizations>(context, MeetingsLocalizations)!;
  }

  static const LocalizationsDelegate<MeetingsLocalizations> delegate = _MeetingsLocalizationsDelegate();

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

  /// No description provided for @meetingRequestsSectionTitle.
  ///
  /// In en, this message translates to:
  /// **'Meeting Requests'**
  String get meetingRequestsSectionTitle;

  /// No description provided for @upcomingMeetingsSectionTitle.
  ///
  /// In en, this message translates to:
  /// **'Upcoming Meetings'**
  String get upcomingMeetingsSectionTitle;

  /// No description provided for @viewAllTextButtonLabel.
  ///
  /// In en, this message translates to:
  /// **'View All'**
  String get viewAllTextButtonLabel;

  /// No description provided for @noMeetingsPendingActionMessage.
  ///
  /// In en, this message translates to:
  /// **'There are no meetings pending action'**
  String get noMeetingsPendingActionMessage;

  /// No description provided for @cancelMeetingButtonLabel.
  ///
  /// In en, this message translates to:
  /// **'Cancel Meeting'**
  String get cancelMeetingButtonLabel;

  /// No description provided for @noUpcomingMeetingMessage.
  ///
  /// In en, this message translates to:
  /// **'No upcoming meetings'**
  String get noUpcomingMeetingMessage;

  /// No description provided for @noPastMeetingsMessage.
  ///
  /// In en, this message translates to:
  /// **'No past meetings'**
  String get noPastMeetingsMessage;

  /// No description provided for @pastMeetingsSectionTitle.
  ///
  /// In en, this message translates to:
  /// **'Past Meetings'**
  String get pastMeetingsSectionTitle;
}

class _MeetingsLocalizationsDelegate extends LocalizationsDelegate<MeetingsLocalizations> {
  const _MeetingsLocalizationsDelegate();

  @override
  Future<MeetingsLocalizations> load(Locale locale) {
    return SynchronousFuture<MeetingsLocalizations>(lookupMeetingsLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_MeetingsLocalizationsDelegate old) => false;
}

MeetingsLocalizations lookupMeetingsLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar': return MeetingsLocalizationsAr();
    case 'en': return MeetingsLocalizationsEn();
  }

  throw FlutterError(
    'MeetingsLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
