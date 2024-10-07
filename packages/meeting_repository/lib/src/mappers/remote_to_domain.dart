// import 'package:json_annotation/json_annotation.dart';
// part 'meeting_rm.g.dart';
//
// @JsonSerializable(createToJson: false)
// class MeetingRM {
//   MeetingRM({
//     required this.id,
//     required this.type,
//     required this.title,
//     this.startDate,
//     this.endDate,
//     this.plan,
//     this.files,
//     this.link,
//     this.summary,
//     this.cancellationReason,
//   });
//
//   @JsonKey(name: 'id')
//   final int id;
//   @JsonKey(name: 'meeting_type')
//   final String type;
//   @JsonKey(name: 'meeting_title')
//   final String title;
//   @JsonKey(name: 'meeting_start_date')
//   final String? startDate;
//   @JsonKey(name: 'meeting_end_date')
//   final String? endDate;
//   @JsonKey(name: 'meeting_plan')
//   final String? plan;
//   @JsonKey(name: 'files')
//   final String? files;
//   @JsonKey(name: 'meeting_link')
//   final String? link;
//   @JsonKey(name: 'meeting_summary')
//   final String? summary;
//   @JsonKey(name: 'reason_meeting_cancle')
//   final String? cancellationReason;
//
//   static const fromJson = _$MeetingRMFromJson;
// }
//
// @JsonSerializable(createToJson: false)
// class MeetingsRM {
//   MeetingsRM({
//     this.latest,
//     required this.all,
//     required this.upcoming,
//     this.past,
//   });
//
//   @JsonKey(name: 'latestUpcomingMeeting')
//   final MeetingRM? latest;
//   @JsonKey(name: 'AllMeetingRequests')
//   final List<MeetingRM> all;
//   @JsonKey(name: 'AllUpcomingMeeting')
//   final List<MeetingRM> upcoming;
//   @JsonKey(name: 'historyMeeting')
//   final List<MeetingRM>? past;
//
//   static const fromJson = _$MeetingsRMFromJson;
// }

import 'dart:convert';

import 'package:domain_models/domain_models.dart';
import 'package:growth_in_api/growth_in_api.dart';

extension MeetingRMtoDM on MeetingRM {
  // "meeting_start_date": "2024-09-02 14:30:00",
  // "meeting_end_date": "2024-09-02 15:30:00",
  // "files": "[{\"file_name\":\"mouse.png\",\"file_path\":\"files\\/mouse.png\",\"file_type\":\"image\\/png\",\"file_size\":29675}]",

  // "2024-09-02 14:30:00" to date time
  Meeting toDomainModel() {
    try {
      final filesMap =
          files == null ? null : json.decode(files!) as List<dynamic>;
      // final filesDM = filesMap.entries
      //     .map((e) => FileDM(
      //           name: e.value['file_name'],
      //           extension: e.value['file_type'],
      //           size: e.value['file_size'],
      //         ))
      //     .toList();
      final filesDM = filesMap
          ?.map(
            (e) => FileDM(
              name: e['file_name'],
              extension: e['file_type'],
              size: e['file_size'],
            ),
          )
          .toList();
      return Meeting(
        id: id,
        type: type,
        title: title,
        startDate: DateTime.tryParse(startDate ?? ''),
        endDate: DateTime.tryParse(endDate ?? ''),
        plan: plan,
        files: filesDM,
        link: link,
        summary: summary,
        cancellationReason: cancellationReason,
      );
    } catch (error) {
      rethrow;
    }
  }
}

extension MeetingsRMtoDM on MeetingsRM {
  Meetings toDomainModel() {
    final latestMeeting = latest?.toDomainModel();
    final allMeetings = all.map((e) => e.toDomainModel()).toList();
    final upcomingMeetings = upcoming.map((e) => e.toDomainModel()).toList();
    final pastMeetings = past?.map((e) => e.toDomainModel()).toList();
    return Meetings(
      latestUpcoming: latestMeeting,
      pendingAction: allMeetings,
      upcoming: upcomingMeetings,
      past: pastMeetings,
    );
  }
}
