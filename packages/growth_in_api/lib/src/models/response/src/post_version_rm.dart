import 'package:json_annotation/json_annotation.dart';

part 'post_version_rm.g.dart';

@JsonSerializable(createToJson: false)
class PostVersionRM {
  PostVersionRM({
    required this.id,
    required this.postId,
    required this.username,
    required this.dateSubmitted,
    required this.isSelected,
  });

  @JsonKey(name: 'id')
  final int id;
  @JsonKey(name: 'post_id')
  final int postId;
  @JsonKey(name: 'user_name')
  final String username;
  @JsonKey(name: 'submission_date_time')
  final String dateSubmitted;
  @JsonKey(name: 'selected')
  final int isSelected;


  static const fromJson = _$PostVersionRMFromJson;
}
