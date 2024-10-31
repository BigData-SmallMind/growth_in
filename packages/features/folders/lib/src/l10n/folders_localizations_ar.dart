import 'folders_localizations.dart';

/// The translations for Arabic (`ar`).
class FoldersLocalizationsAr extends FoldersLocalizations {
  FoldersLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appBarTitle => 'الملفات';

  @override
  String get activeFoldersTabLabel => 'النشط';

  @override
  String get inActiveFoldersTabLabel => 'المنتهي';

  @override
  String get noFoldersMessageTitle => 'لا توجد ملفات!';

  @override
  String get noFoldersMessageSubtitle => 'لا توجد ملفات';

  @override
  String get noFoldersButtonLabel => 'حاول مرة أخرى';

  @override
  String get emptyListIndicatorText => 'القائمة فارغة';

  @override
  String get folderDetailsBottomSheetTitle => 'التفاصيل';

  @override
  String get mileStoneSectionTitle => 'الانجاز';
}
