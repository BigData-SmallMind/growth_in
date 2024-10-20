import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'more_localizations_ar.dart';
import 'more_localizations_en.dart';

/// Callers can lookup localized strings with an instance of MoreLocalizations
/// returned by `MoreLocalizations.of(context)`.
///
/// Applications need to include `MoreLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/more_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: MoreLocalizations.localizationsDelegates,
///   supportedLocales: MoreLocalizations.supportedLocales,
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
/// be consistent with the languages listed in the MoreLocalizations.supportedLocales
/// property.
abstract class MoreLocalizations {
  MoreLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static MoreLocalizations of(BuildContext context) {
    return Localizations.of<MoreLocalizations>(context, MoreLocalizations)!;
  }

  static const LocalizationsDelegate<MoreLocalizations> delegate = _MoreLocalizationsDelegate();

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

  /// No description provided for @meetingsTileTitle.
  ///
  /// In en, this message translates to:
  /// **'Meetings'**
  String get meetingsTileTitle;

  /// No description provided for @requestsTileTitle.
  ///
  /// In en, this message translates to:
  /// **'Requests'**
  String get requestsTileTitle;

  /// No description provided for @formsTileTitle.
  ///
  /// In en, this message translates to:
  /// **'Forms'**
  String get formsTileTitle;

  /// No description provided for @plansAndServicesTileTitle.
  ///
  /// In en, this message translates to:
  /// **'Plans and Services'**
  String get plansAndServicesTileTitle;

  /// No description provided for @settingsTileTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTileTitle;

  /// No description provided for @helpTileTitle.
  ///
  /// In en, this message translates to:
  /// **'Help'**
  String get helpTileTitle;

  /// No description provided for @logoutTileTitle.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logoutTileTitle;
}

class _MoreLocalizationsDelegate extends LocalizationsDelegate<MoreLocalizations> {
  const _MoreLocalizationsDelegate();

  @override
  Future<MoreLocalizations> load(Locale locale) {
    return SynchronousFuture<MoreLocalizations>(lookupMoreLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_MoreLocalizationsDelegate old) => false;
}

MoreLocalizations lookupMoreLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar': return MoreLocalizationsAr();
    case 'en': return MoreLocalizationsEn();
  }

  throw FlutterError(
    'MoreLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
