import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:files/src/l10n/files_localizations.dart';
import 'package:files/src/files_cubit.dart';

class FilesList extends StatelessWidget {
  const FilesList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilesCubit, FilesState>(
      builder: (context, state) {
        final files = state.files;
        final cubit = context.read<FilesCubit>();
        final l10n = FilesLocalizations.of(context);
        final theme = GrowthInTheme.of(context);
        return state.files == null
            ? const CenteredCircularProgressIndicator()
            : RefreshIndicator(
                onRefresh: () async {
                  context.read<FilesCubit>().getFiles();
                },
                child: files?.isEmpty == true
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
                          childAspectRatio: 1.4,
                        ),
                        itemCount: files!.length,
                        padding: EdgeInsets.symmetric(
                          vertical: Spacing.medium,
                          horizontal: theme.screenMargin,
                        ),
                        itemBuilder: (context, index) {
                          final file = files[index];
                          return FileCard(
                            file: file,
                            onFileTapped: (file) => cubit.onFileTapped(file),
                            downloadFiles: cubit.downloadFiles,
                          );
                        },
                      ),
              );
      },
    );
  }
}
