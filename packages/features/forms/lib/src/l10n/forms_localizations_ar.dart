import 'forms_localizations.dart';

/// The translations for Arabic (`ar`).
class FormsLocalizationsAr extends FormsLocalizations {
  FormsLocalizationsAr([super.locale = 'ar']);

  @override
  String get appBarTitle => 'النماذج';

  @override
  String get waitingToCompleteFormText => 'نحن في إنتظار إكمالك النموذج لبدأ العمل';

  @override
  String get incompleteFormsSectionTitle => 'النماذج الغير مكتملة';

  @override
  String get previousFormsSectionTitle => 'النماذج المكتملة';

  @override
  String get noFormsErrorMessage => 'لا توجد نماذج';

  @override
  String get noFormsErrorTitle => 'لا توجد نماذج';
}
