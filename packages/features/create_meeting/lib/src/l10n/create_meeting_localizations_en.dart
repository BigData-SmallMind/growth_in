import 'create_meeting_localizations.dart';

/// The translations for English (`en`).
class CreateMeetingLocalizationsEn extends CreateMeetingLocalizations {
  CreateMeetingLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get homeTabLabel => 'Contacts';

  @override
  String get cmsTabLabel => 'Dashboard';

  @override
  String get messagesTabLabel => 'Companies';

  @override
  String get filesTabLabel => 'Deals';

  @override
  String get menuTabLabel => 'Menu';
}
