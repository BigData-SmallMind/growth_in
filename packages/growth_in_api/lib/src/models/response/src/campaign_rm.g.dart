// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'campaign_rm.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CampaignRM _$CampaignRMFromJson(Map<String, dynamic> json) => $checkedCreate(
      'CampaignRM',
      json,
      ($checkedConvert) {
        final val = CampaignRM(
          id: $checkedConvert('id', (v) => (v as num).toInt()),
          name: $checkedConvert('name', (v) => v as String),
          contentGoal: $checkedConvert('content_goal', (v) => v as String?),
          summary: $checkedConvert('summary', (v) => v as String?),
          postCount: $checkedConvert('post_count', (v) => (v as num).toInt()),
        );
        return val;
      },
      fieldKeyMap: const {
        'contentGoal': 'content_goal',
        'postCount': 'post_count'
      },
    );
