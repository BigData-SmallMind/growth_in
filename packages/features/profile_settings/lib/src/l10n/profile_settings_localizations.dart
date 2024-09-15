import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'profile_settings_localizations_ar.dart';
import 'profile_settings_localizations_en.dart';

/// Callers can lookup localized strings with an instance of ProfileSettingsLocalizations
/// returned by `ProfileSettingsLocalizations.of(context)`.
///
/// Applications need to include `ProfileSettingsLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/profile_settings_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: ProfileSettingsLocalizations.localizationsDelegates,
///   supportedLocales: ProfileSettingsLocalizations.supportedLocales,
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
/// be consistent with the languages listed in the ProfileSettingsLocalizations.supportedLocales
/// property.
abstract class ProfileSettingsLocalizations {
  ProfileSettingsLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static ProfileSettingsLocalizations of(BuildContext context) {
    return Localizations.of<ProfileSettingsLocalizations>(context, ProfileSettingsLocalizations)!;
  }

  static const LocalizationsDelegate<ProfileSettingsLocalizations> delegate = _ProfileSettingsLocalizationsDelegate();

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
  /// **'Account Settings'**
  String get appBarTitle;

  /// No description provided for @infoTileTitle.
  ///
  /// In en, this message translates to:
  /// **'Account Information'**
  String get infoTileTitle;

  /// No description provided for @changePasswordTileTitle.
  ///
  /// In en, this message translates to:
  /// **'Change Password'**
  String get changePasswordTileTitle;

  /// No description provided for @changeEmailTileTitle.
  ///
  /// In en, this message translates to:
  /// **'Change Email'**
  String get changeEmailTileTitle;

  /// No description provided for @notificationsTileTitle.
  ///
  /// In en, this message translates to:
  /// **'Notifications and Alerts'**
  String get notificationsTileTitle;

  /// No description provided for @deleteProfileTileTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete Account'**
  String get deleteProfileTileTitle;
}

class _ProfileSettingsLocalizationsDelegate extends LocalizationsDelegate<ProfileSettingsLocalizations> {
  const _ProfileSettingsLocalizationsDelegate();

  @override
  Future<ProfileSettingsLocalizations> load(Locale locale) {
    return SynchronousFuture<ProfileSettingsLocalizations>(lookupProfileSettingsLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_ProfileSettingsLocalizationsDelegate old) => false;
}

ProfileSettingsLocalizations lookupProfileSettingsLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar': return ProfileSettingsLocalizationsAr();
    case 'en': return ProfileSettingsLocalizationsEn();
  }

  throw FlutterError(
    'ProfileSettingsLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
