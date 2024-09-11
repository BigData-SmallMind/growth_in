import 'package:component_library/component_library.dart';
import 'package:domain_models/domain_models.dart';
import 'package:flutter/material.dart';

class CompanyTile extends StatelessWidget {
  const CompanyTile({
    super.key,
    required this.company,
    this.isLoading = false,
    this.onCompanySelected,
    this.onTap,
    this.isSubmissionInProgress = false,
    this.trailing,
  });

  final Company company;
  final bool isLoading;
  final bool isSubmissionInProgress;
  final void Function(Company)? onCompanySelected;
  final VoidCallback? onTap;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final theme = GrowthInTheme.of(context);
    //assert that either onCompanySelected or onTap is not null
    assert(onCompanySelected != null || onTap != null,
        'onCompanySelected or onTap must be provided');
    return ListTile(
      enabled: !isSubmissionInProgress,
      selected: company.isSelected,
      selectedTileColor: theme.tertiaryContainerBgColor,
      contentPadding: const EdgeInsets.symmetric(
          vertical: Spacing.small, horizontal: Spacing.medium),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 85),
                  child: Text(company.name)),
              HorizontalGap.medium(),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 150),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Spacing.small,
                    vertical: Spacing.xSmall,
                  ),
                  decoration: BoxDecoration(
                    color: theme.secondaryContainerBgColor,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    company.sector,
                    style: textTheme.bodySmall?.copyWith(
                      color: theme.dimmedTextColor,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
          if (company.email != null) ...[
            VerticalGap.small(),
            Text(
              company.email!,
              style: textTheme.bodySmall?.copyWith(
                color: theme.dimmedTextColor,
              ),
            ),
          ]
        ],
      ),
      leading: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: theme.primaryColor,
          shape: BoxShape.circle,
        ),
        child: company.profileImage != null
            ? Image.network(company.profileImage!)
            : Center(
                child: Text(
                  company.name[0],
                  style: textTheme.headlineMedium?.copyWith(
                    color: theme.materialThemeData.colorScheme.surface,
                  ),
                ),
              ),
      ),
      trailing: trailing ??
          (company.isSelected
              ? const Icon(Icons.radio_button_checked)
              : isLoading
                  ? Transform.scale(
                      scale: 0.5,
                      child: const CircularProgressIndicator(),
                    )
                  : null),
      onTap: onTap ?? () => onCompanySelected!(company),
    );
  }
}
