import 'package:cms_repository/cms_repository.dart';
import 'package:post_comments/src/l10n/post_comments_localizations.dart';
import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:post_comments/src/post_comments_cubit.dart';
import 'package:function_and_extension_library/function_and_extension_library.dart';

class PostCommentsScreen extends StatelessWidget {
  const PostCommentsScreen({
    super.key,
    required this.cmsRepository,
    required this.postId,
  });

  final CmsRepository cmsRepository;
  final int postId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PostCommentsCubit>(
      create: (_) => PostCommentsCubit(
        cmsRepository: cmsRepository,
        postId: postId,
      ),
      child: const PostCommentsView(),
    );
  }
}

class PostCommentsView extends StatelessWidget {
  const PostCommentsView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // final isTablet = !View.of(context).isSmallTabletOrLess;

    return BlocBuilder<PostCommentsCubit, PostCommentsState>(
      builder: (context, state) {
        final l10n = PostCommentsLocalizations.of(context);
        final textTheme = Theme.of(context).textTheme;
        final cubit = context.read<PostCommentsCubit>();
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
                  onSubmit: () => cubit.addComment(),
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
