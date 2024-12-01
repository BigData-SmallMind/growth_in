import 'package:chat/src/components/message_file_widget.dart';
import 'package:chat/src/l10n/chat_localizations.dart';
import 'package:component_library/component_library.dart';
import 'package:domain_models/domain_models.dart';
import 'package:flutter/material.dart';

class MessageRepliedToWidget extends StatelessWidget {
  const MessageRepliedToWidget({
    super.key,
    required this.messageRepliedTo,
  });

  final ChatMessage messageRepliedTo;

  @override
  Widget build(BuildContext context) {
    final isSentByMe = messageRepliedTo.isSentByMe;
    final l10n = ChatLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;
    final theme = GrowthInTheme.of(context);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color(0xFFF4F8F6),
      ),
      padding: const EdgeInsets.all(10),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            isSentByMe
                ? l10n.messageSentByMeCardTitle
                : messageRepliedTo.sender.name,
            style: textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.materialThemeData.colorScheme.secondary,
            ),
          ),
          VerticalGap.medium(),
          if (messageRepliedTo.text != null &&
              messageRepliedTo.text?.isNotEmpty == true) ...[
            SelectableText(
              messageRepliedTo.text!,
            ),
          ],
          if (messageRepliedTo.files?.isNotEmpty == true) ...[
            MessageFileWidget(
              message: messageRepliedTo,
              downloadFile: (_) {},
              openDocument: (_) {},
            ),
          ],
        ],
      ),
    );
  }
}
