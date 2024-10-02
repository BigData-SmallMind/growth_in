import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';

class MarkAsCompleteToggler extends StatelessWidget {
  const MarkAsCompleteToggler({
    super.key,
    required this.isComplete,
    required this.isLoading,
    required this.onPressed,
  });

  final bool isComplete;
  final bool isLoading;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 60,
      height: 60,
      child: IconButton(
        icon: isLoading
            ? Transform.scale(
                scale: 0.5,
                child: const CenteredCircularProgressIndicator(),
              )
            : SvgAsset(
                isComplete
                    ? AssetPathConstants.markAsCompleteActivePath
                    : AssetPathConstants.markAsCompletePath,
                width: 40,
                height: 40,
              ),
        onPressed: onPressed,
      ),
    );
  }
}
