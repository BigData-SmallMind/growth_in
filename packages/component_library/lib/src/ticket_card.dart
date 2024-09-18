import 'package:component_library/component_library.dart';
import 'package:domain_models/domain_models.dart';
import 'package:flutter/material.dart';

class TicketCard extends StatelessWidget {
  const TicketCard({
    super.key,
    required this.ticket,
    this.isFirstElement = false,
    this.onTicketTapped,
    this.margin,
  });

  final Ticket ticket;
  final bool isFirstElement;
  final ValueSetter<Ticket>? onTicketTapped;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    final theme = GrowthInTheme.of(context);
    final textTheme = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: () {
        if (onTicketTapped != null) {
          onTicketTapped!(ticket);
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: Spacing.medium,
          horizontal: Spacing.small,
        ),
        margin: margin ??
            EdgeInsets.only(
              top: isFirstElement ? Spacing.medium : 0,
            ),
        decoration: BoxDecoration(
          border: Border.all(color: theme.borderColor),
          borderRadius: BorderRadius.circular(10),
        ),
        height: 140,
        child: Column(
          children: [
            Row(
              children: [
                if (ticket.subject != null)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: Spacing.xSmall,
                      horizontal: Spacing.small,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFFAEB),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      ticket.subject!,
                      style: textTheme.bodySmall?.copyWith(
                        color: const Color(0xFFCA7C4B),
                      ),
                    ),
                  ),
                const Spacer(),
                Text(
                  '${ticket.createdAt.hour}:${ticket.createdAt.minute}',
                  style: textTheme.bodySmall?.copyWith(
                    color: const Color(0xFF797979),
                  ),
                ),
              ],
            ),
            VerticalGap.small(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 40,
                  width: 40,
                  decoration: const BoxDecoration(
                      color: Color(0xFFF2F2F2), shape: BoxShape.circle),
                  child: const SvgAsset(AssetPathConstants.receiptPath),
                ),
                HorizontalGap.small(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${ticket.id} #',
                      style: textTheme.titleSmall,
                      textDirection: TextDirection.ltr,
                    ),
                    VerticalGap.xSmall(),
                    Text(
                      ticket.title,
                      style: textTheme.bodySmall,
                    ),
                  ],
                ),
                const Spacer(),
                const Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Color(0xFF8D9695),
                  size: 20,
                ),
              ],
            ),
            const Divider(
              height: Spacing.large,
            ),
            Row(
              children: [
                const SvgAsset(AssetPathConstants.clockPath),
                HorizontalGap.small(),
                Text(
                    '${ticket.createdAt.day}/${ticket.createdAt.month}/${ticket.createdAt.year}',
                    style: textTheme.bodySmall?.copyWith(
                      color: const Color(0xFF797979),
                    )),
                HorizontalGap.small(),
                Text('-${ticket.createdAt.hour}:${ticket.createdAt.minute}',
                    style: textTheme.bodySmall?.copyWith(
                      color: const Color(0xFF797979),
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
