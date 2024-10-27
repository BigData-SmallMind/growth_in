import 'files_localizations.dart';

/// The translations for Arabic (`ar`).
class FilesLocalizationsAr extends FilesLocalizations {
  FilesLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appBarTitle => 'الملفات';

  @override
  String get activeFilesTabLabel => 'النشط';

  @override
  String get inActiveFilesTabLabel => 'المنتهي';

  @override
  String get noFilesMessageTitle => 'لا توجد رسائل!';

  @override
  String get noFilesMessageSubtitle => 'لا توجد رسائل';

  @override
  String get noFilesButtonLabel => 'حاول مرة أخرى';

  @override
  String get emptyListIndicatorText => 'القائمة فارغة';

  @override
  String get folderDetailsBottomSheetTitle => 'التفاصيل';

  @override
  String get mileStoneSectionTitle => 'الانجاز';
}
