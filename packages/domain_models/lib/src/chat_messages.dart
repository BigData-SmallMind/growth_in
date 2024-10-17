import 'package:domain_models/src/file_dm.dart';

class DateGroupedChats {
  final List<Chat> list;

  DateGroupedChats({
    required this.list,
  });

  DateGroupedChats copyWith({
    List<Chat>? list,
  }) {
    return DateGroupedChats(
      list: list ?? this.list,
    );
  }
}

class Chat {
  final DateTime date;
  final List<ChatMessage> messages;

  Chat({
    required this.date,
    required this.messages,
  });

  Chat copyWith({
    DateTime? date,
    List<ChatMessage>? messages,
  }) {
    return Chat(
      date: date ?? this.date,
      messages: messages ?? this.messages,
    );
  }
}

class ChatMessage {
  final int id;
  final String? text;
  final List<FileDM>? files;
  final DateTime date;
  final Sender sender;
  final bool isSentByMe;

  ChatMessage({
    required this.id,
    this.text,
    this.files,
    required this.date,
    required this.sender,
    this.isSentByMe = false,
  });

  ChatMessage copyWith({
    bool? isSentByMe,
  }) {
    return ChatMessage(
      id: id,
      text: text,
      files: files,
      date: date,
      sender: sender,
      isSentByMe: isSentByMe ?? this.isSentByMe,
    );
  }
}

class Sender {
  final int id;
  final String name;
  final String? image;

  Sender({
    required this.id,
    required this.name,
    this.image,
  });
}
