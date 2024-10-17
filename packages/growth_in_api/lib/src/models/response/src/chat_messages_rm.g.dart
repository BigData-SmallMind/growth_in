// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_messages_rm.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DateGroupedChatsRM _$DateGroupedChatsRMFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'DateGroupedChatsRM',
      json,
      ($checkedConvert) {
        final val = DateGroupedChatsRM(
          chats: $checkedConvert(
              'messages',
              (v) => (v as List<dynamic>)
                  .map((e) => ChatRM.fromJson(e as Map<String, dynamic>))
                  .toList()),
        );
        return val;
      },
      fieldKeyMap: const {'chats': 'messages'},
    );

ChatRM _$ChatRMFromJson(Map<String, dynamic> json) => $checkedCreate(
      'ChatRM',
      json,
      ($checkedConvert) {
        final val = ChatRM(
          date: $checkedConvert('date', (v) => v as String),
          messages: $checkedConvert(
              'messages',
              (v) => (v as List<dynamic>)
                  .map((e) => ChatMessageRM.fromJson(e as Map<String, dynamic>))
                  .toList()),
        );
        return val;
      },
    );

ChatMessageRM _$ChatMessageRMFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'ChatMessageRM',
      json,
      ($checkedConvert) {
        final val = ChatMessageRM(
          id: $checkedConvert('id', (v) => (v as num).toInt()),
          text: $checkedConvert('content', (v) => v as String?),
          files: $checkedConvert(
              'message_file',
              (v) => (v as List<dynamic>?)
                  ?.map((e) => FileRM.fromJson(e as Map<String, dynamic>))
                  .toList()),
          date: $checkedConvert('sent_at', (v) => v as String),
          sender: $checkedConvert(
              'sender', (v) => SenderRM.fromJson(v as Map<String, dynamic>)),
        );
        return val;
      },
      fieldKeyMap: const {
        'text': 'content',
        'files': 'message_file',
        'date': 'sent_at'
      },
    );

SenderRM _$SenderRMFromJson(Map<String, dynamic> json) => $checkedCreate(
      'SenderRM',
      json,
      ($checkedConvert) {
        final val = SenderRM(
          id: $checkedConvert('id', (v) => (v as num).toInt()),
          name: $checkedConvert('user_name', (v) => v as String),
          image: $checkedConvert('image', (v) => v as String?),
        );
        return val;
      },
      fieldKeyMap: const {'name': 'user_name'},
    );

FileRM _$FileRMFromJson(Map<String, dynamic> json) => $checkedCreate(
      'FileRM',
      json,
      ($checkedConvert) {
        final val = FileRM(
          name: $checkedConvert('file_name', (v) => v as String),
          path: $checkedConvert('file_path', (v) => v as String),
          type: $checkedConvert('file_type', (v) => v as String),
          size: $checkedConvert('file_size', (v) => (v as num).toInt()),
        );
        return val;
      },
      fieldKeyMap: const {
        'name': 'file_name',
        'path': 'file_path',
        'type': 'file_type',
        'size': 'file_size'
      },
    );
