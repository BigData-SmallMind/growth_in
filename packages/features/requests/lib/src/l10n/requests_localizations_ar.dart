import 'requests_localizations.dart';

/// The translations for Arabic (`ar`).
class RequestsLocalizationsAr extends RequestsLocalizations {
  RequestsLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appBarTitle => 'الطلبات';

  @override
  String get emptyRequestsListIndicator => 'لا توجد طلبات';
}
