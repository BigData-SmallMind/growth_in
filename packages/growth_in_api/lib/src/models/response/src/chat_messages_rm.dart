import 'package:json_annotation/json_annotation.dart';

part 'chat_messages_rm.g.dart';

@JsonSerializable(createToJson: false)
class DateGroupedChatsRM {
  DateGroupedChatsRM({
    required this.chats,
  });

  @JsonKey(name: 'messages')
  final List<ChatRM> chats;

  static const fromJson = _$DateGroupedChatsRMFromJson;
}

@JsonSerializable(createToJson: false)
class ChatRM {
  ChatRM({
    required this.date,
    required this.messages,
  });

  @JsonKey(name: 'date')
  final String date;
  @JsonKey(name: 'messages')
  final List<ChatMessageRM> messages;

  static const fromJson = _$ChatRMFromJson;
}

@JsonSerializable(createToJson: false)
class ChatMessageRM {
  ChatMessageRM({
    required this.id,
    this.text,
    this.files,
    required this.date,
    required this.sender,
    this.messageRepliedTo,
  });

  @JsonKey(name: 'id')
  final int id;
  @JsonKey(name: 'content')
  final String? text;
  @JsonKey(name: 'message_file')
  final List<FileRM>? files;
  @JsonKey(name: 'sent_at')
  final String date;
  @JsonKey(name: 'sender')
  final SenderRM sender;
  @JsonKey(name: 'message_reply')
  final ChatMessageRM? messageRepliedTo;

  static const fromJson = _$ChatMessageRMFromJson;
}

@JsonSerializable(createToJson: false)
class SenderRM {
  SenderRM({
    required this.id,
    required this.name,
    this.image,
  });

  @JsonKey(name: 'id')
  final int id;
  @JsonKey(name: 'user_name')
  final String name;
  @JsonKey(name: 'image')
  final String? image;

  static const fromJson = _$SenderRMFromJson;
}

@JsonSerializable(createToJson: false)
class FileRM {
  FileRM({
    required this.name,
    required this.path,
    required this.type,
    required this.size,
  });

  @JsonKey(name: 'file_name')
  final String name;
  @JsonKey(name: 'file_path')
  final String path;
  @JsonKey(name: 'file_type')
  final String type;
  @JsonKey(name: 'file_size')
  final int size;

  static const fromJson = _$FileRMFromJson;
}
