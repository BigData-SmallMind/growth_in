import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'cms_localizations_ar.dart';
import 'cms_localizations_en.dart';

/// Callers can lookup localized strings with an instance of CmsLocalizations
/// returned by `CmsLocalizations.of(context)`.
///
/// Applications need to include `CmsLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/cms_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: CmsLocalizations.localizationsDelegates,
///   supportedLocales: CmsLocalizations.supportedLocales,
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
/// be consistent with the languages listed in the CmsLocalizations.supportedLocales
/// property.
abstract class CmsLocalizations {
  CmsLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static CmsLocalizations of(BuildContext context) {
    return Localizations.of<CmsLocalizations>(context, CmsLocalizations)!;
  }

  static const LocalizationsDelegate<CmsLocalizations> delegate = _CmsLocalizationsDelegate();

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
  /// **'Files'**
  String get appBarTitle;

  /// No description provided for @calendarTabLabel.
  ///
  /// In en, this message translates to:
  /// **'Calendar'**
  String get calendarTabLabel;

  /// No description provided for @timelineTabLabel.
  ///
  /// In en, this message translates to:
  /// **'Timeline'**
  String get timelineTabLabel;

  /// No description provided for @campaignsTabLabel.
  ///
  /// In en, this message translates to:
  /// **'Campaigns'**
  String get campaignsTabLabel;

  /// No description provided for @noCmsMessageTitle.
  ///
  /// In en, this message translates to:
  /// **'No Cms!'**
  String get noCmsMessageTitle;

  /// No description provided for @noCmsMessageSubtitle.
  ///
  /// In en, this message translates to:
  /// **'No Cms'**
  String get noCmsMessageSubtitle;

  /// No description provided for @noCmsButtonLabel.
  ///
  /// In en, this message translates to:
  /// **'Try Again'**
  String get noCmsButtonLabel;

  /// No description provided for @emptyListIndicatorText.
  ///
  /// In en, this message translates to:
  /// **'List is empty'**
  String get emptyListIndicatorText;

  /// No description provided for @folderDetailsBottomSheetTitle.
  ///
  /// In en, this message translates to:
  /// **'Details'**
  String get folderDetailsBottomSheetTitle;

  /// No description provided for @mileStoneSectionTitle.
  ///
  /// In en, this message translates to:
  /// **'Milestone'**
  String get mileStoneSectionTitle;

  /// No description provided for @weekNumber.
  ///
  /// In en, this message translates to:
  /// **'Week'**
  String get weekNumber;

  /// No description provided for @weekDropdownItemLabel.
  ///
  /// In en, this message translates to:
  /// **'Week'**
  String get weekDropdownItemLabel;

  /// No description provided for @monthDropdownItemLabel.
  ///
  /// In en, this message translates to:
  /// **'Month'**
  String get monthDropdownItemLabel;
}

class _CmsLocalizationsDelegate extends LocalizationsDelegate<CmsLocalizations> {
  const _CmsLocalizationsDelegate();

  @override
  Future<CmsLocalizations> load(Locale locale) {
    return SynchronousFuture<CmsLocalizations>(lookupCmsLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_CmsLocalizationsDelegate old) => false;
}

CmsLocalizations lookupCmsLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar': return CmsLocalizationsAr();
    case 'en': return CmsLocalizationsEn();
  }

  throw FlutterError(
    'CmsLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
