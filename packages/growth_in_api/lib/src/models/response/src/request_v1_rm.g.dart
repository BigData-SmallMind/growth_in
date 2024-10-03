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
          projectName: $checkedConvert('project_name', (v) => v as String?),
          campaignName: $checkedConvert('campaign_name', (v) => v as String?),
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
        'projectName': 'project_name',
        'campaignName': 'campaign_name',
        'type': 'task_type',
        'dueDate': 'due_date',
        'startDate': 'start_date',
        'actionsCompletedCount': 'completed_contents_count',
        'actionsTotalCount': 'total_contents_count'
      },
    );

PaginationRM _$PaginationRMFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'PaginationRM',
      json,
      ($checkedConvert) {
        final val = PaginationRM(
          currentPage:
              $checkedConvert('current_page', (v) => (v as num).toInt()),
          lastPage: $checkedConvert('last_page', (v) => (v as num).toInt()),
        );
        return val;
      },
      fieldKeyMap: const {
        'currentPage': 'current_page',
        'lastPage': 'last_page'
      },
    );

RequestListPageRM _$RequestListPageRMFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'RequestListPageRM',
      json,
      ($checkedConvert) {
        final val = RequestListPageRM(
          requestsList: $checkedConvert(
              'tasks',
              (v) => (v as List<dynamic>)
                  .map((e) => RequestV1RM.fromJson(e as Map<String, dynamic>))
                  .toList()),
          pagination: $checkedConvert('pagination',
              (v) => PaginationRM.fromJson(v as Map<String, dynamic>)),
        );
        return val;
      },
      fieldKeyMap: const {'requestsList': 'tasks'},
    );
