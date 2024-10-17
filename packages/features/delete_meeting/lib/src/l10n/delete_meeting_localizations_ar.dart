import 'delete_meeting_localizations.dart';

/// The translations for Arabic (`ar`).
class DeleteMeetingLocalizationsAr extends DeleteMeetingLocalizations {
  DeleteMeetingLocalizationsAr([super.locale = 'ar']);

  @override
  String get otherReasonTextFieldHint => 'اكتب السبب هنا';

  @override
  String get requiredFieldErrorMessage => 'مطلوب';

  @override
  String get requiredTextMessage => 'مطلوب';

  @override
  String get confirmMeetingDeletionButtonLabel => 'تأكيد';

  @override
  String get meetingDeletedSuccessfully => 'تم حذف الاجتماع بنجاح';
}
