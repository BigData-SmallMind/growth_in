// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_rm.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProjectRM _$ProjectRMFromJson(Map<String, dynamic> json) => $checkedCreate(
      'ProjectRM',
      json,
      ($checkedConvert) {
        final val = ProjectRM(
          id: $checkedConvert('project_id', (v) => (v as num).toInt()),
          name: $checkedConvert('project_name', (v) => v as String?),
          description:
              $checkedConvert('project_description', (v) => v as String?),
        );
        return val;
      },
      fieldKeyMap: const {
        'id': 'project_id',
        'name': 'project_name',
        'description': 'project_description'
      },
    );
