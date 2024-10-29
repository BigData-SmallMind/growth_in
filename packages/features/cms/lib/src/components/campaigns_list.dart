import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cms/src/l10n/cms_localizations.dart';
import 'package:cms/src/cms_cubit.dart';

class CampaignsList extends StatelessWidget {
  const CampaignsList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CmsCubit, CmsState>(
      builder: (context, state) {
        final l10n = CmsLocalizations.of(context);
        final loading =
            state.campaignsFetchingStatus == CampaignsFetchingStatus.inProgress;
        final error =
            state.campaignsFetchingStatus == CampaignsFetchingStatus.failure;
        final isEmptyList = state.campaigns?.isEmpty == true;
        final cubit = context.read<CmsCubit>();
        return loading
            ? const CenteredCircularProgressIndicator()
            : error
                ? ExceptionIndicator(
                    onTryAgain: cubit.getCampaigns,
                  )
                : isEmptyList
                    ? EmptyListIndicator(
                        onRefresh: cubit.getCampaigns,
                      )
                    : RefreshIndicator(
                        onRefresh: cubit.getCampaigns,
                        child: state.campaigns!.isEmpty
                            ? Center(
                                child: Text(
                                  l10n.emptyListIndicatorText,
                                  style:
                                      Theme.of(context).textTheme.headlineSmall,
                                ),
                              )
                            : ListView.separated(
                                itemCount: state.campaigns!.length,
                                padding: const EdgeInsets.symmetric(
                                  vertical: Spacing.medium,
                                ),
                                itemBuilder: (context, index) {
                                  final campaign = state.campaigns![index];
                                  return CampaignCard(
                                    campaign: campaign,
                                  );
                                },
                                separatorBuilder: (context, index) =>
                                    VerticalGap.medium(),
                              ),
                      );
      },
    );
  }
}
