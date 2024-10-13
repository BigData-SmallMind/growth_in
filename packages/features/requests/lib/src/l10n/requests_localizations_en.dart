import 'requests_localizations.dart';

/// The translations for English (`en`).
class RequestsLocalizationsEn extends RequestsLocalizations {
  RequestsLocalizationsEn([super.locale = 'en']);

  @override
  String get appBarTitle => 'Requests';

  @override
  String get noItemsFoundMessage => 'No requests';

  @override
  String get aboutToExpireStatusText => 'About to Expire';

  @override
  String get expiredStatusText => 'Expired';

  @override
  String get notStartedStatusText => 'Not Started';

  @override
  String get inProgressStatusText => 'In Progress';

  @override
  String get statusFilterSectionTitle => 'Status';

  @override
  String get projectsFilterSectionTitle => 'Projects';
}
