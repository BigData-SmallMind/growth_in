import 'submit_ticket_localizations.dart';

/// The translations for Arabic (`ar`).
class SubmitTicketLocalizationsAr extends SubmitTicketLocalizations {
  SubmitTicketLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get ticketSubmissionSuccessSnackBarMessage => 'تم إرسال التذكرة بنجاح';

  @override
  String get titleTextFieldLabel => 'العنوان';

  @override
  String get descriptionTextFieldLabel => 'الوصف';

  @override
  String get requiredFieldErrorMessage => 'مطلوب*';
}
