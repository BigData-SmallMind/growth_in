import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:function_and_extension_library/function_and_extension_library.dart';
import 'package:ticket_messages/src/components/messages_list.dart';
import 'package:ticket_messages/src/components/send_message.dart';
import 'package:ticket_messages/src/l10n/ticket_messages_localizations.dart';
import 'package:ticket_messages/src/ticket_messages_cubit.dart';
import 'package:user_repository/user_repository.dart';

class TicketMessagesScreen extends StatelessWidget {
  const TicketMessagesScreen({
    super.key,
    required this.userRepository,
  });

  final UserRepository userRepository;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TicketMessagesCubit>(
      create: (_) => TicketMessagesCubit(
        userRepository: userRepository,
      ),
      child: GestureDetector(
        onTap: context.releaseFocus,
        child: const TicketMessagesView(),
      ),
    );
  }
}

class TicketMessagesView extends StatelessWidget {
  const TicketMessagesView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TicketMessagesCubit, TicketMessagesState>(
      builder: (context, state) {
        final theme = GrowthInTheme.of(context);
        final l10n = TicketMessagesLocalizations.of(context);

        return Scaffold(
          appBar: GrowthInAppBar(
            logoVariation: false,
            title: Text(l10n.appBarTitle),
          ),
          body: Column(
            children: [
              TicketCard(
                ticket: state.ticket!,
                margin: EdgeInsets.symmetric(
                  horizontal: theme.screenMargin,
                ),
              ),
              const MessagesList(),
              const SendMessage(),
            ],
          ),
        );
      },
    );
  }
}
