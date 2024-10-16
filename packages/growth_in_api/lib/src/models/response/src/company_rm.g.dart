// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company_rm.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CompanyRM _$CompanyRMFromJson(Map<String, dynamic> json) => $checkedCreate(
      'CompanyRM',
      json,
      ($checkedConvert) {
        final val = CompanyRM(
          id: $checkedConvert('id', (v) => (v as num).toInt()),
          name: $checkedConvert('company_name', (v) => v as String),
          sector: $checkedConvert('company_sector', (v) => v as String),
          isClosed: $checkedConvert('is_closed', (v) => (v as num).toInt()),
          profileImage: $checkedConvert('profile_image', (v) => v as String?),
          email: $checkedConvert('email', (v) => v as String?),
        );
        return val;
      },
      fieldKeyMap: const {
        'name': 'company_name',
        'sector': 'company_sector',
        'isClosed': 'is_closed',
        'profileImage': 'profile_image'
      },
    );
