import 'package:domain_models/domain_models.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:request_repository/request_repository.dart';

part 'action_steps_state.dart';

class ActionStepsCubit extends Cubit<ActionStepsState> {
  ActionStepsCubit({
    required this.requestRepository,
    required this.actionId,
  }) : super(
          ActionStepsState(
            request: requestRepository.changeNotifier.request,
            actionId: actionId,
          ),
        ){
    getComments();
  }

  final RequestRepository requestRepository;
  final int actionId;

  void getComments() async {
    final loadingState = state.copyWith(
      commentsFetchStatus: CommentsFetchStatus.loading,
    );
    emit(loadingState);
    try {
      final comments = await requestRepository.getActionComments(actionId);
      final successState = state.copyWith(
        commentsFetchStatus: CommentsFetchStatus.success,
        comments: comments,
      );
      emit(successState);
    } catch (error) {
      final errorState = state.copyWith(
        commentsFetchStatus: CommentsFetchStatus.failure,
      );
      emit(errorState);
    }
  }

  void onToggleStepsCompleteTapped() async {
    final loadingState = state.copyWith(
      toggleStepsCompleteStatus: ToggleStepsCompleteStatus.loading,
    );
    emit(loadingState);
    try {
      final action = state.action;
      await requestRepository.toggleActionStepsComplete(
        action.isComplete,
        actionId,
      );
      final updatedAction = action.copyWith(
        steps: action.steps
            .map(
              (step) => step.copyWith(
                isComplete: !action.isComplete,
              ),
            )
            .toList(),
      );
      final noOfStepsToggled = action.steps
          .where((step) => step.isComplete == action.isComplete)
          .length;
      final previousTotalNumberOfCompleteSteps =
          state.request!.completeActionStepsCount!;
      final shouldIncrement = !action.isComplete;

      final updatedRequest = state.request!.copyWith(
        actions: state.request!.actions
            .map(
              (request) => request.id == actionId ? updatedAction : request,
            )
            .toList(),
        completeActionStepsCount: shouldIncrement
            ? previousTotalNumberOfCompleteSteps + noOfStepsToggled
            : previousTotalNumberOfCompleteSteps - noOfStepsToggled,
      );
      final successState = state.copyWith(
        toggleStepsCompleteStatus: ToggleStepsCompleteStatus.success,
        request: updatedRequest,
      );
      emit(successState);
      requestRepository.changeNotifier.setRequest(updatedRequest);
    } catch (error) {
      final errorState = state.copyWith(
        toggleStepsCompleteStatus: ToggleStepsCompleteStatus.error,
      );
      emit(errorState);
    }
  }

  void toggleSingleActionStepComplete(
    int stepId,
  ) async {
    final loading = state.copyWith(
      toggleSingleStepCompleteStatus: ToggleSingleStepCompleteStatus.loading,
      stepId:stepId,
    );
    emit(loading);
    try {
      final action = state.action;
      await requestRepository.toggleSingleActionStepComplete(
        action.isComplete,
        actionId,
        stepId,
      );
      final step = action.steps.firstWhere((step) => step.id == stepId);
      final updatedStep = step.copyWith(
        isComplete: !step.isComplete,
      );
      final updatedAction = action.copyWith(
        steps: action.steps
            .map(
              (step) => step.id == stepId ? updatedStep : step,
            )
            .toList(),
      );
      final shouldIncrement = !step.isComplete;
      final updatedRequest = state.request!.copyWith(
        actions: state.request!.actions
            .map(
              (action) => action.id == actionId ? updatedAction : action,
            )
            .toList(),
        completeActionStepsCount: shouldIncrement
            ? state.request!.completeActionStepsCount! + 1
            : state.request!.completeActionStepsCount! - 1,
      );
      final successState = state.copyWith(
        toggleSingleStepCompleteStatus: ToggleSingleStepCompleteStatus.success,
        request: updatedRequest,
      );
      emit(successState);
      requestRepository.changeNotifier.setRequest(updatedRequest);
    } catch (error) {
      final errorState = state.copyWith(
        toggleSingleStepCompleteStatus: ToggleSingleStepCompleteStatus.error,
      );
      emit(errorState);
    }
  }

  @override
  Future<void> close() {
    return super.close();
  }
}
