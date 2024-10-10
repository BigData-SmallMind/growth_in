import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'delete_meeting_localizations_ar.dart';
import 'delete_meeting_localizations_en.dart';

/// Callers can lookup localized strings with an instance of DeleteMeetingLocalizations
/// returned by `DeleteMeetingLocalizations.of(context)`.
///
/// Applications need to include `DeleteMeetingLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/delete_meeting_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: DeleteMeetingLocalizations.localizationsDelegates,
///   supportedLocales: DeleteMeetingLocalizations.supportedLocales,
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
/// be consistent with the languages listed in the DeleteMeetingLocalizations.supportedLocales
/// property.
abstract class DeleteMeetingLocalizations {
  DeleteMeetingLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static DeleteMeetingLocalizations of(BuildContext context) {
    return Localizations.of<DeleteMeetingLocalizations>(context, DeleteMeetingLocalizations)!;
  }

  static const LocalizationsDelegate<DeleteMeetingLocalizations> delegate = _DeleteMeetingLocalizationsDelegate();

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

  /// No description provided for @otherReasonTextFieldHint.
  ///
  /// In en, this message translates to:
  /// **'Type the reason here'**
  String get otherReasonTextFieldHint;

  /// No description provided for @requiredFieldErrorMessage.
  ///
  /// In en, this message translates to:
  /// **'Required'**
  String get requiredFieldErrorMessage;

  /// No description provided for @requiredTextMessage.
  ///
  /// In en, this message translates to:
  /// **'Required'**
  String get requiredTextMessage;

  /// No description provided for @confirmMeetingDeletionButtonLabel.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirmMeetingDeletionButtonLabel;

  /// No description provided for @meetingDeletedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Meeting deleted successfully'**
  String get meetingDeletedSuccessfully;
}

class _DeleteMeetingLocalizationsDelegate extends LocalizationsDelegate<DeleteMeetingLocalizations> {
  const _DeleteMeetingLocalizationsDelegate();

  @override
  Future<DeleteMeetingLocalizations> load(Locale locale) {
    return SynchronousFuture<DeleteMeetingLocalizations>(lookupDeleteMeetingLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_DeleteMeetingLocalizationsDelegate old) => false;
}

DeleteMeetingLocalizations lookupDeleteMeetingLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar': return DeleteMeetingLocalizationsAr();
    case 'en': return DeleteMeetingLocalizationsEn();
  }

  throw FlutterError(
    'DeleteMeetingLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
