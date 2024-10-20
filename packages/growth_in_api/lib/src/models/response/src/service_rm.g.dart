// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_rm.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServiceRM _$ServiceRMFromJson(Map<String, dynamic> json) => $checkedCreate(
      'ServiceRM',
      json,
      ($checkedConvert) {
        final val = ServiceRM(
          id: $checkedConvert('id', (v) => (v as num).toInt()),
          name: $checkedConvert('service_name', (v) => v as String),
        );
        return val;
      },
      fieldKeyMap: const {'name': 'service_name'},
    );
