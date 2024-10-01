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
          comment: $checkedConvert('comment', (v) => v as String),
          image: $checkedConvert('comment_image', (v) => v as String?),
          author: $checkedConvert('user_name', (v) => v as String),
          dateCreated: $checkedConvert('created_at', (v) => v as String),
        );
        return val;
      },
      fieldKeyMap: const {
        'image': 'comment_image',
        'author': 'user_name',
        'dateCreated': 'created_at'
      },
    );
