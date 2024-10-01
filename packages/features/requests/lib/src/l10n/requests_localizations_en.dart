import 'requests_localizations.dart';

/// The translations for English (`en`).
class RequestsLocalizationsEn extends RequestsLocalizations {
  RequestsLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appBarTitle => 'Requests';

  @override
  String get emptyRequestsListIndicator => 'No requests';
}
