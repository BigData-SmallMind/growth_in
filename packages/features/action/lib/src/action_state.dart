part of 'action_cubit.dart';

class ActionState extends Equatable {
  const ActionState({
    this.request,
    this.comments = const [],
    this.commentsFetchStatus = CommentsFetchStatus.initial,
    this.actionId,
    this.toggleStepsCompleteStatus = ToggleStepsCompleteStatus.initial,
    this.toggleSingleStepCompleteStatus =
        ToggleSingleStepCompleteStatus.initial,
    this.stepId,
    this.addCommentStatus = AddCommentStatus.initial,
    this.comment,
  });

  final dm.Request? request;
  final List<dm.Comment> comments;
  final CommentsFetchStatus commentsFetchStatus;
  final int? actionId;
  final ToggleStepsCompleteStatus toggleStepsCompleteStatus;
  final ToggleSingleStepCompleteStatus toggleSingleStepCompleteStatus;
  final int? stepId;
  final AddCommentStatus addCommentStatus;
  final String? comment;

  dm.Action get action =>
      request!.actions.firstWhere((action) => action.id == actionId);

  ActionState copyWith({
    dm.Request? request,
    List<dm.Comment>? comments,
    CommentsFetchStatus? commentsFetchStatus,
    ToggleStepsCompleteStatus? toggleStepsCompleteStatus,
    ToggleSingleStepCompleteStatus? toggleSingleStepCompleteStatus,
    int? stepId,
    AddCommentStatus? addCommentStatus,
    String? comment,

  }) {
    return ActionState(
      request: request ?? this.request,
      comments: comments ?? this.comments,
      commentsFetchStatus: commentsFetchStatus ?? this.commentsFetchStatus,
      actionId: actionId,
      toggleStepsCompleteStatus:
          toggleStepsCompleteStatus ?? this.toggleStepsCompleteStatus,
      toggleSingleStepCompleteStatus:
          toggleSingleStepCompleteStatus ?? this.toggleSingleStepCompleteStatus,
      stepId: stepId ?? this.stepId,
      addCommentStatus: addCommentStatus ?? this.addCommentStatus,
      comment: comment ?? this.comment,
    );
  }

  @override
  List<Object?> get props => [
        request,
        comments,
        commentsFetchStatus,
        actionId,
        toggleStepsCompleteStatus,
        toggleSingleStepCompleteStatus,
        stepId,
        addCommentStatus,
        comment,
      ];
}

enum CommentsFetchStatus {
  initial,
  loading,
  success,
  failure,
}

enum ToggleStepsCompleteStatus {
  initial,
  loading,
  success,
  error,
}

enum ToggleSingleStepCompleteStatus {
  initial,
  loading,
  success,
  error,
}

enum AddCommentStatus {
  initial,
  loading,
  success,
  error,
}
