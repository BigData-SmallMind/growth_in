import 'schedule_meeting_localizations.dart';

/// The translations for English (`en`).
class ScheduleMeetingLocalizationsEn extends ScheduleMeetingLocalizations {
  ScheduleMeetingLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get timeSlotsSectionTitle => 'Time Slots';

  @override
  String get noSlotsAvailableIndicatorText => 'No slots available';
}
