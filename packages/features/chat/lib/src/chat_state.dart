part of 'chat_cubit.dart';

class ChatState extends Equatable {
  const ChatState({
    this.files,
    this.message,
    this.dateGroupedChats,
    this.fetchingStatus = ChatFetchingStatus.initial,
    this.submissionStatus = ChatSubmissionStatus.initial,
  });

  final List<File>? files;
  final String? message;
  final DateGroupedChats? dateGroupedChats;
  final ChatFetchingStatus fetchingStatus;
  final ChatSubmissionStatus submissionStatus;

  bool get isSendButtonDisabled =>
      (message?.isEmpty == true || message == null) &&
      (files?.isEmpty == true || files == null);

  ChatState copyWith({
    List<File>? files,
    String? message,
    DateGroupedChats? dateGroupedChats,
    ChatFetchingStatus? fetchingStatus,
    ChatSubmissionStatus? submissionStatus,
  }) {
    return ChatState(
      files: files ?? this.files,
      message: message ?? this.message,
      dateGroupedChats: dateGroupedChats ?? this.dateGroupedChats,
      fetchingStatus: fetchingStatus ?? this.fetchingStatus,
      submissionStatus: submissionStatus ?? this.submissionStatus,
    );
  }

  @override
  List<Object?> get props => [
        files,
        message,
        dateGroupedChats,
        fetchingStatus,
        submissionStatus,
      ];
}

enum ChatSubmissionStatus {
  initial,
  inProgress,
  success,
  failure,
}

enum ChatFetchingStatus {
  initial,
  inProgress,
  success,
  failure,
}
