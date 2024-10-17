import 'create_meeting_localizations.dart';

/// The translations for English (`en`).
class CreateMeetingLocalizationsEn extends CreateMeetingLocalizations {
  CreateMeetingLocalizationsEn([super.locale = 'en']);

  @override
  String get descriptionTextFieldLabel => 'Meeting Plan Details';

  @override
  String get descriptionTextFieldHint => 'Meeting plan or key points';

  @override
  String get titleTextFieldLabel => 'Meeting Title';

  @override
  String get requiredFieldErrorMessage => 'Required';

  @override
  String get titleTextFieldHint => 'Enter the title here';

  @override
  String get nextStepButtonLabel => 'Next Step';

  @override
  String get lastStepButtonLabel => 'Book';

  @override
  String get stepOneLabel => 'Fill in the general details';

  @override
  String get stepTwoLabel => 'Date';

  @override
  String get stepThreeLabel => 'Meeting Details';

  @override
  String get typeTextFieldLabel => 'Type of meeting';

  @override
  String get selectedSlotLabel => 'Time';

  @override
  String get selectedDayLabel => 'Day';
}
