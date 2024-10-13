import 'meetings_localizations.dart';

/// The translations for English (`en`).
class MeetingsLocalizationsEn extends MeetingsLocalizations {
  MeetingsLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get meetingRequestsSectionTitle => 'Meeting Requests';

  @override
  String get upcomingMeetingsSectionTitle => 'Upcoming Meetings';

  @override
  String get viewAllTextButtonLabel => 'View All';

  @override
  String get noMeetingsPendingActionMessage => 'There are no meetings pending action';

  @override
  String get cancelMeetingButtonLabel => 'Cancel Meeting';

  @override
  String get noUpcomingMeetingMessage => 'No upcoming meetings';

  @override
  String get noPastMeetingsMessage => 'No past meetings';

  @override
  String get pastMeetingsSectionTitle => 'Past Meetings';
}
