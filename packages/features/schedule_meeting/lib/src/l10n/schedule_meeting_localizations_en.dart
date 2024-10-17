import 'schedule_meeting_localizations.dart';

/// The translations for English (`en`).
class ScheduleMeetingLocalizationsEn extends ScheduleMeetingLocalizations {
  ScheduleMeetingLocalizationsEn([super.locale = 'en']);

  @override
  String get timeSlotsSectionTitle => 'Time Slots';

  @override
  String get noSlotsAvailableIndicatorText => 'No slots available';

  @override
  String get schedulingInProgressButtonLabel => 'Confirming...';

  @override
  String get confirmMeetingScheduleButtonLabel => 'Confirm';
}
