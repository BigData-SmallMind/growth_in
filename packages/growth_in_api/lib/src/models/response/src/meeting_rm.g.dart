// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meeting_rm.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MeetingRM _$MeetingRMFromJson(Map<String, dynamic> json) => $checkedCreate(
      'MeetingRM',
      json,
      ($checkedConvert) {
        final val = MeetingRM(
          id: $checkedConvert('id', (v) => (v as num).toInt()),
          type: $checkedConvert('meeting_type', (v) => v as String),
          title: $checkedConvert('meeting_title', (v) => v as String),
          startDate: $checkedConvert('meeting_start_date', (v) => v as String?),
          endDate: $checkedConvert('meeting_end_date', (v) => v as String?),
          plan: $checkedConvert('meeting_plan', (v) => v as String?),
          files: $checkedConvert('files', (v) => v as String?),
          link: $checkedConvert('meeting_link', (v) => v as String?),
          summary: $checkedConvert('meeting_summary', (v) => v as String?),
          cancellationReason:
              $checkedConvert('reason_meeting_cancle', (v) => v as String?),
        );
        return val;
      },
      fieldKeyMap: const {
        'type': 'meeting_type',
        'title': 'meeting_title',
        'startDate': 'meeting_start_date',
        'endDate': 'meeting_end_date',
        'plan': 'meeting_plan',
        'link': 'meeting_link',
        'summary': 'meeting_summary',
        'cancellationReason': 'reason_meeting_cancle'
      },
    );

MeetingsRM _$MeetingsRMFromJson(Map<String, dynamic> json) => $checkedCreate(
      'MeetingsRM',
      json,
      ($checkedConvert) {
        final val = MeetingsRM(
          latest: $checkedConvert(
              'latestUpcomingMeeting',
              (v) => v == null
                  ? null
                  : MeetingRM.fromJson(v as Map<String, dynamic>)),
          all: $checkedConvert(
              'AllMeetingRequests',
              (v) => (v as List<dynamic>)
                  .map((e) => MeetingRM.fromJson(e as Map<String, dynamic>))
                  .toList()),
          upcoming: $checkedConvert(
              'AllUpcomingMeeting',
              (v) => (v as List<dynamic>)
                  .map((e) => MeetingRM.fromJson(e as Map<String, dynamic>))
                  .toList()),
          past: $checkedConvert(
              'historyMeeting',
              (v) => (v as List<dynamic>?)
                  ?.map((e) => MeetingRM.fromJson(e as Map<String, dynamic>))
                  .toList()),
        );
        return val;
      },
      fieldKeyMap: const {
        'latest': 'latestUpcomingMeeting',
        'all': 'AllMeetingRequests',
        'upcoming': 'AllUpcomingMeeting',
        'past': 'historyMeeting'
      },
    );
