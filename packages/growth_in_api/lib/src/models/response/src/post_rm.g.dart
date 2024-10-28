// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_rm.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostRM _$PostRMFromJson(Map<String, dynamic> json) => $checkedCreate(
      'PostRM',
      json,
      ($checkedConvert) {
        final val = PostRM(
          id: $checkedConvert('id', (v) => (v as num).toInt()),
          channel: $checkedConvert('channel', (v) => v as String?),
          contentGoal: $checkedConvert('content_goal', (v) => v as String?),
          contentType: $checkedConvert('content_type', (v) => v as String?),
          text: $checkedConvert('post_content', (v) => v as String?),
          images: $checkedConvert('content_image', (v) => v as String?),
          publicationDate:
              $checkedConvert('publication_date', (v) => v as String),
          status: $checkedConvert('client_status', (v) => v as String),
          shouldShowRedDot:
              $checkedConvert('show_red_dot_client', (v) => (v as num).toInt()),
        );
        return val;
      },
      fieldKeyMap: const {
        'contentGoal': 'content_goal',
        'contentType': 'content_type',
        'text': 'post_content',
        'images': 'content_image',
        'publicationDate': 'publication_date',
        'status': 'client_status',
        'shouldShowRedDot': 'show_red_dot_client'
      },
    );
