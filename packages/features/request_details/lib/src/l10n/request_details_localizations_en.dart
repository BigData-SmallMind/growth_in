import 'request_details_localizations.dart';

/// The translations for English (`en`).
class RequestDetailsLocalizationsEn extends RequestDetailsLocalizations {
  RequestDetailsLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appBarTitle => 'Requests';

  @override
  String get deadlineSectionTitle => 'Deadline';

  @override
  String get serviceNameSectionTitle => 'Service Name';

  @override
  String get descriptionSectionTitle => 'Description';

  @override
  String get actionsSectionTitle => 'Actions';

  @override
  String get viewAllActionsButtonLabel => 'View All';

  @override
  String get actionTitle => 'Action #';

  @override
  String get percentActionsComplete => 'Steps Completed';

  @override
  String get commentsSectionTitle => 'Comments';

  @override
  String get viewAllCommentsButtonLabel => 'View All';
}
