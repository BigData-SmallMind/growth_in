import 'package:json_annotation/json_annotation.dart';
part 'meeting_rm.g.dart';

@JsonSerializable(createToJson: false)
class MeetingRM {
  MeetingRM({
    required this.id,
    required this.type,
    required this.title,
    this.startDate,
    this.endDate,
    this.plan,
    this.files,
    this.link,
    this.summary,
    this.cancellationReason,
  });

  @JsonKey(name: 'id')
  final int id;
  @JsonKey(name: 'meeting_type')
  final String type;
  @JsonKey(name: 'meeting_title')
  final String title;
  @JsonKey(name: 'meeting_start_date')
  final String? startDate;
  @JsonKey(name: 'meeting_end_date')
  final String? endDate;
  @JsonKey(name: 'meeting_plan')
  final String? plan;
  @JsonKey(name: 'files')
  final String? files;
  @JsonKey(name: 'meeting_link')
  final String? link;
  @JsonKey(name: 'meeting_summary')
  final String? summary;
  @JsonKey(name: 'reason_meeting_cancle')
  final String? cancellationReason;

  static const fromJson = _$MeetingRMFromJson;
}

@JsonSerializable(createToJson: false)
class MeetingsRM {
  MeetingsRM({
    this.latest,
    required this.all,
    required this.upcoming,
    this.past,
  });

  @JsonKey(name: 'latestUpcomingMeeting')
  final MeetingRM? latest;
  @JsonKey(name: 'AllMeetingRequests')
  final List<MeetingRM> all;
  @JsonKey(name: 'AllUpcomingMeeting')
  final List<MeetingRM> upcoming;
  @JsonKey(name: 'historyMeeting')
  final List<MeetingRM>? past;

  static const fromJson = _$MeetingsRMFromJson;
}
