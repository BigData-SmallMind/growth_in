import 'package:growth_in_api/growth_in_api.dart';
import 'package:domain_models/domain_models.dart';

extension UserRMtoDM on UserRM {
  User toDomainModel() {
    return User(
      id:info. id,
      name: info.name,
      email: info.email,
      phone: info.phone,
    );
  }
}

