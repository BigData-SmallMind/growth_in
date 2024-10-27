// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'file_rm.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FileV2RM _$FileV2RMFromJson(Map<String, dynamic> json) => $checkedCreate(
      'FileV2RM',
      json,
      ($checkedConvert) {
        final val = FileV2RM(
          id: $checkedConvert('id', (v) => (v as num).toInt()),
          name: $checkedConvert('file_name', (v) => v as String),
          fileSize: $checkedConvert('file_size', (v) => (v as num).toInt()),
          typeIcon: $checkedConvert('file_type_icon', (v) => v as String),
          linkName: $checkedConvert('link_name', (v) => v as String?),
          link: $checkedConvert('link', (v) => v as String?),
          status: $checkedConvert('status', (v) => v as String),
          asserts: $checkedConvert(
              'assets',
              (v) => (v as List<dynamic>)
                  .map((e) => AssetRM.fromJson(e as Map<String, dynamic>))
                  .toList()),
        );
        return val;
      },
      fieldKeyMap: const {
        'name': 'file_name',
        'fileSize': 'file_size',
        'typeIcon': 'file_type_icon',
        'linkName': 'link_name',
        'asserts': 'assets'
      },
    );

AssetRM _$AssetRMFromJson(Map<String, dynamic> json) => $checkedCreate(
      'AssetRM',
      json,
      ($checkedConvert) {
        final val = AssetRM(
          name: $checkedConvert('asset_name', (v) => v as String),
          size: $checkedConvert('asset_size', (v) => (v as num).toInt()),
        );
        return val;
      },
      fieldKeyMap: const {'name': 'asset_name', 'size': 'asset_size'},
    );
