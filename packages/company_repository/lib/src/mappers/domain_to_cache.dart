import 'package:domain_models/domain_models.dart';
import 'package:key_value_storage/key_value_storage.dart';

extension CompanyDMtoCM on Company {
  CompanyCM toCacheModel() {
    return CompanyCM(
      id: id,
      name: name,
      sector: sector,
      isClosed: isClosed,
      isSelected: isSelected,
      profileImage: profileImage,
      email: email,
    );
  }
}
