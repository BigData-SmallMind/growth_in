import 'forms_localizations.dart';

/// The translations for English (`en`).
class FormsLocalizationsEn extends FormsLocalizations {
  FormsLocalizationsEn([super.locale = 'en']);

  @override
  String get appBarTitle => 'Forms';

  @override
  String get waitingToCompleteFormText => 'We are waiting for you to complete the form to start working';

  @override
  String get incompleteFormsSectionTitle => 'Incomplete Forms';

  @override
  String get previousFormsSectionTitle => 'Previous Forms';

  @override
  String get noFormsErrorMessage => 'No forms found';

  @override
  String get noFormsErrorTitle => 'No forms';
}
