import 'switch_account_company_localizations.dart';

/// The translations for English (`en`).
class SwitchAccountCompanyLocalizationsEn extends SwitchAccountCompanyLocalizations {
  SwitchAccountCompanyLocalizationsEn([super.locale = 'en']);

  @override
  String get companyNotAssociatedErrorSnackBarMessage => 'Company is not associated. Re login to refresh the list.';

  @override
  String get companySwitchedSuccessSnackBarMessage => 'Company switched successfully.';
}
