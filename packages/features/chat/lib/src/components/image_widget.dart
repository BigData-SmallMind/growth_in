import 'package:component_library/component_library.dart';
import 'package:domain_models/domain_models.dart';
import 'package:flutter/material.dart';

class ImageWidget extends StatefulWidget {
  const ImageWidget({
    super.key,
    required this.message,
  });

  final ChatMessage message;

  @override
  State<ImageWidget> createState() => _ImageWidgetState();
}

class _ImageWidgetState extends State<ImageWidget> {
  @override
  Widget build(BuildContext context) {
    final theme = GrowthInTheme.of(context);
    return GestureDetector(
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
              widget.message.files![0].dlUrl!,
              fit: BoxFit.fitHeight,
            ),
          ),
          alignment: Alignment.bottomCenter,
          actionsAlignment: MainAxisAlignment.spaceBetween,
          actionsPadding:  EdgeInsetsDirectional.only(
            top: Spacing.large,
            start: theme.screenMargin
          ),
          actions: [
            DownloadWidget(urls: [widget.message.files![0].dlUrl!]),
            // CircularProgressIndicator(),
            IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_forward_ios))
          ],
        ),
      ),
      child: Image.network(
        widget.message.files![0].dlUrl!,
        fit: BoxFit.fitHeight,
        height: 100,
      ),
    );
  }
}

