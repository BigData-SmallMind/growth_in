import 'package:component_library/component_library.dart';
import 'package:domain_models/domain_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ticket_messages/src/ticket_messages_cubit.dart';

class MessagesList extends StatelessWidget {
  const MessagesList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TicketMessagesCubit, TicketMessagesState>(
      builder: (context, state) {
        final theme = GrowthInTheme.of(context);
        final loading =
            state.fetchingStatus == TicketMessagesFetchingStatus.inProgress;
        return Expanded(
          child: loading
              ? CenteredCircularProgressIndicator()
              : RefreshIndicator(
                  onRefresh: () async {
                    context.read<TicketMessagesCubit>().getTicketMessages();
                  },
                  child: ListView.builder(
                    padding:
                        EdgeInsets.symmetric(horizontal: theme.screenMargin),
                    itemCount: state.messages!.length,
                    itemBuilder: (context, index) {
                      final message = state.messages![index];
                      return MessageCard(
                        message: message,
                        isFirstElement: index == 0,
                      );
                    },
                  ),
                ),
        );
      },
    );
  }
}

class MessageCard extends StatelessWidget {
  const MessageCard({
    super.key,
    required this.message,
    required this.isFirstElement,
  });

  final TicketMessage message;
  final bool isFirstElement;

  @override
  Widget build(BuildContext context) {
    final theme = GrowthInTheme.of(context);
    final textTheme = Theme.of(context).textTheme;
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: Spacing.medium,
      ),
      margin: EdgeInsets.only(
        top: isFirstElement ? Spacing.medium : 0,
        bottom: Spacing.medium,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: theme.borderColor),
        borderRadius: BorderRadius.circular(10),
        color: Color(0xFFF5F5F5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Spacing.small),
            child: Row(
              children: [
                ProfileImage(
                  url: message.profileImage,
                  initials: message.companyName[0],
                ),
                HorizontalGap.small(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      message.companyName,
                      style: textTheme.titleMedium,
                    ),
                    VerticalGap.xSmall(),
                    DateWidget(date: message.createdAt),
                  ],
                ),
              ],
            ),
          ),
          VerticalGap.medium(),
          Divider(),
          VerticalGap.medium(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Spacing.small),
            child: Text(
              message.text,
              style: textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}

class DateWidget extends StatelessWidget {
  const DateWidget({
    super.key,
    required this.date,
  });

  final DateTime date;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Text(
      date.day.toString() +
          '/' +
          date.month.toString() +
          '/' +
          date.year.toString() +
          ' - ' +
          date.hour.toString() +
          ':' +
          date.minute.toString(),
      style: textTheme.bodySmall?.copyWith(
        color: Color(0xFF797979),
      ),
    );
  }
}
