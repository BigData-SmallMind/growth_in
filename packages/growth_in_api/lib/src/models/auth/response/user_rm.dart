import 'package:json_annotation/json_annotation.dart';

part 'user_rm.g.dart';

@JsonSerializable(createToJson: false)
class UserRM {
  UserRM({
    required this.info,
    required this.token,
  });

  @JsonKey(name: 'account')
  final UserInfoRM info;
  @JsonKey(name: 'token')
  final String token;

  static const fromJson = _$UserRMFromJson;
}



@JsonSerializable(createToJson: false)
class UserInfoRM {
  UserInfoRM({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.countryCode,
    this.image,
    required this.role,
    required this.companyName,
    required this.companySector,
  });

  @JsonKey(name: 'id')
  final int id;
  @JsonKey(name: 'email')
  final String email;
  @JsonKey(name: 'role')
  final String role;
  @JsonKey(name: 'company_name')
  final String companyName;
  @JsonKey(name: 'company_sector')
  final String companySector;
  @JsonKey(name: 'user_name')
  final String name;
  @JsonKey(name: 'phone')
  final String phone;
  @JsonKey(name: 'country_code')
  final int countryCode;
  @JsonKey(name: 'profile_image')
  final String? image;

  static const fromJson = _$UserInfoRMFromJson;
}