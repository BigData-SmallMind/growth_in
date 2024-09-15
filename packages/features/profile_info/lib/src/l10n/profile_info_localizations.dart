import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'profile_info_localizations_ar.dart';
import 'profile_info_localizations_en.dart';

/// Callers can lookup localized strings with an instance of ProfileInfoLocalizations
/// returned by `ProfileInfoLocalizations.of(context)`.
///
/// Applications need to include `ProfileInfoLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/profile_info_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: ProfileInfoLocalizations.localizationsDelegates,
///   supportedLocales: ProfileInfoLocalizations.supportedLocales,
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
/// be consistent with the languages listed in the ProfileInfoLocalizations.supportedLocales
/// property.
abstract class ProfileInfoLocalizations {
  ProfileInfoLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static ProfileInfoLocalizations of(BuildContext context) {
    return Localizations.of<ProfileInfoLocalizations>(context, ProfileInfoLocalizations)!;
  }

  static const LocalizationsDelegate<ProfileInfoLocalizations> delegate = _ProfileInfoLocalizationsDelegate();

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

  /// No description provided for @profileInfoTitle.
  ///
  /// In en, this message translates to:
  /// **'My Account Information'**
  String get profileInfoTitle;

  /// No description provided for @infoTabLabel.
  ///
  /// In en, this message translates to:
  /// **'Info'**
  String get infoTabLabel;

  /// No description provided for @filesTabLabel.
  ///
  /// In en, this message translates to:
  /// **'Files'**
  String get filesTabLabel;

  /// No description provided for @companyRepresentativeSectionTitle.
  ///
  /// In en, this message translates to:
  /// **'Company Representative'**
  String get companyRepresentativeSectionTitle;

  /// No description provided for @fullNameFieldLabel.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get fullNameFieldLabel;

  /// No description provided for @phoneNumberFieldLabel.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get phoneNumberFieldLabel;

  /// No description provided for @countryFieldLabel.
  ///
  /// In en, this message translates to:
  /// **'Country Code'**
  String get countryFieldLabel;

  /// No description provided for @companyNameFieldLabel.
  ///
  /// In en, this message translates to:
  /// **'Company Name'**
  String get companyNameFieldLabel;

  /// No description provided for @socialMediaSectionTitle.
  ///
  /// In en, this message translates to:
  /// **'Social Media'**
  String get socialMediaSectionTitle;
}

class _ProfileInfoLocalizationsDelegate extends LocalizationsDelegate<ProfileInfoLocalizations> {
  const _ProfileInfoLocalizationsDelegate();

  @override
  Future<ProfileInfoLocalizations> load(Locale locale) {
    return SynchronousFuture<ProfileInfoLocalizations>(lookupProfileInfoLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_ProfileInfoLocalizationsDelegate old) => false;
}

ProfileInfoLocalizations lookupProfileInfoLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar': return ProfileInfoLocalizationsAr();
    case 'en': return ProfileInfoLocalizationsEn();
  }

  throw FlutterError(
    'ProfileInfoLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
