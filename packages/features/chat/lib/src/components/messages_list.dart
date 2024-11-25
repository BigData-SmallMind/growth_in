import 'package:chat/src/chat_cubit.dart';
import 'package:chat/src/l10n/chat_localizations.dart';
import 'package:component_library/component_library.dart';
import 'package:domain_models/domain_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:function_and_extension_library/function_and_extension_library.dart';
import 'package:intl/intl.dart' as intl;

class MessagesList extends StatelessWidget {
  const MessagesList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatCubit, ChatState>(
      builder: (context, state) {
        final loading = state.fetchingStatus == ChatFetchingStatus.inProgress;
        final error = state.fetchingStatus == ChatFetchingStatus.failure;
        final textTheme = Theme.of(context).textTheme;
        final cubit = context.read<ChatCubit>();
        final l10n = ChatLocalizations.of(context);
        return Expanded(
          child: loading
              ? const CenteredCircularProgressIndicator()
              : error
                  ? ExceptionIndicator(
                      onTryAgain: context.read<ChatCubit>().getChat,
                    )
                  : state.dateGroupedChats!.list.isEmpty
                      ? Center(
                          child: Text(
                            l10n.noMessagesIndicator,
                            style: textTheme.titleLarge,
                          ),
                        )
                      : RefreshIndicator(
                          onRefresh: () async {
                            context.read<ChatCubit>().getChat();
                          },
                          child: ListView.builder(
                            controller: cubit.scrollController,
                            itemCount: state.dateGroupedChats!.list.length,
                            itemBuilder: (context, index) {
                              final chat = state.dateGroupedChats!.list[index];
                              return Column(
                                children: [
                                  Text(
                                    intl.DateFormat('yyyy-MM-dd')
                                        .format(chat.date),
                                    style: textTheme.titleMedium
                                        ?.copyWith(fontWeight: FontWeight.bold),
                                  ),
                                  ColumnBuilder(
                                    itemBuilder: (context, index) {
                                      final message = chat.messages[index];
                                      return MessageCard(
                                        message: message,
                                        isFirstElement: index == 0,
                                      );
                                    },
                                    itemCount: chat.messages.length,
                                  ),
                                  StreamBuilder<DateGroupedChats>(
                                      stream: cubit.chatStream,
                                      builder: (context, snapshot) {
                                        return snapshot.hasData
                                            ? MessageCard(
                                                message: (snapshot.data
                                                        as DateGroupedChats)
                                                    .list
                                                    .first
                                                    .messages
                                                    .first,
                                                isFirstElement: false,
                                              )
                                            : const SizedBox();
                                      }),
                                ],
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

  final ChatMessage message;
  final bool isFirstElement;

  @override
  Widget build(BuildContext context) {
    final theme = GrowthInTheme.of(context);
    final textTheme = Theme.of(context).textTheme;
    final isSentByMe = message.isSentByMe;
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(
        left: Spacing.medium,
        right: Spacing.medium,
        top: Spacing.small,
        bottom: Spacing.xSmall,
      ),
      margin: EdgeInsets.only(
        top: isFirstElement ? Spacing.medium : 0,
        bottom: Spacing.medium,
        left: isSentByMe ? theme.screenMargin : theme.screenMargin * 2,
        right: isSentByMe ? theme.screenMargin * 2 : theme.screenMargin,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: theme.borderColor),
        borderRadius: BorderRadius.circular(10),
        color: isSentByMe ? const Color(0xFFEFEFEF) : theme.secondaryColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (message.text != null) ...[
            SelectableText(
              message.text!,
              style: textTheme.bodyMedium?.copyWith(
                color: isSentByMe
                    ? null
                    : theme.materialThemeData.colorScheme.surface,
              ),
            ),
            VerticalGap.small(),
          ],
          Row(
            children: [
              const Spacer(),
              SelectableText(
                message.date.formatDateTimeTo12Hour()!,
                textDirection: TextDirection.ltr,
                style: textTheme.bodySmall?.copyWith(
                  color: isSentByMe
                      ? const Color(0xFF797979)
                      : theme.materialThemeData.colorScheme.surface,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
