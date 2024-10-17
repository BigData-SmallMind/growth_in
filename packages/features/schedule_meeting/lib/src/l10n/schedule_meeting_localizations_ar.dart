import 'schedule_meeting_localizations.dart';

/// The translations for Arabic (`ar`).
class ScheduleMeetingLocalizationsAr extends ScheduleMeetingLocalizations {
  ScheduleMeetingLocalizationsAr([super.locale = 'ar']);

  @override
  String get timeSlotsSectionTitle => 'اختر وقتًا للاجتماع';

  @override
  String get noSlotsAvailableIndicatorText => 'لا توجد فترات زمنية متاحة';

  @override
  String get schedulingInProgressButtonLabel => 'جارٍ التأكيد...';

  @override
  String get confirmMeetingScheduleButtonLabel => 'تأكيد';
}
