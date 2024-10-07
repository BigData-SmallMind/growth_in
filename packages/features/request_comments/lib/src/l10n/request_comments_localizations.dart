import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'request_comments_localizations_ar.dart';
import 'request_comments_localizations_en.dart';

/// Callers can lookup localized strings with an instance of RequestCommentsLocalizations
/// returned by `RequestCommentsLocalizations.of(context)`.
///
/// Applications need to include `RequestCommentsLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/request_comments_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: RequestCommentsLocalizations.localizationsDelegates,
///   supportedLocales: RequestCommentsLocalizations.supportedLocales,
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
/// be consistent with the languages listed in the RequestCommentsLocalizations.supportedLocales
/// property.
abstract class RequestCommentsLocalizations {
  RequestCommentsLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static RequestCommentsLocalizations of(BuildContext context) {
    return Localizations.of<RequestCommentsLocalizations>(context, RequestCommentsLocalizations)!;
  }

  static const LocalizationsDelegate<RequestCommentsLocalizations> delegate = _RequestCommentsLocalizationsDelegate();

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

  /// No description provided for @detailsSectionTitle.
  ///
  /// In en, this message translates to:
  /// **'Details'**
  String get detailsSectionTitle;

  /// No description provided for @stepsSectionTitle.
  ///
  /// In en, this message translates to:
  /// **'Steps'**
  String get stepsSectionTitle;

  /// No description provided for @noCommentsIndicatorText.
  ///
  /// In en, this message translates to:
  /// **'No Comments'**
  String get noCommentsIndicatorText;
}

class _RequestCommentsLocalizationsDelegate extends LocalizationsDelegate<RequestCommentsLocalizations> {
  const _RequestCommentsLocalizationsDelegate();

  @override
  Future<RequestCommentsLocalizations> load(Locale locale) {
    return SynchronousFuture<RequestCommentsLocalizations>(lookupRequestCommentsLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_RequestCommentsLocalizationsDelegate old) => false;
}

RequestCommentsLocalizations lookupRequestCommentsLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar': return RequestCommentsLocalizationsAr();
    case 'en': return RequestCommentsLocalizationsEn();
  }

  throw FlutterError(
    'RequestCommentsLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
