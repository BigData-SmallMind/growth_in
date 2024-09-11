import 'package:key_value_storage/key_value_storage.dart';

class UserLocalStorage {
  UserLocalStorage({
    required this.noSqlStorage,
  });

  final KeyValueStorage noSqlStorage;

  Future<void> upsertLocalePreference(LocalePreferenceCM preference) async {
    final box = await noSqlStorage.localePreferenceBox;
    await box.put(0, preference);
  }

  Future<LocalePreferenceCM?> getLocalePreference() async {
    final box = await noSqlStorage.localePreferenceBox;
    return box.get(0);
  }

  Future<void> upsertUserCompanies(UserCompaniesCM userCompanies) async {
    final box = await noSqlStorage.userCompaniesBox;
    await box.put(0, userCompanies);
  }

  Future<UserCompaniesCM?> getUserCompanies() async {
    final box = await noSqlStorage.userCompaniesBox;
    return box.get(0);
  }


}
