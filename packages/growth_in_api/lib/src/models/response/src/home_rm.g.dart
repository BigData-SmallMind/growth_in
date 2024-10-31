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
          post: $checkedConvert(
              'recent_post',
              (v) => v == null
                  ? null
                  : PostRM.fromJson(v as Map<String, dynamic>)),
        );
        return val;
      },
      fieldKeyMap: const {
        'meeting': 'latestUpcomingMeeting',
        'post': 'recent_post'
      },
    );
