import 'package:component_library/component_library.dart';
import 'package:domain_models/domain_models.dart';
import 'package:flutter/material.dart';

class CampaignCard extends StatelessWidget {
  const CampaignCard({
    super.key,
    required this.campaign,
  });

  final Campaign campaign;

  @override
  Widget build(BuildContext context) {
    final theme = GrowthInTheme.of(context);
    final textTheme = Theme.of(context).textTheme;
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: Spacing.medium,
        horizontal: Spacing.medium,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: theme.borderColor),
        borderRadius: BorderRadius.circular(10),
        boxShadow: kElevationToShadow[2],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: isArabic ? const EdgeInsets.only(top: 4) : null,
                width: 10,
                height: 10,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFFEA2A2),
                ),
              ),
              HorizontalGap.small(),
              Text(
                campaign.name,
                style: textTheme.titleMedium,
              ),
            ],
          ),
          VerticalGap.medium(),
          Text(
            campaign.name,
            style: textTheme.bodyMedium?.copyWith(
              color: const Color(0xFF464646),
            ),
          ),
          VerticalGap.medium(),
          Row(
            children: [
              const SvgAsset(
                AssetPathConstants.stickyNotePath,
                color: Color(0xFF787486),
              ),
              HorizontalGap.small(),
              Text(
                campaign.postCount.toString(),
                style: textTheme.bodyMedium?.copyWith(
                  color: const Color(0xFF787486),
                ),
              ),
            ],
          ),
          VerticalGap.medium(),
          Text(
            campaign.summary ?? '',
            style: textTheme.bodyMedium?.copyWith(
              color: const Color(0xFF323232),
            ),
          )
        ],
      ),
    );
  }
}
