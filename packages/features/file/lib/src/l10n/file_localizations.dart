import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'file_localizations_ar.dart';
import 'file_localizations_en.dart';

/// Callers can lookup localized strings with an instance of FileLocalizations
/// returned by `FileLocalizations.of(context)`.
///
/// Applications need to include `FileLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/file_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: FileLocalizations.localizationsDelegates,
///   supportedLocales: FileLocalizations.supportedLocales,
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
/// be consistent with the languages listed in the FileLocalizations.supportedLocales
/// property.
abstract class FileLocalizations {
  FileLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static FileLocalizations of(BuildContext context) {
    return Localizations.of<FileLocalizations>(context, FileLocalizations)!;
  }

  static const LocalizationsDelegate<FileLocalizations> delegate = _FileLocalizationsDelegate();

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

  /// No description provided for @assetsSectionTitle.
  ///
  /// In en, this message translates to:
  /// **'Assets'**
  String get assetsSectionTitle;

  /// No description provided for @downloadAllTextButtonLabel.
  ///
  /// In en, this message translates to:
  /// **'Download all'**
  String get downloadAllTextButtonLabel;

  /// No description provided for @verifyFileButtonLabel.
  ///
  /// In en, this message translates to:
  /// **'Approve'**
  String get verifyFileButtonLabel;

  /// No description provided for @verifyFileMessageTitle.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to approve the file?'**
  String get verifyFileMessageTitle;

  /// No description provided for @verifyFileMessageBody.
  ///
  /// In en, this message translates to:
  /// **'Modifications will be halted.'**
  String get verifyFileMessageBody;

  /// No description provided for @rejectFileButtonLabel.
  ///
  /// In en, this message translates to:
  /// **'Reject'**
  String get rejectFileButtonLabel;

  /// No description provided for @rejectFileMessageTitle.
  ///
  /// In en, this message translates to:
  /// **'Rejection Notice'**
  String get rejectFileMessageTitle;

  /// No description provided for @rejectFileMessageBody.
  ///
  /// In en, this message translates to:
  /// **'Your comments will be reviewed and modifications will begin.'**
  String get rejectFileMessageBody;

  /// No description provided for @cancelButtonLabel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancelButtonLabel;

  /// No description provided for @fileApprovalSuccessSnackBarMessage.
  ///
  /// In en, this message translates to:
  /// **'Approval was successful.'**
  String get fileApprovalSuccessSnackBarMessage;

  /// No description provided for @fileRejectionSuccessSnackBarMessage.
  ///
  /// In en, this message translates to:
  /// **'The file has been rejected. The team will be notified.'**
  String get fileRejectionSuccessSnackBarMessage;
}

class _FileLocalizationsDelegate extends LocalizationsDelegate<FileLocalizations> {
  const _FileLocalizationsDelegate();

  @override
  Future<FileLocalizations> load(Locale locale) {
    return SynchronousFuture<FileLocalizations>(lookupFileLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_FileLocalizationsDelegate old) => false;
}

FileLocalizations lookupFileLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar': return FileLocalizationsAr();
    case 'en': return FileLocalizationsEn();
  }

  throw FlutterError(
    'FileLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
