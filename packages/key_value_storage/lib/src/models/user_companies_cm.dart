import 'package:hive/hive.dart';
import 'package:key_value_storage/src/models/company_cm.dart';

part 'user_companies_cm.g.dart';

@HiveType(typeId: 1)
class UserCompaniesCM {
  const UserCompaniesCM({
    required this.companies,
  });

  @HiveField(6)
  final List<CompanyCM> companies;
}
