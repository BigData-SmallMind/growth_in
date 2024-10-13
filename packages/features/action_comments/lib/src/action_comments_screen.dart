import 'package:action_comments/src/l10n/action_comments_localizations.dart';
import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:action_comments/src/action_comments_cubit.dart';
import 'package:function_and_extension_library/function_and_extension_library.dart';
import 'package:request_repository/request_repository.dart';

class ActionCommentsScreen extends StatelessWidget {
  const ActionCommentsScreen({
    super.key,
    required this.requestRepository,
    required this.actionId,
  });

  final RequestRepository requestRepository;
  final int actionId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ActionCommentsCubit>(
      create: (_) => ActionCommentsCubit(
        requestRepository: requestRepository,
        actionId: actionId,
      ),
      child: const ActionCommentsView(),
    );
  }
}

class ActionCommentsView extends StatelessWidget {
  const ActionCommentsView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // final isTablet = !View.of(context).isSmallTabletOrLess;

    return BlocBuilder<ActionCommentsCubit, ActionCommentsState>(
      builder: (context, state) {
        final l10n = ActionCommentsLocalizations.of(context);
        final textTheme = Theme.of(context).textTheme;
        final cubit = context.read<ActionCommentsCubit>();
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
