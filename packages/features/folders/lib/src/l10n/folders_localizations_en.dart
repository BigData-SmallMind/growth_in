import 'folders_localizations.dart';

/// The translations for English (`en`).
class FoldersLocalizationsEn extends FoldersLocalizations {
  FoldersLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appBarTitle => 'Files';

  @override
  String get activeFoldersTabLabel => 'Active';

  @override
  String get inActiveFoldersTabLabel => 'InActive';

  @override
  String get noFoldersMessageTitle => 'No Folders!';

  @override
  String get noFoldersMessageSubtitle => 'No Folders';

  @override
  String get noFoldersButtonLabel => 'Try Again';

  @override
  String get emptyListIndicatorText => 'List is empty';

  @override
  String get folderDetailsBottomSheetTitle => 'Details';

  @override
  String get mileStoneSectionTitle => 'Milestone';
}
