import 'cms_localizations.dart';

/// The translations for Arabic (`ar`).
class CmsLocalizationsAr extends CmsLocalizations {
  CmsLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appBarTitle => 'الملفات';

  @override
  String get calendarTabLabel => 'التقويم';

  @override
  String get timelineTabLabel => 'الجدول الزمني';

  @override
  String get campaignsTabLabel => 'الحملات الإعلانية';

  @override
  String get noCmsMessageTitle => 'لا توجد رسائل!';

  @override
  String get noCmsMessageSubtitle => 'لا توجد رسائل';

  @override
  String get noCmsButtonLabel => 'حاول مرة أخرى';

  @override
  String get emptyListIndicatorText => 'القائمة فارغة';

  @override
  String get folderDetailsBottomSheetTitle => 'التفاصيل';

  @override
  String get mileStoneSectionTitle => 'الانجاز';
}
