part of 'ticket_messages_cubit.dart';

class TicketMessagesState extends Equatable {
  const TicketMessagesState({
    this.ticket,
    this.file,
    this.message,
    this.messages,
    this.fetchingStatus = TicketMessagesFetchingStatus.initial,
    this.submissionStatus = TicketMessagesSubmissionStatus.initial,
  });

  final Ticket? ticket;
  final File? file;
  final String? message;
  final List<TicketMessage>? messages;
  final TicketMessagesFetchingStatus fetchingStatus;
  final TicketMessagesSubmissionStatus submissionStatus;

  bool get isMessageEmpty => message?.isEmpty == true || message == null;

  TicketMessagesState copyWith({
    Ticket? ticket,
    File? file,
    String? message,
    List<TicketMessage>? messages,
    TicketMessagesFetchingStatus? fetchingStatus,
    TicketMessagesSubmissionStatus? submissionStatus,
  }) {
    return TicketMessagesState(
      ticket: ticket ?? this.ticket,
      file: file ?? this.file,
      message: message ?? this.message,
      messages: messages ?? this.messages,
      fetchingStatus: fetchingStatus ?? this.fetchingStatus,
      submissionStatus: submissionStatus ?? this.submissionStatus,
    );
  }

  @override
  List<Object?> get props => [
        ticket,
        file,
        message,
        messages,
        fetchingStatus,
        submissionStatus,
      ];
}

enum TicketMessagesSubmissionStatus {
  initial,
  inProgress,
  success,
  failure,
}
enum TicketMessagesFetchingStatus {
  initial,
  inProgress,
  success,
  failure,
}
