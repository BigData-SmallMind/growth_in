import 'package:request_comments/src/l10n/request_comments_localizations.dart';
import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:request_comments/src/request_comments_cubit.dart';
import 'package:function_and_extension_library/function_and_extension_library.dart';
import 'package:request_repository/request_repository.dart';

class RequestCommentsScreen extends StatelessWidget {
  const RequestCommentsScreen({
    super.key,
    required this.requestRepository,
    required this.requestId,
  });

  final RequestRepository requestRepository;
  final int requestId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RequestCommentsCubit>(
      create: (_) => RequestCommentsCubit(
        requestRepository: requestRepository,
        requestId: requestId,
      ),
      child: RequestCommentsView(),
    );
  }
}

class RequestCommentsView extends StatelessWidget {
  const RequestCommentsView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // final isTablet = !View.of(context).isSmallTabletOrLess;

    return BlocBuilder<RequestCommentsCubit, RequestCommentsState>(
      builder: (context, state) {
        final l10n = RequestCommentsLocalizations.of(context);
        final textTheme = Theme.of(context).textTheme;
        final cubit = context.read<RequestCommentsCubit>();
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
