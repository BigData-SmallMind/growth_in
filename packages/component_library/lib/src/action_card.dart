import 'package:component_library/component_library.dart';
import 'package:domain_models/domain_models.dart' as dm;
import 'package:flutter/material.dart';

class ActionCard extends StatelessWidget {
  const ActionCard({
    super.key,
    required this.index,
    required this.action,
  });

  final int index;
  final dm.Action action;

  @override
  Widget build(BuildContext context) {
    final theme = GrowthInTheme.of(context);
    final l10n = ComponentLibraryLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${l10n.actionTitle} ${index + 1}',
          style: textTheme.bodySmall?.copyWith(
            color: const Color(0xFFADADAD),
          ),
        ),
        VerticalGap.small(),
        Container(
          height: 60,
          width: MediaQuery.of(context).size.width - (2 * theme.screenMargin),
          padding: const EdgeInsets.all(Spacing.small),
          decoration: BoxDecoration(
            color: action.isComplete
                ? theme.primaryColor.withOpacity(0.1)
                : const Color(0xFFF7F8F9),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: action.isComplete ? theme.primaryColor : theme.borderColor,
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SvgAsset(AssetPathConstants.taskPath),
              HorizontalGap.small(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width -
                        (5 * theme.screenMargin),
                    child: Text(
                      action.description,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    '${l10n.percentActionsComplete} (${action.completeStepsCount}/${action.steps.length})',
                    style: textTheme.bodySmall?.copyWith(
                      color: const Color(0xFF797979),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
