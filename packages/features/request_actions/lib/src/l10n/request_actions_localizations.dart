import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'request_actions_localizations_ar.dart';
import 'request_actions_localizations_en.dart';

/// Callers can lookup localized strings with an instance of RequestActionsLocalizations
/// returned by `RequestActionsLocalizations.of(context)`.
///
/// Applications need to include `RequestActionsLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/request_actions_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: RequestActionsLocalizations.localizationsDelegates,
///   supportedLocales: RequestActionsLocalizations.supportedLocales,
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
/// be consistent with the languages listed in the RequestActionsLocalizations.supportedLocales
/// property.
abstract class RequestActionsLocalizations {
  RequestActionsLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static RequestActionsLocalizations of(BuildContext context) {
    return Localizations.of<RequestActionsLocalizations>(context, RequestActionsLocalizations)!;
  }

  static const LocalizationsDelegate<RequestActionsLocalizations> delegate = _RequestActionsLocalizationsDelegate();

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
  /// **'Requests'**
  String get appBarTitle;

  /// No description provided for @deadlineSectionTitle.
  ///
  /// In en, this message translates to:
  /// **'Deadline'**
  String get deadlineSectionTitle;

  /// No description provided for @serviceNameSectionTitle.
  ///
  /// In en, this message translates to:
  /// **'Service Name'**
  String get serviceNameSectionTitle;

  /// No description provided for @descriptionSectionTitle.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get descriptionSectionTitle;

  /// No description provided for @actionsSectionTitle.
  ///
  /// In en, this message translates to:
  /// **'Actions'**
  String get actionsSectionTitle;

  /// No description provided for @viewAllActionsButtonLabel.
  ///
  /// In en, this message translates to:
  /// **'View All'**
  String get viewAllActionsButtonLabel;

  /// No description provided for @actionTitle.
  ///
  /// In en, this message translates to:
  /// **'Action #'**
  String get actionTitle;

  /// No description provided for @percentActionsComplete.
  ///
  /// In en, this message translates to:
  /// **'Steps Completed'**
  String get percentActionsComplete;

  /// No description provided for @commentsSectionTitle.
  ///
  /// In en, this message translates to:
  /// **'Comments'**
  String get commentsSectionTitle;

  /// No description provided for @viewAllCommentsButtonLabel.
  ///
  /// In en, this message translates to:
  /// **'View All'**
  String get viewAllCommentsButtonLabel;
}

class _RequestActionsLocalizationsDelegate extends LocalizationsDelegate<RequestActionsLocalizations> {
  const _RequestActionsLocalizationsDelegate();

  @override
  Future<RequestActionsLocalizations> load(Locale locale) {
    return SynchronousFuture<RequestActionsLocalizations>(lookupRequestActionsLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_RequestActionsLocalizationsDelegate old) => false;
}

RequestActionsLocalizations lookupRequestActionsLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar': return RequestActionsLocalizationsAr();
    case 'en': return RequestActionsLocalizationsEn();
  }

  throw FlutterError(
    'RequestActionsLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
