import 'meeting_details_localizations.dart';

/// The translations for English (`en`).
class MeetingDetailsLocalizationsEn extends MeetingDetailsLocalizations {
  MeetingDetailsLocalizationsEn([super.locale = 'en']);

  @override
  String get dayRowTitle => 'Day';

  @override
  String get timeRowTitle => 'Time';

  @override
  String get serviceRowTitle => 'Service';

  @override
  String get typeRowTitle => 'Type';

  @override
  String get linkRowTitle => 'Link';

  @override
  String get meetingPlanSectionTitle => 'Meeting Plan';

  @override
  String get meetingSummarySectionTitle => 'Meeting Summary';

  @override
  String get cancelMeetingButtonLabel => 'Cancel Request';

  @override
  String get rescheduleMeetingButtonLabel => 'Edit Appointment';

  @override
  String get setMeetingTimeButtonLabel => 'Set Appointment';
}
