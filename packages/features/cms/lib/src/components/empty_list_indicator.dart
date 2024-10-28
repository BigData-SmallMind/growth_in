import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:cms/src/l10n/cms_localizations.dart';




class NoCmsIndicator extends StatelessWidget {
  const NoCmsIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = CmsLocalizations.of(context);
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
            l10n.noCmsMessageTitle,
            style: textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
          VerticalGap.medium(),
          Text(
            l10n.noCmsMessageSubtitle,
            style: textTheme.bodyMedium?.copyWith(
              color: Colors.grey,
            ),
            textAlign: TextAlign.center,
          ),
          VerticalGap.medium(),
          GrowthInElevatedButton(
            height: 40,
            label: l10n.noCmsButtonLabel,
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

