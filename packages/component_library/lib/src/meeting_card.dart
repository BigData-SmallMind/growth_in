import 'package:domain_models/domain_models.dart';
import 'package:intl/intl.dart';
import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';

class MeetingCard extends StatelessWidget {
  const MeetingCard({
    super.key,
    required this.meeting,
    required this.type,
    required this.onTap,
  });

  final Meeting meeting;
  final MeetingCardVariation type;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = GrowthInTheme.of(context);
    final textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: type == MeetingCardVariation.past ? null : 130,
        padding: EdgeInsets.only(
          top: Spacing.medium,
          bottom: type == MeetingCardVariation.past ||
                  (meeting.isToday && !meeting.hasStarted)
              ? Spacing.medium
              : 0,
        ),
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: theme.borderColor,
          ),
          color: type == MeetingCardVariation.upcoming ||
                  type == MeetingCardVariation.past
              ? const Color(0xFFEFFFEF)
              : null,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: Spacing.medium),
              child: Text(
                meeting.type,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: textTheme.labelMedium?.copyWith(
                  color: const Color(0xFF797979),
                ),
              ),
            ),
            VerticalGap.small(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: Spacing.medium),
              child: Text(
                meeting.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style:
                    textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),

            if (type == MeetingCardVariation.upcoming ||
                type == MeetingCardVariation.past) ...[
              VerticalGap.medium(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: Spacing.medium),
                child: Text(DateFormat('EEEE, yyyy-MM-dd – hh:mm a')
                    .format(meeting.startDate!)),
              ),
            ],
            if (type == MeetingCardVariation.upcoming &&
                (meeting.isToday && !meeting.hasStarted)) ...[
              VerticalGap.medium(),
              Expanded(
                child: Container(
                  color: theme.tertiaryColor,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.access_time_outlined,
                        color: theme.materialThemeData.colorScheme.surface,
                      ),
                      HorizontalGap.small(),
                      Text(
                        'hr',
                        style: textTheme.labelMedium?.copyWith(
                          color: theme.materialThemeData.colorScheme.surface,
                        ),
                      ),
                      HorizontalGap.small(),
                      Text(
                        meeting.hoursTillStart.toString(),
                        style: textTheme.labelMedium?.copyWith(
                          color: theme.materialThemeData.colorScheme.surface,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
            if (type == MeetingCardVariation.awaitingAction) ...[
              VerticalGap.xLarge(),
              const Divider(),
              const MeetingButtons(),
              Container(
                decoration: const BoxDecoration(color: Color(0xFF26BFBF)),
                height: 5,
              )
            ],
          ],
        ),
      ),
    );
  }
}

