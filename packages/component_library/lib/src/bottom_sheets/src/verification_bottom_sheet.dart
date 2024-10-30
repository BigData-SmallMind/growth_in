import 'package:component_library/component_library.dart';

import 'package:flutter/material.dart';

class VerificationBottomSheet extends StatelessWidget {
  const VerificationBottomSheet({
    super.key,
    required this.onTap,
    required this.asset,
    required this.title,
    required this.body,
    required this.buttonLabel,
    required this.buttonColor,
    this.cancelButtonLabel,
  });

  final VoidCallback onTap;
  final SvgAsset asset;
  final String title;
  final String body;
  final String buttonLabel;
  final String? cancelButtonLabel;
  final Color buttonColor;

  @override
  Widget build(BuildContext context) {
    final theme = GrowthInTheme.of(context);
    final textTheme = Theme.of(context).textTheme;
    final l10n = ComponentLibraryLocalizations.of(context);
    bool submissionInProgress = false;

    return StatefulBuilder(builder: (context, state) {
      return BottomSheet(
          onClosing: () {},
          builder: (context) {
            return Padding(
              padding: EdgeInsets.all(theme.screenMargin),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  asset,
                  VerticalGap.medium(),
                  Text(
                    title,
                    style: textTheme.titleMedium,
                  ),
                  VerticalGap.medium(),
                  Text(
                    body,
                    style: textTheme.bodyMedium,
                  ),
                  VerticalGap.medium(),
                  submissionInProgress == true
                      ? GrowthInElevatedButton.inProgress(
                          label: buttonLabel,
                          height: 45,
                        )
                      : GrowthInElevatedButton(
                          label: buttonLabel,
                          onTap: () {
                            submissionInProgress = true;
                            state(() {});
                            onTap();
                          },
                          height: 45,
                          bgColor: buttonColor,
                        ),
                  VerticalGap.medium(),
                  GrowthInElevatedButton(
                    label: cancelButtonLabel ?? l10n.cancelButtonLabel,
                    onTap: submissionInProgress == true
                        ? null
                        : () => Navigator.of(context).pop(),
                    height: 45,
                    bgColor: theme.materialThemeData.colorScheme.surface,
                    labelColor: buttonColor,
                    borderColor: buttonColor,
                  )
                ],
              ),
            );
          });
    });
  }
}
