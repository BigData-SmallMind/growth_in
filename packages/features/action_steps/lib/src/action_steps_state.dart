part of 'action_steps_cubit.dart';

class ActionStepsState extends Equatable {
  const ActionStepsState({
    this.request,
    this.comments = const [],
    this.commentsFetchStatus = CommentsFetchStatus.initial,
    this.actionId,
    this.toggleStepsCompleteStatus = ToggleStepsCompleteStatus.initial,
    this.toggleSingleStepCompleteStatus =
        ToggleSingleStepCompleteStatus.initial,
    this.stepId,
    this.addCommentStatus = AddCommentStatus.initial,
  });

  final Request? request;
  final List<Comment> comments;
  final CommentsFetchStatus commentsFetchStatus;
  final int? actionId;
  final ToggleStepsCompleteStatus toggleStepsCompleteStatus;
  final ToggleSingleStepCompleteStatus toggleSingleStepCompleteStatus;
  final int? stepId;
  final AddCommentStatus addCommentStatus;

  Action get action =>
      request!.actions.firstWhere((action) => action.id == actionId);

  ActionStepsState copyWith({
    Request? request,
    List<Comment>? comments,
    CommentsFetchStatus? commentsFetchStatus,
    ToggleStepsCompleteStatus? toggleStepsCompleteStatus,
    ToggleSingleStepCompleteStatus? toggleSingleStepCompleteStatus,
    int? stepId,
    AddCommentStatus? addCommentStatus,
  }) {
    return ActionStepsState(
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