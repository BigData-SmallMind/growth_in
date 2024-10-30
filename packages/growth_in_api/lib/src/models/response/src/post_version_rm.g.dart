// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_version_rm.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostVersionRM _$PostVersionRMFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'PostVersionRM',
      json,
      ($checkedConvert) {
        final val = PostVersionRM(
          id: $checkedConvert('id', (v) => (v as num).toInt()),
          postId: $checkedConvert('post_id', (v) => (v as num).toInt()),
          username: $checkedConvert('user_name', (v) => v as String),
          dateSubmitted:
              $checkedConvert('submission_date_time', (v) => v as String),
          isSelected: $checkedConvert('selected', (v) => (v as num).toInt()),
        );
        return val;
      },
      fieldKeyMap: const {
        'postId': 'post_id',
        'username': 'user_name',
        'dateSubmitted': 'submission_date_time',
        'isSelected': 'selected'
      },
    );
