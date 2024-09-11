import 'package:growth_in_api/src/models/response/src/company_rm.dart';
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
    required this.selectedCompanyName,
    required this.selectedCompanyId,
    required this.companies,

  });

  @JsonKey(name: 'id')
  final int id;
  @JsonKey(name: 'email')
  final String email;
  @JsonKey(name: 'role')
  final String role;
  @JsonKey(name: 'selected_company_name')
  final String selectedCompanyName;
  @JsonKey(name: 'selected_company_id')
  final int selectedCompanyId;
  @JsonKey(name: 'companies')
  final List<CompanyRM> companies;
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