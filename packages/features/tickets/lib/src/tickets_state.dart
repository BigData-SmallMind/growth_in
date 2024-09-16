part of 'tickets_cubit.dart';

class TicketsState extends Equatable {
  const TicketsState({
    this.tickets,
    this.fetchingStatus = TicketsFetchingStatus.initial,
  });

  final List<Ticket>? tickets;
  final TicketsFetchingStatus fetchingStatus;

  List<Ticket> get activeTickets =>
      tickets?.where((ticket) => ticket.status == TicketStatus.open).toList() ??
      [];

  List<Ticket> get inActiveTickets =>
      tickets
          ?.where((ticket) => !(ticket.status == TicketStatus.open))
          .toList() ??
      [];

  TicketsState copyWith({
    List<Ticket>? tickets,
    TicketsFetchingStatus? fetchingStatus,
  }) {
    return TicketsState(
      tickets: tickets ?? this.tickets,
      fetchingStatus: fetchingStatus ?? this.fetchingStatus,
    );
  }

  @override
  List<Object?> get props => [
        tickets,
        fetchingStatus,
      ];
}

enum TicketsFetchingStatus {
  initial,
  inProgress,
  success,
  failure,
}
