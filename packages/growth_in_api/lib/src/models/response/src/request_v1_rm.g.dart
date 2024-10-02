// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_v1_rm.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RequestV1RM _$RequestV1RMFromJson(Map<String, dynamic> json) => $checkedCreate(
      'RequestV1RM',
      json,
      ($checkedConvert) {
        final val = RequestV1RM(
          id: $checkedConvert('task_id', (v) => (v as num).toInt()),
          name: $checkedConvert('task_name', (v) => v as String),
          serviceName: $checkedConvert('service_name', (v) => v as String?),
          type: $checkedConvert('task_type', (v) => v as String),
          dueDate: $checkedConvert('due_date', (v) => v as String),
          startDate: $checkedConvert('start_date', (v) => v as String),
          status: $checkedConvert('status', (v) => v as String),
          actionsCompletedCount: $checkedConvert(
              'completed_contents_count', (v) => (v as num).toInt()),
          actionsTotalCount: $checkedConvert(
              'total_contents_count', (v) => (v as num).toInt()),
        );
        return val;
      },
      fieldKeyMap: const {
        'id': 'task_id',
        'name': 'task_name',
        'serviceName': 'service_name',
        'type': 'task_type',
        'dueDate': 'due_date',
        'startDate': 'start_date',
        'actionsCompletedCount': 'completed_contents_count',
        'actionsTotalCount': 'total_contents_count'
      },
    );
