import 'package:cms/src/components/campaigns_list.dart';
import 'package:cms/src/components/week_filtered_posts.dart';
import 'package:cms_repository/cms_repository.dart';
import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cms/src/l10n/cms_localizations.dart';
import 'package:cms/src/cms_cubit.dart';
import 'package:user_repository/user_repository.dart';

import 'components/components.dart';

class CmsScreen extends StatefulWidget {
  const CmsScreen({
    super.key,
    required this.userRepository,
    required this.cmsRepository,
    required this.navigateToPostDetails,
  });

  final UserRepository userRepository;
  final CmsRepository cmsRepository;
  final ValueSetter<int> navigateToPostDetails;

  @override
  State<CmsScreen> createState() => _CmsScreenState();
}

class _CmsScreenState extends State<CmsScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocProvider<CmsCubit>(
      create: (_) => CmsCubit(
        userRepository: widget.userRepository,
        cmsRepository: widget.cmsRepository,
        navigateToPostDetails: widget.navigateToPostDetails,
      ),
      child: const CmsView(),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class CmsView extends StatefulWidget {
  const CmsView({
    super.key,
  });

  @override
  State<CmsView> createState() => _CmsViewState();
}

class _CmsViewState extends State<CmsView> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CmsCubit, CmsState>(
      listener: (context, state) {
        if (state.postsFetchingStatus == PostsFetchingStatus.failure &&
            state.errorMessage != null) {
          showSnackBar(
            context: context,
            snackBar: ErrorSnackBar(
              context: context,
              message: state.errorMessage!,
            ),
          );
        }
        if (state.campaignsFetchingStatus == CampaignsFetchingStatus.failure &&
            state.errorMessage != null) {
          showSnackBar(
            context: context,
            snackBar: ErrorSnackBar(
              context: context,
              message: state.errorMessage!,
            ),
          );
        }
      },
      builder: (context, state) {
        final theme = GrowthInTheme.of(context);
        final l10n = CmsLocalizations.of(context);
        return Scaffold(
          appBar: AppBar(
            toolbarHeight: Spacing.xLarge,
            backgroundColor: Colors.white,
          ),
          body: Column(
            children: [
              GrowthInTabBar(
                tabAlignment: TabAlignment.center,
                isScrollable: true,
                tabController: _tabController,
                tabs: [
                  Tab(
                    text: l10n.calendarTabLabel,
                  ),
                  Tab(
                    text: l10n.timelineTabLabel,
                  ),
                  Tab(
                    text: l10n.campaignsTabLabel,
                  ),
                ],
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: theme.screenMargin,
                  ),
                  child: TabBarView(
                    controller: _tabController,
                    children: const [
                      DayFilteredPosts(),
                      WeekFilteredPosts(),
                      CampaignsList(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
