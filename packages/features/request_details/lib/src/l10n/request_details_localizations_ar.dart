import 'request_details_localizations.dart';

/// The translations for Arabic (`ar`).
class RequestDetailsLocalizationsAr extends RequestDetailsLocalizations {
  RequestDetailsLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appBarTitle => 'الطلبات';

  @override
  String get deadlineSectionTitle => 'موعد التسليم';

  @override
  String get serviceNameSectionTitle => 'الخدمة ';

  @override
  String get descriptionSectionTitle => 'التفاصيل';

  @override
  String get actionsSectionTitle => 'القوائم مرجعية';

  @override
  String get viewAllActionsButtonLabel => 'اظهر الكل';

  @override
  String get actionTitle => 'عنوان الإجراء';

  @override
  String get percentActionsComplete => 'المنتهي';

  @override
  String get commentsSectionTitle => 'التعليقات';

  @override
  String get viewAllCommentsButtonLabel => 'اظهر الكل';
}
