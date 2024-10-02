import 'package:action_steps/src/l10n/action_steps_localizations.dart';
import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:action_steps/src/action_steps_cubit.dart';
import 'package:function_and_extension_library/function_and_extension_library.dart';
import 'package:request_repository/request_repository.dart';

class ActionStepsScreen extends StatelessWidget {
  const ActionStepsScreen({
    super.key,
    required this.requestRepository,
    required this.onBackTapped,
    required this.actionId,
  });

  final RequestRepository requestRepository;
  final VoidCallback onBackTapped;
  final int actionId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ActionStepsCubit>(
      create: (_) =>
          ActionStepsCubit(
            requestRepository: requestRepository,
            actionId: actionId,
          ),
      child: ActionStepsView(onBackTapped: onBackTapped),
    );
  }
}

class ActionStepsView extends StatelessWidget {
  const ActionStepsView({
    super.key,
    required this.onBackTapped,
  });

  final VoidCallback onBackTapped;

  @override
  Widget build(BuildContext context) {
    // final isTablet = !View.of(context).isSmallTabletOrLess;

    return BlocBuilder<ActionStepsCubit, ActionStepsState>(
      builder: (context, state) {
        final l10n = ActionStepsLocalizations.of(context);
        final textTheme = Theme
            .of(context)
            .textTheme;
        final theme = GrowthInTheme.of(context);
        final cubit = context.read<ActionStepsCubit>();
        final action = state.action;
        final loadingComments =
            state.commentsFetchStatus == CommentsFetchStatus.loading;
        return GestureDetector(
          onTap: context.releaseFocus,
          child: Scaffold(
            appBar: GrowthInAppBar(
                logoVariation: false,
                title: l10n.appBarTitle,
                onBackTapped: onBackTapped),
            body: loadingComments
                ? const CenteredCircularProgressIndicator()
                : ListView(
              children: [
                Padding(
                  padding:
                  EdgeInsets.symmetric(horizontal: theme.screenMargin),
                  child: Text(
                    l10n.detailsSectionTitle,
                    style: textTheme.titleMedium,
                  ),
                ),
                VerticalGap.small(),
                Padding(
                  padding:
                  EdgeInsets.symmetric(horizontal: theme.screenMargin),
                  child: Text(
                    action.steps[0].description,
                    style: textTheme.bodyMedium
                        ?.copyWith(color: Color(0xFF636262)),
                  ),
                ),
                VerticalGap.medium(),
                Padding(
                  padding:
                  EdgeInsets.symmetric(horizontal: theme.screenMargin),
                  child: Row(
                    children: [
                      Text(
                        l10n.stepsSectionTitle,
                        style: textTheme.titleMedium,
                      ),
                      HorizontalGap.small(),
                      Text(
                        '(${action.completeStepsCount}/${action.steps.length})',
                        style: textTheme.titleMedium
                            ?.copyWith(color: Color(0xFF636262)),
                      ),
                      Spacer(),
                      MarkAsCompleteToggler(
                        isComplete: action.isComplete,
                        isLoading: state.toggleStepsCompleteStatus ==
                            ToggleStepsCompleteStatus.loading,
                        onPressed: cubit.onToggleStepsCompleteTapped,
                      ),
                    ],
                  ),
                ),
                VerticalGap.small(),
                ColumnBuilder(
                  itemBuilder: (context, index) {
                    final step = action.steps[index];
                    return ListTile(
                      visualDensity: VisualDensity.compact,
                      dense: true,
                      contentPadding: EdgeInsets.zero,
                      enabled: state.toggleSingleStepCompleteStatus !=
                          ToggleSingleStepCompleteStatus.loading &&
                          state.toggleStepsCompleteStatus !=
                              ToggleStepsCompleteStatus.loading,
                      onTap: () =>
                          cubit.toggleSingleActionStepComplete(step.id),
                      leading: SizedBox(
                        width: 50,
                        height: 50,
                        child: state.toggleSingleStepCompleteStatus ==
                            ToggleSingleStepCompleteStatus
                                .loading &&
                            step.id == state.stepId
                            ? Transform.scale(
                          scale: 0.5,
                          child:
                          const CenteredCircularProgressIndicator(),
                        )
                            : Checkbox(
                          value: step.isComplete,
                          onChanged: (_) {
                            cubit.toggleSingleActionStepComplete(
                                step.id);
                          },
                        ),
                      ),
                      title: Text(
                        step.description,
                        style: textTheme.bodyMedium
                            ?.copyWith(color: Color(0xFF454444)),
                      ),
                    );
                  },
                  itemCount: action.steps.length,
                ),
                if (state.comments.isNotEmpty)
                  Comments(
                    comments: state.comments,
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
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsetsDirectional.only(
                          start: theme.screenMargin,
                        ),
                        child: TextField(
                          decoration: InputDecoration(
                            isDense: true,
                            contentPadding:EdgeInsets.symmetric(horizontal:Spacing.large, vertical: Spacing.xSmall),
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
                    IconButton(
                      icon: Icon(
                        Icons.send,
                        color: theme.primaryColor,
                      ),
                      onPressed: (){},
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
