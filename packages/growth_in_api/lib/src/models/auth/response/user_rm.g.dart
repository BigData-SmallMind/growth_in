// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_rm.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserRM _$UserRMFromJson(Map<String, dynamic> json) => $checkedCreate(
      'UserRM',
      json,
      ($checkedConvert) {
        final val = UserRM(
          info: $checkedConvert(
              'account', (v) => UserInfoRM.fromJson(v as Map<String, dynamic>)),
          token: $checkedConvert('token', (v) => v as String),
        );
        return val;
      },
      fieldKeyMap: const {'info': 'account'},
    );

UserInfoRM _$UserInfoRMFromJson(Map<String, dynamic> json) => $checkedCreate(
      'UserInfoRM',
      json,
      ($checkedConvert) {
        final val = UserInfoRM(
          id: $checkedConvert('id', (v) => (v as num).toInt()),
          name: $checkedConvert('user_name', (v) => v as String),
          email: $checkedConvert('email', (v) => v as String),
          phone: $checkedConvert('phone', (v) => v as String),
          countryCode:
              $checkedConvert('country_code', (v) => (v as num).toInt()),
          image: $checkedConvert('profile_image', (v) => v as String?),
          role: $checkedConvert('role', (v) => v as String),
          selectedCompanyName:
              $checkedConvert('selected_company_name', (v) => v as String),
          selectedCompanyId:
              $checkedConvert('selected_company_id', (v) => (v as num).toInt()),
          companies: $checkedConvert(
              'companies',
              (v) => (v as List<dynamic>)
                  .map((e) => CompanyRM.fromJson(e as Map<String, dynamic>))
                  .toList()),
        );
        return val;
      },
      fieldKeyMap: const {
        'name': 'user_name',
        'countryCode': 'country_code',
        'image': 'profile_image',
        'selectedCompanyName': 'selected_company_name',
        'selectedCompanyId': 'selected_company_id'
      },
    );
