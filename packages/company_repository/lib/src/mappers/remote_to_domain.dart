import 'package:domain_models/domain_models.dart';
import 'package:growth_in_api/growth_in_api.dart';

extension CompanyRMtoDM on CompanyRM {
  Company toDomainModel() {
    return Company(
      id: id,
      name: name,
      sector: sector,
      profileImage: profileImage,
      email: email,
    );
  }
}
