import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:folders/src/l10n/folders_localizations.dart';

class NoFoldersIndicator extends StatelessWidget {
  const NoFoldersIndicator({
    super.key,
    required this.onTryAgain,
  });

  final VoidCallback onTryAgain;

  @override
  Widget build(BuildContext context) {
    final l10n = FoldersLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;
    final theme = GrowthInTheme.of(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: theme.screenMargin),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SvgAsset(AssetPathConstants.noTicketsPath),
          VerticalGap.xLarge(),
          Text(
            l10n.noFoldersMessageTitle,
            style: textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
          VerticalGap.medium(),
          Text(
            l10n.noFoldersMessageSubtitle,
            style: textTheme.bodyMedium?.copyWith(
              color: Colors.grey,
            ),
            textAlign: TextAlign.center,
          ),
          VerticalGap.medium(),
          GrowthInElevatedButton(
            height: 40,
            label: l10n.noFoldersButtonLabel,
            onTap: onTryAgain,
          ),
        ],
      ),
    );
  }
}
