// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_rm.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommentRM _$CommentRMFromJson(Map<String, dynamic> json) => $checkedCreate(
      'CommentRM',
      json,
      ($checkedConvert) {
        final val = CommentRM(
          id: $checkedConvert('id', (v) => (v as num).toInt()),
          comment: $checkedConvert('comment', (v) => v as String?),
          commentText: $checkedConvert('comment_text', (v) => v as String?),
          commentImage: $checkedConvert('comment_image', (v) => v as String?),
          profileImage: $checkedConvert('profile_image', (v) => v as String?),
          author: $checkedConvert('user_name', (v) => v as String),
          dateCreated: $checkedConvert('created_at', (v) => v as String),
        );
        return val;
      },
      fieldKeyMap: const {
        'commentText': 'comment_text',
        'commentImage': 'comment_image',
        'profileImage': 'profile_image',
        'author': 'user_name',
        'dateCreated': 'created_at'
      },
    );
