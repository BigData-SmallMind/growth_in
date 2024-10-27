import 'files_localizations.dart';

/// The translations for English (`en`).
class FilesLocalizationsEn extends FilesLocalizations {
  FilesLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appBarTitle => 'Files';

  @override
  String get activeFilesTabLabel => 'Active';

  @override
  String get inActiveFilesTabLabel => 'InActive';

  @override
  String get noFilesMessageTitle => 'No Files!';

  @override
  String get noFilesMessageSubtitle => 'No Files';

  @override
  String get noFilesButtonLabel => 'Try Again';

  @override
  String get emptyListIndicatorText => 'List is empty';

  @override
  String get folderDetailsBottomSheetTitle => 'Details';

  @override
  String get mileStoneSectionTitle => 'Milestone';
}
