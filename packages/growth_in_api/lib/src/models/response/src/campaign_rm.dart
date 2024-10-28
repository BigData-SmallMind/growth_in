import 'package:json_annotation/json_annotation.dart';

part 'campaign_rm.g.dart';

@JsonSerializable(createToJson: false)
class CampaignRM {
  CampaignRM({
    required this.id,
    required this.name,
    required this.contentGoal,
    this.summary,
    required this.postCount,
  });

  @JsonKey(name: 'id')
  final int id;
  @JsonKey(name: 'name')
  final String name;
  @JsonKey(name: 'content_goal')
  final String contentGoal;
  @JsonKey(name: 'summary')
  final String? summary;
  @JsonKey(name: 'post_count')
  final int postCount;

  static const fromJson = _$CampaignRMFromJson;
}
