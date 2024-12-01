import 'package:component_library/component_library.dart';
import 'package:domain_models/domain_models.dart';
import 'package:flutter/material.dart';


class ImageWidget extends StatelessWidget {
  const ImageWidget({
    super.key,
    required this.message,
    required this.downloadFile,
  });

  final ChatMessage message;
  final Function(FileDM p1) downloadFile;

  @override
  Widget build(BuildContext context) {
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
              icon: const SvgAsset(AssetPathConstants.downloadPath),
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
    );
  }
}

