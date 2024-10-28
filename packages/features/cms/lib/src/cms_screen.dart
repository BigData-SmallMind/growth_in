import 'package:cms_repository/cms_repository.dart';
import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cms/src/l10n/cms_localizations.dart';
import 'package:cms/src/cms_cubit.dart';
import 'package:user_repository/user_repository.dart';

class CmsScreen extends StatelessWidget {
  const CmsScreen({
    super.key,
    required this.userRepository,
    required this.cmsRepository,
    required this.navigateToFiles,
  });

  final UserRepository userRepository;
  final CmsRepository cmsRepository;
  final ValueSetter<int> navigateToFiles;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CmsCubit>(
      create: (_) => CmsCubit(
        userRepository: userRepository,
        cmsRepository: cmsRepository,
        navigateToPostDetails: navigateToFiles,
      ),
      child: const CmsView(),
    );
  }
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
    return BlocBuilder<CmsCubit, CmsState>(
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
                      Center(
                        child: Text('taqweem'),
                      ),
                      Center(
                        child: Text('time line'),
                      ),
                      Center(
                        child: Text('campaigns'),
                      ),
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
