import 'switch_account_company_localizations.dart';

/// The translations for Arabic (`ar`).
class SwitchAccountCompanyLocalizationsAr extends SwitchAccountCompanyLocalizations {
  SwitchAccountCompanyLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get companyNotAssociatedErrorSnackBarMessage => 'الشركة غير مرتبطة. يرجى تسجيل الدخول مرة أخرى لتحديث القائمة.';

  @override
  String get companySwitchedSuccessSnackBarMessage => 'تم تغيير الشركة بنجاح.';
}
