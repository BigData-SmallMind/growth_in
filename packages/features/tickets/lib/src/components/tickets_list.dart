import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tickets/src/l10n/tickets_localizations.dart';
import 'package:tickets/src/tickets_cubit.dart';

class TicketsList extends StatelessWidget {
  const TicketsList({
    Key? key,
    required this.active,
  }) : super(key: key);
  final bool active;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TicketsCubit, TicketsState>(
      builder: (context, state) {
        final tickets = active ? state.activeTickets : state.inActiveTickets;
        final cubit = context.read<TicketsCubit>();
        final l10n = TicketsLocalizations.of(context);
        return state.tickets == null
            ? CenteredCircularProgressIndicator()
            : RefreshIndicator(
                onRefresh: () async {
                  context.read<TicketsCubit>().getTickets();
                },
                child: tickets.isEmpty
                    ? Center(
                        child: Text(
                          l10n.emptyListIndicatorText,
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      )
                    : ListView.separated(
                        itemCount: tickets.length,
                        itemBuilder: (context, index) {
                          final ticket = tickets[index];
                          return TicketCard(
                            ticket: ticket,
                            isFirstElement: index == 0,
                            onTicketTapped: (ticket) =>
                                cubit.onTicketTapped(ticket),
                          );
                        },
                        separatorBuilder: (context, index) =>
                            VerticalGap.medium(),
                      ),
              );
      },
    );
  }
}
