import 'tab_container_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class TabContainerLocalizationsEn extends TabContainerLocalizations {
  TabContainerLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get tasksTabLabel => 'Tasks';

  @override
  String get contactsTabLabel => 'Contacts';

  @override
  String get dashboardTabLabel => 'Dashboard';

  @override
  String get companiesTabLabel => 'Companies';

  @override
  String get dealsTabLabel => 'Deals';

  @override
  String get menuTabLabel => 'Menu';

  @override
  String get appDependenciesFetchSuccessSnackBarMessage => 'App content updated successfully';

  @override
  String get refreshAppDepButtonTooltip => 'Refreshes the app content';
}
