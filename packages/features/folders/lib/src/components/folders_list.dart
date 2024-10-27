import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:folders/src/l10n/folders_localizations.dart';
import 'package:folders/src/folders_cubit.dart';

class FoldersList extends StatelessWidget {
  const FoldersList({
    super.key,
    required this.active,
  });

  final bool active;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FoldersCubit, FoldersState>(
      builder: (context, state) {
        final folders = active ? state.activeFolders : state.inActiveFolders;
        final cubit = context.read<FoldersCubit>();
        final l10n = FoldersLocalizations.of(context);
        return state.folders == null
            ? const CenteredCircularProgressIndicator()
            : RefreshIndicator(
                onRefresh: () async {
                  context.read<FoldersCubit>().getFolders();
                },
                child: folders.isEmpty
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
                        itemCount: folders.length,
                        padding: const EdgeInsets.symmetric(
                            vertical: Spacing.medium),
                        itemBuilder: (context, index) {
                          final folder = folders[index];
                          return FolderCard(
                            folder: folder,
                            onFolderTapped: (folder) =>
                                cubit.onFolderTapped(folder),
                          );
                        },
                      ),
              );
      },
    );
  }
}
