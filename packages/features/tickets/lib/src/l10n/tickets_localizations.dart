import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'tickets_localizations_ar.dart';
import 'tickets_localizations_en.dart';

/// Callers can lookup localized strings with an instance of TicketsLocalizations
/// returned by `TicketsLocalizations.of(context)`.
///
/// Applications need to include `TicketsLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/tickets_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: TicketsLocalizations.localizationsDelegates,
///   supportedLocales: TicketsLocalizations.supportedLocales,
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
/// be consistent with the languages listed in the TicketsLocalizations.supportedLocales
/// property.
abstract class TicketsLocalizations {
  TicketsLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static TicketsLocalizations of(BuildContext context) {
    return Localizations.of<TicketsLocalizations>(context, TicketsLocalizations)!;
  }

  static const LocalizationsDelegate<TicketsLocalizations> delegate = _TicketsLocalizationsDelegate();

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

  /// No description provided for @activeTicketsTabLabel.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get activeTicketsTabLabel;

  /// No description provided for @inActiveTicketsTabLabel.
  ///
  /// In en, this message translates to:
  /// **'InActive'**
  String get inActiveTicketsTabLabel;

  /// No description provided for @noTicketsMessageTitle.
  ///
  /// In en, this message translates to:
  /// **'No messages!'**
  String get noTicketsMessageTitle;

  /// No description provided for @noTicketsMessageSubtitle.
  ///
  /// In en, this message translates to:
  /// **'We are always here to help! Start a new conversation and let us know how we can assist you'**
  String get noTicketsMessageSubtitle;

  /// No description provided for @noTicketsButtonLabel.
  ///
  /// In en, this message translates to:
  /// **'Contact Us Now'**
  String get noTicketsButtonLabel;

  /// No description provided for @emptyListIndicatorText.
  ///
  /// In en, this message translates to:
  /// **'List is empty'**
  String get emptyListIndicatorText;
}

class _TicketsLocalizationsDelegate extends LocalizationsDelegate<TicketsLocalizations> {
  const _TicketsLocalizationsDelegate();

  @override
  Future<TicketsLocalizations> load(Locale locale) {
    return SynchronousFuture<TicketsLocalizations>(lookupTicketsLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_TicketsLocalizationsDelegate old) => false;
}

TicketsLocalizations lookupTicketsLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar': return TicketsLocalizationsAr();
    case 'en': return TicketsLocalizationsEn();
  }

  throw FlutterError(
    'TicketsLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
