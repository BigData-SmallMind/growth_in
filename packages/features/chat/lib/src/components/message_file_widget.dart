import 'package:chat/src/components/image_widget.dart';
import 'package:chat/src/components/video.dart';
import 'package:component_library/component_library.dart';
import 'package:domain_models/domain_models.dart';
import 'package:flutter/material.dart';

class MessageFileWidget extends StatelessWidget {
  const MessageFileWidget({
    super.key,
    required this.message,
    // required this.downloadFile,
    required this.openDocument,
  });

  final ChatMessage message;
  // final Function(FileDM p1) downloadFile;
  final Function(String p1) openDocument;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        if (message.files![0].type == FileType.image)
          ImageWidget(
            message: message,
          ),
        if (message.files![0].type == FileType.document)
          IconButton(
            icon: const Icon(Icons.insert_drive_file),
            onPressed: () {
              openDocument(message.files![0].dlUrl!);
            },
          ),
        if (message.files![0].type == FileType.video)
          Video(
            message: message,
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
    );
  }
}
