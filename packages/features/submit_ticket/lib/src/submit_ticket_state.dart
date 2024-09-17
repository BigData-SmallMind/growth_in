part of 'submit_ticket_cubit.dart';

class SubmitTicketState extends Equatable {
  const SubmitTicketState({
    this.type = const Dynamic<TicketType?>.unvalidated(),
    this.title = const Dynamic<String?>.unvalidated(),
    this.description = const Dynamic<String?>.unvalidated(),
    this.ticketsTypes = const [],
    this.submissionStatus = FormzSubmissionStatus.initial,
  });

  final Dynamic<TicketType?> type;
  final Dynamic<String?> title;
  final Dynamic<String?> description;
  final List<TicketType> ticketsTypes;
  final FormzSubmissionStatus submissionStatus;

  SubmitTicketState copyWith({
    Dynamic<TicketType?>? type,
    Dynamic<String?>? ticketTitle,
    Dynamic<String?>? ticketDescription,
    List<TicketType>? ticketsTypes,
    FormzSubmissionStatus? submissionStatus,
  }) {
    return SubmitTicketState(
      type: type ?? this.type,
      title: ticketTitle ?? this.title,
      description: ticketDescription ?? this.description,
      ticketsTypes: ticketsTypes ?? this.ticketsTypes,
      submissionStatus: submissionStatus ?? this.submissionStatus,
    );
  }

  @override
  List<Object?> get props => [
        type,
        title,
        description,
        ticketsTypes,
        submissionStatus,
      ];
}
