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
      child: ActionCommentsView(),
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
        return GestureDetector(
          onTap: context.releaseFocus,
          child: Scaffold(
            appBar: GrowthInAppBar(
              logoVariation: false,
              title: l10n.appBarTitle,
            ),
            body: ListView(
              children: [
                if (state.comments.isNotEmpty)
                  Comments(
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

class AddComment extends StatelessWidget {
  const AddComment({
    super.key,
    required this.enabled,
    required this.onCommentChanged,
    required this.onSubmit,
    required this.isLoading,
    required this.controller,
  });

  final bool enabled;
  final ValueChanged<String> onCommentChanged;
  final VoidCallback onSubmit;
  final bool isLoading;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    final theme = GrowthInTheme.of(context);
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: EdgeInsetsDirectional.only(
              start: theme.screenMargin,
            ),
            child: TextFormField(
              controller: controller,
              onChanged: onCommentChanged,
              decoration: InputDecoration(
                isDense: true,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: Spacing.large,
                  vertical: Spacing.xSmall,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(
                    color: theme.borderColor,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          width: 50,
          height: 50,
          child: IconButton(
            icon: isLoading
                ? Transform.scale(
                    scale: 0.5,
                    child: const CenteredCircularProgressIndicator(),
                  )
                : Icon(
                    Icons.send,
                    color: !enabled ? Colors.grey : theme.primaryColor,
                  ),
            onPressed: enabled ? onSubmit : null,
          ),
        ),
      ],
    );
  }
}
