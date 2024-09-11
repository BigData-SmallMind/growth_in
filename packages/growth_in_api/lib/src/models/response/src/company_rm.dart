import 'package:json_annotation/json_annotation.dart';

part 'company_rm.g.dart';

@JsonSerializable(createToJson: false)
class CompanyRM {
  CompanyRM({
    required this.id,
    required this.name,
    required this.sector,
    this.profileImage,
    this.email,
  });

  @JsonKey(name: 'id')
  final int id;
  @JsonKey(name: 'company_name')
  final String name;
  @JsonKey(name: 'company_sector')
  final String sector;
  @JsonKey(name: 'profile_image')
  final String? profileImage;
  @JsonKey(name: 'email')
  final String? email;

  static const fromJson = _$CompanyRMFromJson;
}
