import 'package:growth_in_api/growth_in_api.dart';
import 'package:json_annotation/json_annotation.dart';

part 'home_rm.g.dart';

@JsonSerializable(createToJson: false)
class HomeRM {
  HomeRM({
    this.meeting,
    this.post,
  });

  @JsonKey(name: 'latestUpcomingMeeting')
  final MeetingRM? meeting;
  @JsonKey(name: 'recent_post')
  final PostRM? post;

  static const fromJson = _$HomeRMFromJson;
}