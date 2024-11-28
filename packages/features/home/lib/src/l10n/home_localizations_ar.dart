import 'home_localizations.dart';

/// The translations for Arabic (`ar`).
class HomeLocalizationsAr extends HomeLocalizations {
  HomeLocalizationsAr([super.locale = 'ar']);

  @override
  String get appBarGreetingMessage => 'صباح الخير';

  @override
  String get recentPostsSectionTitle => 'المحتوي';

  @override
  String get viewAllButtonLabel => 'عرض الكل';

  @override
  String get upcomingMeetingSectionTitle => 'اجتماعك القادم';

  @override
  String get unpublishedPostsContainerTitle => 'محتوي غير منشور';

  @override
  String get continuePublishingButtonLabel => 'اكمل النشر';

  @override
  String get unapprovedFilesContainerTitle => 'ملفات قيد الموافقة';

  @override
  String get dashboardContainerTitle => 'لوحة القيادة';

  @override
  String get postsSectionTitle => 'المحتوي';

  @override
  String get requestsSectionTitle => 'الطلبات المتأخرة';

  @override
  String get noUpcomingMeetingSectionTitle => 'لا توجد اجتماعات قادمة';
}
