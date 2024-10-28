import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:folder_repository/folder_repository.dart';
import 'package:files/src/l10n/files_localizations.dart';
import 'package:files/src/files_cubit.dart';
import 'package:user_repository/user_repository.dart';

import 'components/components.dart';

class FilesScreen extends StatelessWidget {
  const FilesScreen({
    super.key,
    required this.userRepository,
    required this.folderRepository,
    required this.folderId,
    required this.navigateToFile,
  });

  final UserRepository userRepository;
  final FolderRepository folderRepository;
  final int folderId;
  final ValueSetter<int> navigateToFile;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<FilesCubit>(
      create: (_) => FilesCubit(
        userRepository: userRepository,
        folderRepository: folderRepository,
        folderId: folderId,
        navigateToFile: navigateToFile,

      ),
      child: const FilesView(),
    );
  }
}

class FilesView extends StatefulWidget {
  const FilesView({
    super.key,
  });

  @override
  State<FilesView> createState() => _FilesViewState();
}

class _FilesViewState extends State<FilesView>
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
    return BlocBuilder<FilesCubit, FilesState>(
      builder: (context, state) {
        final l10n = FilesLocalizations.of(context);
        final error = state.fetchingStatus == FilesFetchingStatus.failure;
        return Scaffold(
          appBar: GrowthInAppBar(
            logoVariation: false,
            title: Text(l10n.appBarTitle),

          ),
          body: error
              ? ExceptionIndicator(
                  onTryAgain: () {
                    context.read<FilesCubit>().getFiles();
                  },
                )
              : const FilesList(),
        );
      },
    );
  }
}
