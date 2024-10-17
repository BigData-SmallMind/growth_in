import 'requests_localizations.dart';

/// The translations for Arabic (`ar`).
class RequestsLocalizationsAr extends RequestsLocalizations {
  RequestsLocalizationsAr([super.locale = 'ar']);

  @override
  String get appBarTitle => 'الطلبات';

  @override
  String get noItemsFoundMessage => 'No requests';

  @override
  String get aboutToExpireStatusText => 'قرب التجاوز';

  @override
  String get expiredStatusText => 'لم يتم البدء';

  @override
  String get notStartedStatusText => 'تجاوز الموعد';

  @override
  String get inProgressStatusText => 'قيد العمل';

  @override
  String get statusFilterSectionTitle => 'الحالة';

  @override
  String get projectsFilterSectionTitle => 'المشاريع';
}
