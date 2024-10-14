import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';

class MeetingButtons extends StatelessWidget {
  const MeetingButtons({
    super.key,
    this.flex = 1,
    required this.onCancelTapped,
    required this.onScheduleTapped,
  });
  final int flex;
  final VoidCallback onCancelTapped;
  final VoidCallback onScheduleTapped;
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final l10n = ComponentLibraryLocalizations.of(context);
    final theme = GrowthInTheme.of(context);
    return Expanded(
      child: Row(
        children: [
          Expanded(
            child: InkWell(
              onTap: onCancelTapped,
              child: Container(
                constraints: const BoxConstraints.expand(),

                padding: const EdgeInsets.symmetric(
                  horizontal: Spacing.medium,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SvgAsset(AssetPathConstants.closeCirclePath),
                    HorizontalGap.medium(),
                    Text(
                      l10n.cancelMeetingButtonLabel,
                      maxLines: 1,
                      style: textTheme.labelLarge?.copyWith(
                        color: const Color(0xFFB22F2F),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: onScheduleTapped,
              child: Container(
                constraints: const BoxConstraints.expand(),
                padding: const EdgeInsets.symmetric(
                  horizontal: Spacing.medium,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SvgAsset(AssetPathConstants.tickCirclePath),
                    HorizontalGap.medium(),
                    Text(
                      l10n.setMeetingDateButtonLabel,
                      maxLines: 1,
                      style: textTheme.labelLarge?.copyWith(
                        color: theme.primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
