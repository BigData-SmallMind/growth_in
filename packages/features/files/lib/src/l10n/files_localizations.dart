import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'files_localizations_ar.dart';
import 'files_localizations_en.dart';

/// Callers can lookup localized strings with an instance of FilesLocalizations
/// returned by `FilesLocalizations.of(context)`.
///
/// Applications need to include `FilesLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/files_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: FilesLocalizations.localizationsDelegates,
///   supportedLocales: FilesLocalizations.supportedLocales,
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
/// be consistent with the languages listed in the FilesLocalizations.supportedLocales
/// property.
abstract class FilesLocalizations {
  FilesLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static FilesLocalizations of(BuildContext context) {
    return Localizations.of<FilesLocalizations>(context, FilesLocalizations)!;
  }

  static const LocalizationsDelegate<FilesLocalizations> delegate = _FilesLocalizationsDelegate();

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

  /// No description provided for @activeFilesTabLabel.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get activeFilesTabLabel;

  /// No description provided for @inActiveFilesTabLabel.
  ///
  /// In en, this message translates to:
  /// **'InActive'**
  String get inActiveFilesTabLabel;

  /// No description provided for @noFilesMessageTitle.
  ///
  /// In en, this message translates to:
  /// **'No Files!'**
  String get noFilesMessageTitle;

  /// No description provided for @noFilesMessageSubtitle.
  ///
  /// In en, this message translates to:
  /// **'No Files'**
  String get noFilesMessageSubtitle;

  /// No description provided for @noFilesButtonLabel.
  ///
  /// In en, this message translates to:
  /// **'Try Again'**
  String get noFilesButtonLabel;

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
}

class _FilesLocalizationsDelegate extends LocalizationsDelegate<FilesLocalizations> {
  const _FilesLocalizationsDelegate();

  @override
  Future<FilesLocalizations> load(Locale locale) {
    return SynchronousFuture<FilesLocalizations>(lookupFilesLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_FilesLocalizationsDelegate old) => false;
}

FilesLocalizations lookupFilesLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar': return FilesLocalizationsAr();
    case 'en': return FilesLocalizationsEn();
  }

  throw FlutterError(
    'FilesLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
