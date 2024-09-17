import 'package:component_library/component_library.dart';
import 'package:domain_models/src/ticket.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
        return state.tickets == null
            ? CenteredCircularProgressIndicator()
            : RefreshIndicator(
                onRefresh: () async {
                  context.read<TicketsCubit>().getTickets();
                },
                child: ListView.separated(
                  itemCount: tickets.length,
                  itemBuilder: (context, index) {
                    final ticket = tickets[index];
                    return TicketCard(
                      ticket: ticket,
                      isFirstElement: index == 0,
                    );
                  },
                  separatorBuilder: (context, index) => VerticalGap.medium(),
                ),
              );
      },
    );
  }
}

class TicketCard extends StatelessWidget {
  const TicketCard({
    super.key,
    required this.ticket,
    required this.isFirstElement,
  });

  final Ticket ticket;
  final bool isFirstElement;

  @override
  Widget build(BuildContext context) {
    final theme = GrowthInTheme.of(context);
    final textTheme = Theme.of(context).textTheme;
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: Spacing.medium,
        horizontal: Spacing.small,
      ),
      margin: EdgeInsets.only(
        top: isFirstElement ? Spacing.medium : 0,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: theme.borderColor),
        borderRadius: BorderRadius.circular(10),
      ),
      height: 140,
      child: Column(
        children: [
          Row(
            children: [
              if (ticket.subject != null)
                Container(
                  padding: EdgeInsets.symmetric(
                    vertical: Spacing.xSmall,
                    horizontal: Spacing.small,
                  ),
                  decoration: BoxDecoration(
                    color: Color(0xFFFFFAEB),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    ticket.subject!,
                    style: textTheme.bodySmall?.copyWith(
                      color: Color(0xFFCA7C4B),
                    ),
                  ),
                ),
              Spacer(),
              Text(
                ticket.createdAt.hour.toString() +
                    ':' +
                    ticket.createdAt.minute.toString(),
                style: textTheme.bodySmall?.copyWith(
                  color: Color(0xFF797979),
                ),
              ),
            ],
          ),
          VerticalGap.small(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                    color: Color(0xFFF2F2F2), shape: BoxShape.circle),
                child: SvgAsset(AssetPathConstants.receiptPath),
              ),
              HorizontalGap.small(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${ticket.id} #',
                    style: textTheme.titleSmall,
                    textDirection: TextDirection.ltr,
                  ),
                  VerticalGap.xSmall(),
                  Text(
                    ticket.title,
                    style: textTheme.bodySmall,
                  ),
                ],
              ),
              Spacer(),
              Icon(
                Icons.arrow_forward_ios_rounded,
                color: Color(0xFF8D9695),
                size: 20,
              ),
            ],
          ),
          Divider(
            height: Spacing.large,
          ),
          Row(
            children: [
              SvgAsset(AssetPathConstants.clockPath),
              HorizontalGap.small(),
              Text(
                  ticket.createdAt.day.toString() +
                      '/' +
                      ticket.createdAt.month.toString() +
                      '/' +
                      ticket.createdAt.year.toString(),
                  style: textTheme.bodySmall?.copyWith(
                    color: Color(0xFF797979),
                  )),
              HorizontalGap.small(),
              Text(
                  '-' +
                      ticket.createdAt.hour.toString() +
                      ':' +
                      ticket.createdAt.minute.toString(),
                  style: textTheme.bodySmall?.copyWith(
                    color: Color(0xFF797979),
                  )),
            ],
          ),
        ],
      ),
    );
  }
}
