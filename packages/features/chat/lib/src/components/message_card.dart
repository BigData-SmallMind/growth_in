import 'package:chat/src/components/message_file_widget.dart';
import 'package:chat/src/components/message_replied_to_widget.dart';
import 'package:chat/src/l10n/chat_localizations.dart';
import 'package:component_library/component_library.dart';
import 'package:domain_models/domain_models.dart';
import 'package:flutter/material.dart';
import 'package:function_and_extension_library/function_and_extension_library.dart';

class MessageCard extends StatelessWidget {
  const MessageCard({
    super.key,
    required this.isSubmissionInProgress,
    required this.message,
    required this.isFirstElement,
    required this.openDocument,
    // required this.downloadFile,
    required this.selectMessageToReply,
    required this.isMessageBeingRepliedTo,
    required this.shouldShowDeleteIcon,
  });

  final bool isSubmissionInProgress;
  final ChatMessage message;
  final bool isFirstElement;
  final Function(String) openDocument;
  // final Function(FileDM) downloadFile;
  final Function(ChatMessage?) selectMessageToReply;
  final bool isMessageBeingRepliedTo;
  final bool shouldShowDeleteIcon;

  @override
  Widget build(BuildContext context) {
    final theme = GrowthInTheme.of(context);
    final textTheme = Theme.of(context).textTheme;
    final isSentByMe = message.isSentByMe;
    final l10n = ChatLocalizations.of(context);
    final hasMessageRepliedTo = message.messageRepliedTo != null;
    return GestureDetector(
      onLongPress: isMessageBeingRepliedTo == true
          ? null
          : () {
              selectMessageToReply(message);
            },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isFirstElement) VerticalGap.medium(),
          if (!isMessageBeingRepliedTo) ...[
            Row(
              children: [
                HorizontalGap.custom(theme.screenMargin * 2),
                Text(
                  isSentByMe
                      ? l10n.messageSentByMeCardTitle
                      : message.sender.name,
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
          ],
          Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.only(
              left: Spacing.medium,
              right: Spacing.medium,
              top: Spacing.small,
              bottom: Spacing.xSmall,
            ),
            margin: isMessageBeingRepliedTo
                ? null
                : EdgeInsetsDirectional.only(
                    bottom: Spacing.medium,
                    end: isSentByMe
                        ? theme.screenMargin
                        : theme.screenMargin * 2,
                    start: isSentByMe
                        ? theme.screenMargin * 2
                        : theme.screenMargin,
                  ),
            decoration: BoxDecoration(
              border: Border.all(color: theme.borderColor),
              borderRadius:
                  isMessageBeingRepliedTo ? null : BorderRadius.circular(10),
              color: isMessageBeingRepliedTo
                  ? const Color(0xFFFFFFFF)
                  : isSentByMe
                      ? const Color(0xFFEFEFEF)
                      : theme.secondaryColor,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (hasMessageRepliedTo) ...[
                        MessageRepliedToWidget(
                          messageRepliedTo: message.messageRepliedTo!,
                        ),
                        VerticalGap.medium(),
                      ],
                      if (message.text != null &&
                          message.text?.isNotEmpty == true) ...[
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
                        MessageFileWidget(
                          message: message,
                          // downloadFile: downloadFile,
                          openDocument: openDocument,
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
                if (shouldShowDeleteIcon)
                  IconButton(
                    icon: const Icon(Icons.cancel_outlined),
                    onPressed: () => selectMessageToReply(null),
                    iconSize: 30,
                  )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
