import 'package:meetings/src/l10n/meetings_localizations.dart';
import 'package:flutter/material.dart';

class MeetingSectionHeader extends StatelessWidget {
  const MeetingSectionHeader({
    super.key,
    required this.title,
    required this.onViewAll,
  });

  final String title;
  final VoidCallback onViewAll;

  @override
  Widget build(BuildContext context) {
    final l10n = MeetingsLocalizations.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context)
              .textTheme
              .titleSmall
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        TextButton(
          onPressed: onViewAll,
          child: Text(
            l10n.viewAllTextButtonLabel,
          ),
        ),
      ],
    );
  }
}
