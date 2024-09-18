import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'ticket_messages_localizations_ar.dart';
import 'ticket_messages_localizations_en.dart';

/// Callers can lookup localized strings with an instance of TicketMessagesLocalizations
/// returned by `TicketMessagesLocalizations.of(context)`.
///
/// Applications need to include `TicketMessagesLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/ticket_messages_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: TicketMessagesLocalizations.localizationsDelegates,
///   supportedLocales: TicketMessagesLocalizations.supportedLocales,
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
/// be consistent with the languages listed in the TicketMessagesLocalizations.supportedLocales
/// property.
abstract class TicketMessagesLocalizations {
  TicketMessagesLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static TicketMessagesLocalizations of(BuildContext context) {
    return Localizations.of<TicketMessagesLocalizations>(context, TicketMessagesLocalizations)!;
  }

  static const LocalizationsDelegate<TicketMessagesLocalizations> delegate = _TicketMessagesLocalizationsDelegate();

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

  /// No description provided for @appBarTitle.
  ///
  /// In en, this message translates to:
  /// **'Help & Support'**
  String get appBarTitle;

  /// No description provided for @activeTicketMessagesTabLabel.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get activeTicketMessagesTabLabel;

  /// No description provided for @inActiveTicketMessagesTabLabel.
  ///
  /// In en, this message translates to:
  /// **'InActive'**
  String get inActiveTicketMessagesTabLabel;

  /// No description provided for @noTicketMessagesMessageTitle.
  ///
  /// In en, this message translates to:
  /// **'No messages!'**
  String get noTicketMessagesMessageTitle;

  /// No description provided for @noTicketMessagesMessageSubtitle.
  ///
  /// In en, this message translates to:
  /// **'We are always here to help! Start a new conversation and let us know how we can assist you'**
  String get noTicketMessagesMessageSubtitle;

  /// No description provided for @noTicketMessagesButtonLabel.
  ///
  /// In en, this message translates to:
  /// **'Contact Us Now'**
  String get noTicketMessagesButtonLabel;

  /// No description provided for @uploadFileIconLabel.
  ///
  /// In en, this message translates to:
  /// **'File'**
  String get uploadFileIconLabel;

  /// No description provided for @uploadImageFromGalleryIconLabel.
  ///
  /// In en, this message translates to:
  /// **'Gallery'**
  String get uploadImageFromGalleryIconLabel;

  /// No description provided for @captureImageIconLabel.
  ///
  /// In en, this message translates to:
  /// **'Capture'**
  String get captureImageIconLabel;

  /// No description provided for @deleteFileIconLabel.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get deleteFileIconLabel;
}

class _TicketMessagesLocalizationsDelegate extends LocalizationsDelegate<TicketMessagesLocalizations> {
  const _TicketMessagesLocalizationsDelegate();

  @override
  Future<TicketMessagesLocalizations> load(Locale locale) {
    return SynchronousFuture<TicketMessagesLocalizations>(lookupTicketMessagesLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_TicketMessagesLocalizationsDelegate old) => false;
}

TicketMessagesLocalizations lookupTicketMessagesLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar': return TicketMessagesLocalizationsAr();
    case 'en': return TicketMessagesLocalizationsEn();
  }

  throw FlutterError(
    'TicketMessagesLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
