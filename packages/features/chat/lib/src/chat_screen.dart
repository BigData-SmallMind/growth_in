import 'package:chat/src/components/message_card.dart';
import 'package:chat/src/l10n/chat_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chat/src/chat_cubit.dart';
import 'package:folder_repository/folder_repository.dart';
import 'package:function_and_extension_library/function_and_extension_library.dart';
import 'package:user_repository/user_repository.dart';

import 'components/components.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({
    super.key,
    required this.userRepository,
    required this.folderRepository,
  });

  final UserRepository userRepository;
  final FolderRepository folderRepository;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocProvider<ChatCubit>(
      create: (_) => ChatCubit(
        userRepository: widget.userRepository,
        folderRepository: widget.folderRepository,
      ),
      child: const ChatView(),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class ChatView extends StatelessWidget {
  const ChatView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // final isTablet = !View.of(context).isSmallTabletOrLess;
    return BlocBuilder<ChatCubit, ChatState>(
      builder: (context, state) {
        final l10n = ChatLocalizations.of(context);
        final cubit = context.read<ChatCubit>();
        final isSubmissionInProgress =
            state.submissionStatus == ChatSubmissionStatus.inProgress;
        return GestureDetector(
          onTap: context.releaseFocus,
          child: Scaffold(
            appBar: AppBar(
              centerTitle: false,
              backgroundColor: Colors.white,
              title: Text(l10n.appBarTitle),
            ),
            body: Column(
              children: [
                const MessagesList(),
                if (state.messageBeingRepliedTo != null)
                  MessageCard(
                    isSubmissionInProgress: isSubmissionInProgress,
                    message: state.messageBeingRepliedTo!,
                    isFirstElement: false,
                    openDocument: (_) {},
                    // downloadFile: (_) {},
                    selectMessageToReply: cubit.selectMessageToReply,
                    isMessageBeingRepliedTo: true,
                    shouldShowDeleteIcon: true,
                  ),
                const SendMessage(),
              ],
            ),
          ),
        );
      },
    );
  }
}
