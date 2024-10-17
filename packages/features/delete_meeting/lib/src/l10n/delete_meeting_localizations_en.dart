import 'delete_meeting_localizations.dart';

/// The translations for English (`en`).
class DeleteMeetingLocalizationsEn extends DeleteMeetingLocalizations {
  DeleteMeetingLocalizationsEn([super.locale = 'en']);

  @override
  String get otherReasonTextFieldHint => 'Type the reason here';

  @override
  String get requiredFieldErrorMessage => 'Required';

  @override
  String get requiredTextMessage => 'Required';

  @override
  String get confirmMeetingDeletionButtonLabel => 'Confirm';

  @override
  String get meetingDeletedSuccessfully => 'Meeting deleted successfully';
}
