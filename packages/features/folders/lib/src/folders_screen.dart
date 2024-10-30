import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:folder_repository/folder_repository.dart';
import 'package:folders/src/l10n/folders_localizations.dart';
import 'package:folders/src/folders_cubit.dart';
import 'package:user_repository/user_repository.dart';

import 'components/components.dart';

class FoldersScreen extends StatefulWidget {
  const FoldersScreen({
    super.key,
    required this.userRepository,
    required this.folderRepository,
    required this.navigateToFiles,
  });

  final UserRepository userRepository;
  final FolderRepository folderRepository;
  final ValueSetter<int> navigateToFiles;

  @override
  State<FoldersScreen> createState() => _FoldersScreenState();
}

class _FoldersScreenState extends State<FoldersScreen> with AutomaticKeepAliveClientMixin{
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocProvider<FoldersCubit>(
      create: (_) => FoldersCubit(
        userRepository: widget.userRepository,
        folderRepository: widget.folderRepository,
        navigateToFiles: widget.navigateToFiles,
      ),
      child: const FoldersView(),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class FoldersView extends StatefulWidget {
  const FoldersView({
    super.key,
  });

  @override
  State<FoldersView> createState() => _FoldersViewState();
}

class _FoldersViewState extends State<FoldersView>
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
    return BlocBuilder<FoldersCubit, FoldersState>(
      builder: (context, state) {
        final theme = GrowthInTheme.of(context);
        final l10n = FoldersLocalizations.of(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(l10n.appBarTitle),
            centerTitle: false,
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
          ),
          body: state.folders?.active.isEmpty == true &&
                  state.folders?.inactive.isEmpty == true
              ? const NoFoldersIndicator()
              : Column(
                  children: [
                    GrowthInTabBar(
                      tabController: _tabController,
                      tabs: [
                        Tab(
                          text: l10n.activeFoldersTabLabel,
                        ),
                        Tab(
                          text: l10n.inActiveFoldersTabLabel,
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
                            FoldersList(active: true),
                            FoldersList(active: false),
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
