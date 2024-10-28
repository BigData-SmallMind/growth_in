import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:folder_repository/folder_repository.dart';
import 'package:cms/src/l10n/cms_localizations.dart';
import 'package:cms/src/cms_cubit.dart';
import 'package:user_repository/user_repository.dart';

import 'components/components.dart';

class CmsScreen extends StatelessWidget {
  const CmsScreen({
    super.key,
    required this.userRepository,
    required this.folderRepository,
    required this.navigateToFiles,
  });

  final UserRepository userRepository;
  final FolderRepository folderRepository;
  final ValueSetter<int> navigateToFiles;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CmsCubit>(
      create: (_) => CmsCubit(
        userRepository: userRepository,
        folderRepository: folderRepository,
        navigateToFiles: navigateToFiles,
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

class _CmsViewState extends State<CmsView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
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
            title: Text(l10n.appBarTitle),
            centerTitle: false,
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
          ),
          body: state.cms?.active.isEmpty == true &&
                  state.cms?.inactive.isEmpty == true
              ? const NoCmsIndicator()
              : Column(
                  children: [
                    GrowthInTabBar(
                      tabController: _tabController,
                      tabs: [
                        Tab(
                          text: l10n.activeCmsTabLabel,
                        ),
                        Tab(
                          text: l10n.inActiveCmsTabLabel,
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
                            CmsList(active: true),
                            CmsList(active: false),
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
