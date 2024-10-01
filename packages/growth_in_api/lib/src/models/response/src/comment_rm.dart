import 'package:json_annotation/json_annotation.dart';

part 'comment_rm.g.dart';

@JsonSerializable(createToJson: false)
class CommentRM {
  CommentRM({
    required this.id,
    required this.comment,
     this.image,
    required this.author,
    required this.dateCreated,
  });

  @JsonKey(name: 'id')
  final int id;
  @JsonKey(name: 'comment')
  final String comment;
  @JsonKey(name: 'comment_image')
  final String? image;
  @JsonKey(name: 'user_name')
  final String author;
  @JsonKey(name: 'created_at')
  final String dateCreated;


  static const fromJson = _$CommentRMFromJson;
}
