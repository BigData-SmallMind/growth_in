// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_rm.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RequestRM _$RequestRMFromJson(Map<String, dynamic> json) => $checkedCreate(
      'RequestRM',
      json,
      ($checkedConvert) {
        final val = RequestRM(
          id: $checkedConvert('task_id', (v) => (v as num).toInt()),
          name: $checkedConvert('task_name', (v) => v as String),
          serviceName: $checkedConvert('service_name', (v) => v as String?),
          projectName: $checkedConvert('project_name', (v) => v as String?),
          campaignName: $checkedConvert('campaign_name', (v) => v as String?),
          deadline: $checkedConvert('due_date', (v) => v as String),
          dateCreated: $checkedConvert('start_date', (v) => v as String),
          actions: $checkedConvert(
              'items',
              (v) => (v as List<dynamic>?)
                  ?.map((e) => ActionRM.fromJson(e as Map<String, dynamic>))
                  .toList()),
          descriptionHtml: $checkedConvert('description', (v) => v as String?),
          isCompleted: $checkedConvert('is_completed', (v) => v as bool),
        );
        return val;
      },
      fieldKeyMap: const {
        'id': 'task_id',
        'name': 'task_name',
        'serviceName': 'service_name',
        'projectName': 'project_name',
        'campaignName': 'campaign_name',
        'deadline': 'due_date',
        'dateCreated': 'start_date',
        'actions': 'items',
        'descriptionHtml': 'description',
        'isCompleted': 'is_completed'
      },
    );

ActionRM _$ActionRMFromJson(Map<String, dynamic> json) => $checkedCreate(
      'ActionRM',
      json,
      ($checkedConvert) {
        final val = ActionRM(
          id: $checkedConvert('item_id', (v) => (v as num).toInt()),
          title: $checkedConvert('task_title', (v) => v as String),
          files: $checkedConvert('task_files',
              (v) => (v as List<dynamic>?)?.map((e) => e as String).toList()),
          steps: $checkedConvert(
              'task_content',
              (v) => (v as List<dynamic>?)
                  ?.map((e) => StepRM.fromJson(e as Map<String, dynamic>))
                  .toList()),
        );
        return val;
      },
      fieldKeyMap: const {
        'id': 'item_id',
        'title': 'task_title',
        'files': 'task_files',
        'steps': 'task_content'
      },
    );

StepRM _$StepRMFromJson(Map<String, dynamic> json) => $checkedCreate(
      'StepRM',
      json,
      ($checkedConvert) {
        final val = StepRM(
          id: $checkedConvert('content_id', (v) => (v as num).toInt()),
          content: $checkedConvert('content', (v) => v as String),
          isCompleted: $checkedConvert('is_completed', (v) => v as bool),
        );
        return val;
      },
      fieldKeyMap: const {'id': 'content_id', 'isCompleted': 'is_completed'},
    );

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
