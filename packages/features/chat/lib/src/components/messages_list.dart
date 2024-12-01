import 'package:chat/src/chat_cubit.dart';
import 'package:chat/src/components/message_card.dart';
import 'package:chat/src/l10n/chat_localizations.dart';
import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
        final isSubmissionInProgress =
            state.submissionStatus == ChatSubmissionStatus.inProgress;
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
                                        isSubmissionInProgress:
                                            isSubmissionInProgress,
                                        isMessageBeingRepliedTo: false,
                                        shouldShowDeleteIcon: false,
                                        message: message,
                                        downloadFile: (file) {
                                          cubit.downloadFile(file);
                                        },
                                        openDocument: (url) {
                                          cubit.openDocument(url);
                                        },
                                        isFirstElement: index == 0,
                                        selectMessageToReply: (message) {
                                          cubit.selectMessageToReply(message);
                                        },
                                      );
                                    },
                                    itemCount: chat.messages.length,
                                  ),
                                  // StreamBuilder<DateGroupedChats>(
                                  //   stream: cubit.chatStream,
                                  //   builder: (context, snapshot) {
                                  //     return snapshot.hasData
                                  //         ? MessageCard(
                                  //             message: (snapshot.data
                                  //                     as DateGroupedChats)
                                  //                 .list
                                  //                 .first
                                  //                 .messages
                                  //                 .first,
                                  //             openDocument: (url) {
                                  //               cubit.openDocument(url);
                                  //             },
                                  //             isFirstElement: false,
                                  //           )
                                  //         : const SizedBox();
                                  //   },
                                  // ),
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

