import 'meeting_details_localizations.dart';

/// The translations for Arabic (`ar`).
class MeetingDetailsLocalizationsAr extends MeetingDetailsLocalizations {
  MeetingDetailsLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get dayRowTitle => 'اليوم';

  @override
  String get timeRowTitle => 'الوقت';

  @override
  String get serviceRowTitle => 'الخدمة';

  @override
  String get typeRowTitle => 'النوع';

  @override
  String get linkRowTitle => 'الرابط';

  @override
  String get meetingPlanSectionTitle => 'خطة الاجتماع';

  @override
  String get meetingSummarySectionTitle => 'ملخص الاجتماع';

  @override
  String get cancelMeetingButtonLabel => 'الغاء الطلب';

  @override
  String get rescheduleMeetingButtonLabel => 'عدل الموعد';

  @override
  String get setMeetingTimeButtonLabel => 'تحديد الموعد';
}
