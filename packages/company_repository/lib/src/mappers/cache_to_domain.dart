import 'package:domain_models/domain_models.dart';
import 'package:key_value_storage/key_value_storage.dart';

extension CompanyCMtoDM on CompanyCM {
  Company toDomainModel() {
    return Company(
      id: id,
      name: name,
      sector: sector,
      isSelected: isSelected,
      profileImage: profileImage,
      email: email,
    );
  }
}
