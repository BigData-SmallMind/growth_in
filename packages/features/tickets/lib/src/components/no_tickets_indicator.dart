import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:tickets/src/l10n/tickets_localizations.dart';




class NoTicketsIndicator extends StatelessWidget {
  const NoTicketsIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = TicketsLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;
    final theme = GrowthInTheme.of(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: theme.screenMargin),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgAsset(AssetPathConstants.noTicketsPath),
          VerticalGap.xLarge(),
          Text(
            l10n.noTicketsMessageTitle,
            style: textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
          VerticalGap.medium(),
          Text(
            l10n.noTicketsMessageSubtitle,
            style: textTheme.bodyMedium?.copyWith(
              color: Colors.grey,
            ),
            textAlign: TextAlign.center,
          ),
          VerticalGap.medium(),
          GrowthInElevatedButton(
            height: 40,
            label: l10n.noTicketsButtonLabel,
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

