import 'package:growth_in_api/growth_in_api.dart';
import 'package:key_value_storage/key_value_storage.dart';

extension UserRMtoCM on UserRM {
  UserCM toCacheModel() {
    return UserCM(
      id: info.id,
      name: info.name,
      email: info.email,
      phone: info.phone,

    );
  }
}

