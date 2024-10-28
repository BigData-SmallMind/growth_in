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
        return loading
            ? const CenteredCircularProgressIndicator()
            : RefreshIndicator(
                onRefresh: () async {
                  context.read<CmsCubit>().init();
                },
                child: state.campaigns!.isEmpty
                    ? Center(
                        child: Text(
                          l10n.emptyListIndicatorText,
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      )
                    : GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          // childAspectRatio: 1.5,
                        ),
                        itemCount: state.campaigns!.length,
                        padding: const EdgeInsets.symmetric(
                            vertical: Spacing.medium),
                        itemBuilder: (context, index) {
                          // final campaign = state.campaigns![index];/
                          return;
                          // return CampaignCard(
                          //   folder: campaign,
                          //   onFolderTapped: (folder) =>
                          //       cubit.onFolderTapped(folder),
                          // );
                        },
                      ),
              );
      },
    );
  }
}
