import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'post_version_details_localizations_ar.dart';
import 'post_version_details_localizations_en.dart';

/// Callers can lookup localized strings with an instance of PostVersionDetailsLocalizations
/// returned by `PostVersionDetailsLocalizations.of(context)`.
///
/// Applications need to include `PostVersionDetailsLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/post_version_details_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: PostVersionDetailsLocalizations.localizationsDelegates,
///   supportedLocales: PostVersionDetailsLocalizations.supportedLocales,
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
/// be consistent with the languages listed in the PostVersionDetailsLocalizations.supportedLocales
/// property.
abstract class PostVersionDetailsLocalizations {
  PostVersionDetailsLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static PostVersionDetailsLocalizations of(BuildContext context) {
    return Localizations.of<PostVersionDetailsLocalizations>(context, PostVersionDetailsLocalizations)!;
  }

  static const LocalizationsDelegate<PostVersionDetailsLocalizations> delegate = _PostVersionDetailsLocalizationsDelegate();

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

  /// No description provided for @approvePostButtonLabel.
  ///
  /// In en, this message translates to:
  /// **'Approve'**
  String get approvePostButtonLabel;

  /// No description provided for @approvePostBottomSheetTitle.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to approve this version?'**
  String get approvePostBottomSheetTitle;

  /// No description provided for @approvePostBottomSheetBody.
  ///
  /// In en, this message translates to:
  /// **'This version will be finalized and edits will be closed.'**
  String get approvePostBottomSheetBody;

  /// No description provided for @approvePostBottomSheetButtonLabel.
  ///
  /// In en, this message translates to:
  /// **'Approve'**
  String get approvePostBottomSheetButtonLabel;

  /// No description provided for @cancelPostBottomSheetButtonLabel.
  ///
  /// In en, this message translates to:
  /// **'There are still edits'**
  String get cancelPostBottomSheetButtonLabel;

  /// No description provided for @postApprovalSuccessSnackBarMessage.
  ///
  /// In en, this message translates to:
  /// **'Post approved successfully'**
  String get postApprovalSuccessSnackBarMessage;
}

class _PostVersionDetailsLocalizationsDelegate extends LocalizationsDelegate<PostVersionDetailsLocalizations> {
  const _PostVersionDetailsLocalizationsDelegate();

  @override
  Future<PostVersionDetailsLocalizations> load(Locale locale) {
    return SynchronousFuture<PostVersionDetailsLocalizations>(lookupPostVersionDetailsLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_PostVersionDetailsLocalizationsDelegate old) => false;
}

PostVersionDetailsLocalizations lookupPostVersionDetailsLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar': return PostVersionDetailsLocalizationsAr();
    case 'en': return PostVersionDetailsLocalizationsEn();
  }

  throw FlutterError(
    'PostVersionDetailsLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
