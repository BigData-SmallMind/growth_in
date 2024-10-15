import 'create_meeting_localizations.dart';

/// The translations for Arabic (`ar`).
class CreateMeetingLocalizationsAr extends CreateMeetingLocalizations {
  CreateMeetingLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get homeTabLabel => 'الرئيسية';

  @override
  String get cmsTabLabel => 'المحتوى';

  @override
  String get messagesTabLabel => 'التواصل';

  @override
  String get filesTabLabel => 'ملفاتي';

  @override
  String get menuTabLabel => 'المزيد';
}
