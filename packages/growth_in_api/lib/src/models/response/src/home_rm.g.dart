// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_rm.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeRM _$HomeRMFromJson(Map<String, dynamic> json) => $checkedCreate(
      'HomeRM',
      json,
      ($checkedConvert) {
        final val = HomeRM(
          meeting: $checkedConvert(
              'latestUpcomingMeeting',
              (v) => v == null
                  ? null
                  : MeetingRM.fromJson(v as Map<String, dynamic>)),
          posts: $checkedConvert(
              'posts',
              (v) =>
                  (v as List<dynamic>?)
                      ?.map((e) => PostRM.fromJson(e as Map<String, dynamic>))
                      .toList() ??
                  const []),
          requests: $checkedConvert(
              'delayed_tasks',
              (v) =>
                  (v as List<dynamic>?)
                      ?.map((e) =>
                          HomeRequestRM.fromJson(e as Map<String, dynamic>))
                      .toList() ??
                  const []),
          dashboardLink: $checkedConvert('dashboard_link', (v) => v as String?),
          filesCount:
              $checkedConvert('files_count', (v) => (v as num?)?.toInt()),
        );
        return val;
      },
      fieldKeyMap: const {
        'meeting': 'latestUpcomingMeeting',
        'requests': 'delayed_tasks',
        'dashboardLink': 'dashboard_link',
        'filesCount': 'files_count'
      },
    );

HomeRequestRM _$HomeRequestRMFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'HomeRequestRM',
      json,
      ($checkedConvert) {
        final val = HomeRequestRM(
          id: $checkedConvert('id', (v) => (v as num).toInt()),
          name: $checkedConvert('task_name', (v) => v as String),
          startDate: $checkedConvert('start_date', (v) => v as String),
          dueDate: $checkedConvert('due_date', (v) => v as String),
        );
        return val;
      },
      fieldKeyMap: const {
        'name': 'task_name',
        'startDate': 'start_date',
        'dueDate': 'due_date'
      },
    );
