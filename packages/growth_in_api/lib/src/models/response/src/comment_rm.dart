import 'package:json_annotation/json_annotation.dart';

part 'comment_rm.g.dart';

@JsonSerializable(createToJson: false)
class CommentRM {
  CommentRM({
    required this.id,
    this.comment,
    this.commentText,
    this.commentImage,
    this.profileImage,
    required this.author,
    required this.dateCreated,
  });

  @JsonKey(name: 'id')
  final int id;
  @JsonKey(name: 'comment')
  final String? comment;
  @JsonKey(name: 'comment_text')
  final String? commentText;
  @JsonKey(name: 'comment_image')
  final String? commentImage;
  @JsonKey(name: 'profile_image')
  final String? profileImage;
  @JsonKey(name: 'user_name')
  final String author;
  @JsonKey(name: 'created_at')
  final String dateCreated;

  static const fromJson = _$CommentRMFromJson;
}
