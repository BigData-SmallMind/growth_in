import 'package:file_comments/src/l10n/file_comments_localizations.dart';
import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:file_comments/src/file_comments_cubit.dart';
import 'package:folder_repository/folder_repository.dart';
import 'package:function_and_extension_library/function_and_extension_library.dart';

class FileCommentsScreen extends StatelessWidget {
  const FileCommentsScreen({
    super.key,
    required this.folderRepository,
    required this.fileId,
  });

  final FolderRepository folderRepository;
  final int fileId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<FileCommentsCubit>(
      create: (_) => FileCommentsCubit(
        folderRepository: folderRepository,
        fileId: fileId,
      ),
      child: const FileCommentsView(),
    );
  }
}

class FileCommentsView extends StatelessWidget {
  const FileCommentsView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // final isTablet = !View.of(context).isSmallTabletOrLess;

    return BlocBuilder<FileCommentsCubit, FileCommentsState>(
      builder: (context, state) {
        final l10n = FileCommentsLocalizations.of(context);
        final textTheme = Theme.of(context).textTheme;
        final cubit = context.read<FileCommentsCubit>();
        final loadingComments =
            state.commentsFetchStatus == CommentsFetchStatus.loading;
        return GestureDetector(
          onTap: context.releaseFocus,
          child: Scaffold(
            appBar: GrowthInAppBar(
              logoVariation: false,
              title: Text(l10n.appBarTitle),
            ),
            body: Column(
              children: [
                Expanded(
                  child: loadingComments
                      ? const CenteredCircularProgressIndicator()
                      : ListView(
                          shrinkWrap: true,
                          children: [
                            if (state.comments.isNotEmpty)
                              Comments(
                                onViewAllTapped: () {},
                                comments: state.comments,
                                shouldShowAll: true,
                              ),
                            if (state.comments.isEmpty)
                              Center(
                                child: SizedBox(
                                  width: 100,
                                  height: 100,
                                  child: Text(
                                    l10n.noCommentsIndicatorText,
                                    style: textTheme.titleLarge,
                                  ),
                                ),
                              ),
                          ],
                        ),
                ),
                AddComment(
                  enabled: state.comment?.isNotEmpty == true,
                  onCommentChanged: cubit.onCommentChanged,
                  onSubmit: cubit.addComment,
                  isLoading: state.addCommentStatus == AddCommentStatus.loading,
                  controller: cubit.commentController,
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
