import 'package:json_annotation/json_annotation.dart';

part 'post_rm.g.dart';

@JsonSerializable(createToJson: false)
class PostRM {
  PostRM({
    required this.id,
    this.channel,
    this.contentGoal,
    this.contentType,
    this.text,
    this.images,
    required this.publicationDate,
    required this.status,
    required this.shouldShowRedDot,
  });

  @JsonKey(name: 'id')
  final int id;
  @JsonKey(name: 'channel')
  final String? channel;
  @JsonKey(name: 'content_goal')
  final String? contentGoal;
  @JsonKey(name: 'content_type')
  final String? contentType;
  @JsonKey(name: 'post_content')
  final String? text;
  @JsonKey(name: 'content_image')
  final String? images;
  @JsonKey(name: 'publication_date')
  final String publicationDate;
  @JsonKey(name: 'client_status')
  final String status;
  @JsonKey(name: 'show_red_dot_client')
  final int shouldShowRedDot;

  static const fromJson = _$PostRMFromJson;
}
