// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forms_rm.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FormsRM _$FormsRMFromJson(Map<String, dynamic> json) => $checkedCreate(
      'FormsRM',
      json,
      ($checkedConvert) {
        final val = FormsRM(
          list: $checkedConvert(
              'forms',
              (v) => (v as List<dynamic>)
                  .map((e) => FormRM.fromJson(e as Map<String, dynamic>))
                  .toList()),
          previous: $checkedConvert(
              'previous_forms',
              (v) => (v as List<dynamic>)
                  .map((e) => FormRM.fromJson(e as Map<String, dynamic>))
                  .toList()),
        );
        return val;
      },
      fieldKeyMap: const {'list': 'forms', 'previous': 'previous_forms'},
    );
