import 'request_comments_localizations.dart';

/// The translations for English (`en`).
class RequestCommentsLocalizationsEn extends RequestCommentsLocalizations {
  RequestCommentsLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appBarTitle => 'Requests';

  @override
  String get detailsSectionTitle => 'Details';

  @override
  String get stepsSectionTitle => 'Steps';

  @override
  String get noCommentsIndicatorText => 'No Comments';
}
