import 'meetings_localizations.dart';

/// The translations for Arabic (`ar`).
class MeetingsLocalizationsAr extends MeetingsLocalizations {
  MeetingsLocalizationsAr([super.locale = 'ar']);

  @override
  String get meetingRequestsSectionTitle => 'طلبات الاجتماع';

  @override
  String get upcomingMeetingsSectionTitle => 'الاجتماعات القادمة';

  @override
  String get viewAllTextButtonLabel => 'عرض الكل';

  @override
  String get noMeetingsPendingActionMessage => 'لا توجد اجتماعات في انتظار الإجراء';

  @override
  String get cancelMeetingButtonLabel => 'إلغاء الاجتماع';

  @override
  String get noUpcomingMeetingMessage => 'لا توجد اجتماعات قادمة';

  @override
  String get noPastMeetingsMessage => 'لا توجد اجتماعات سابقة';

  @override
  String get pastMeetingsSectionTitle => 'الاجتماعات السابقة';
}
