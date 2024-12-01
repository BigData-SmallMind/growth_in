import 'package:domain_models/src/file_dm.dart';
import 'package:equatable/equatable.dart';

class DateGroupedChats extends Equatable {
  final List<Chat> list;

  const DateGroupedChats({
    required this.list,
  });

  DateGroupedChats copyWith({
    List<Chat>? list,
  }) {
    return DateGroupedChats(
      list: list ?? this.list,
    );
  }

  @override
  List<Object?> get props => [list];
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
  final ChatMessage? messageRepliedTo;

  ChatMessage({
    required this.id,
    this.text,
    this.files,
    required this.date,
    required this.sender,
    this.isSentByMe = false,
    this.messageRepliedTo,
  });

  ChatMessage copyWith({
    bool? isSentByMe,
    ChatMessage? messageRepliedTo,
  }) {
    return ChatMessage(
      id: id,
      text: text,
      files: files,
      date: date,
      sender: sender,
      isSentByMe: isSentByMe ?? this.isSentByMe,
      messageRepliedTo: messageRepliedTo ?? this.messageRepliedTo,
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
