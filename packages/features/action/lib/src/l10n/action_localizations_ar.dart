import 'action_localizations.dart';

/// The translations for Arabic (`ar`).
class ActionLocalizationsAr extends ActionLocalizations {
  ActionLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appBarTitle => 'الطلبات';

  @override
  String get detailsSectionTitle => 'التفاصيل';

  @override
  String get stepsSectionTitle => 'مطلوب';

  @override
  String get noCommentsIndicatorText => 'لا توجد تعليقات';
}
