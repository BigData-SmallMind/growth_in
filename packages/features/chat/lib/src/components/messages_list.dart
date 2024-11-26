import 'package:chat/src/chat_cubit.dart';
import 'package:chat/src/l10n/chat_localizations.dart';
import 'package:component_library/component_library.dart';
import 'package:domain_models/domain_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:function_and_extension_library/function_and_extension_library.dart';
import 'package:intl/intl.dart' as intl;
import 'package:video_player/video_player.dart';

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
                                        downloadFile: (file) {
                                          cubit.downloadFile(file);
                                        },
                                        openDocument: (url) {
                                          cubit.openDocument(url);
                                        },
                                        isFirstElement: index == 0,
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

class MessageCard extends StatelessWidget {
  const MessageCard({
    super.key,
    required this.message,
    required this.isFirstElement,
    required this.openDocument,
    required this.downloadFile,
  });

  final ChatMessage message;
  final bool isFirstElement;
  final Function(String) openDocument;
  final Function(FileDM) downloadFile;

  @override
  Widget build(BuildContext context) {
    final theme = GrowthInTheme.of(context);
    final textTheme = Theme.of(context).textTheme;
    final isSentByMe = message.isSentByMe;
    final l10n = ChatLocalizations.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (isFirstElement) VerticalGap.medium(),
        Row(
          children: [
            HorizontalGap.custom(theme.screenMargin * 2),
            Text(
              isSentByMe ? l10n.messageSentByMeCardTitle : message.sender.name,
              style: textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: isSentByMe
                    ? theme.materialThemeData.colorScheme.secondary
                    : theme.materialThemeData.colorScheme.surface,
              ),
            ),
          ],
        ),
        VerticalGap.xSmall(),
        Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.only(
            left: Spacing.medium,
            right: Spacing.medium,
            top: Spacing.small,
            bottom: Spacing.xSmall,
          ),
          margin: EdgeInsetsDirectional.only(
            bottom: Spacing.medium,
            end: isSentByMe ? theme.screenMargin : theme.screenMargin * 2,
            start: isSentByMe ? theme.screenMargin * 2 : theme.screenMargin,
          ),
          decoration: BoxDecoration(
            border: Border.all(color: theme.borderColor),
            borderRadius: BorderRadius.circular(10),
            color: isSentByMe ? const Color(0xFFEFEFEF) : theme.secondaryColor,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (message.text != null && message.text?.isNotEmpty == true) ...[
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
              if (message.files?.isNotEmpty == true) ...[
                Column(
                  children: [
                    if (message.files![0].type == FileType.image)
                      GestureDetector(
                        onTap: () => showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(0),
                            ),
                            contentPadding: EdgeInsets.zero,
                            insetPadding: EdgeInsets.zero,
                            content: InteractiveViewer(
                              child: Image.network(
                                message.files![0].dlUrl!,
                                fit: BoxFit.fitHeight,
                              ),
                            ),
                            alignment: Alignment.bottomCenter,
                            actionsAlignment: MainAxisAlignment.spaceBetween,
                            actionsPadding: const EdgeInsets.only(
                              top: Spacing.large,
                            ),
                            actions: [
                              IconButton(
                                onPressed: () {
                                  downloadFile(message.files![0]);
                                },
                                icon: const SvgAsset(
                                    AssetPathConstants.downloadPath),
                              ),
                              IconButton(
                                  onPressed: () => Navigator.pop(context),
                                  icon: const Icon(Icons.arrow_forward_ios))
                            ],
                          ),
                        ),
                        child: Image.network(
                          message.files![0].dlUrl!,
                          fit: BoxFit.fitHeight,
                          height: 100,
                        ),
                      ),
                    if (message.files![0].type == FileType.document)
                      IconButton(
                        icon: const Icon(Icons.insert_drive_file),
                        onPressed: () {
                          openDocument(message.files![0].dlUrl!);
                        },
                      ),
                    if (message.files![0].type == FileType.video)
                      GestureDetector(
                        onTap: () => showDialog(
                          context: context,
                          builder: (dialogContext) => AlertDialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(0),
                            ),
                            contentPadding: EdgeInsets.zero,
                            insetPadding: EdgeInsets.zero,
                            content: Video(url: message.files![0].dlUrl!),
                            alignment: Alignment.bottomCenter,
                            actionsAlignment: MainAxisAlignment.spaceBetween,
                            actionsPadding: const EdgeInsets.only(
                              top: Spacing.large,
                            ),
                            actions: [
                              IconButton(
                                onPressed: () {
                                  downloadFile(message.files![0]);
                                },
                                icon: const SvgAsset(
                                    AssetPathConstants.downloadPath),
                              ),
                              IconButton(
                                  onPressed: () => Navigator.pop(dialogContext),
                                  icon: const Icon(Icons.arrow_forward_ios))
                            ],
                          ),
                        ),
                        child: const Icon(Icons.video_camera_front_sharp),
                      ),
                    VerticalGap.xSmall(),
                    SizedBox(
                      width: 100,
                      child: Text(
                        message.files![0].name,
                        style: textTheme.bodySmall,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      message.files![0].extension.toUpperCase(),
                      style: textTheme.bodySmall,
                    ),
                  ],
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
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class Video extends StatefulWidget {
  const Video({
    super.key,
    required this.url,
  });

  final String url;

  @override
  VideoState createState() => VideoState();
}

class VideoState extends State<Video> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.networkUrl(
      Uri.parse(widget.url),
      videoPlayerOptions: VideoPlayerOptions(),
    )..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: _controller.value.isInitialized
          ? AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: Stack(
                children: [
                  VideoPlayer(_controller),
                  Center(
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black.withOpacity(0.5),
                      ),
                      child: IconButton(
                        color: Colors.white,
                        icon: Icon(
                          _controller.value.isPlaying
                              ? Icons.pause
                              : Icons.play_arrow,
                        ),
                        onPressed: () {
                          setState(() {
                            if (_controller.value.isPlaying) {
                              _controller.pause();
                            } else {
                              _controller.play();
                            }
                          });
                        },
                      ),
                    ),
                  ),

                ],
              ),
            )
          : const CenteredCircularProgressIndicator(),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
