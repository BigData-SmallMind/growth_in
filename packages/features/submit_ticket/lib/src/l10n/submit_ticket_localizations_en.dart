import 'submit_ticket_localizations.dart';

/// The translations for English (`en`).
class SubmitTicketLocalizationsEn extends SubmitTicketLocalizations {
  SubmitTicketLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get ticketSubmissionSuccessSnackBarMessage => 'Ticket submitted successfully';

  @override
  String get titleTextFieldLabel => 'Ticket Title';

  @override
  String get descriptionTextFieldLabel => 'Description';

  @override
  String get requiredFieldErrorMessage => 'This field is required';
}
