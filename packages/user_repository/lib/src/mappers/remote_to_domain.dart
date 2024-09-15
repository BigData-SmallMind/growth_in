import 'package:company_repository/company_repository.dart';
import 'package:growth_in_api/growth_in_api.dart';
import 'package:domain_models/domain_models.dart';

extension UserRMtoDM on UserRM {
  User toDomainModel() {
    final companiesDM = info.companies
        .map(
          (company) => company.toDomainModel().copyWith(
                isSelected: company.id == info.selectedCompanyId ? true : false,
              ),
        )
        .toList();

    return User(
      id: info.id,
      name: info.name,
      email: info.email,
      phone: info.phone,
      countryCode: info.countryCode,
      image: info.image,
      companies: companiesDM,
    );
  }
}
