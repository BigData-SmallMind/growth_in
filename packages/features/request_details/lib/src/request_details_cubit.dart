import 'package:domain_models/domain_models.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:request_repository/request_repository.dart';

part 'request_details_state.dart';

class RequestDetailsCubit extends Cubit<RequestDetailsState> {
  RequestDetailsCubit({
    required this.requestRepository,
    required this.onViewAllActionsTapped,
    required this.onViewActionStepsTapped,
    required this.onViewAllCommentsTapped,
    required this.requestId,
  }) : super(const RequestDetailsState()) {
    getRequest();
    requestRepository.changeNotifier.addListener(
      () {
        final request = requestRepository.changeNotifier.request;
        if (request != null && !isClosed) {
          emit(state.copyWith(request: request));
        }
      },
    );
  }

  final RequestRepository requestRepository;
  final VoidCallback onViewAllActionsTapped;
  final ValueSetter<int> onViewActionStepsTapped;
  final VoidCallback onViewAllCommentsTapped;
  final TextEditingController commentController = TextEditingController();
  final int requestId;

  void getRequest() async {
    final loadingState = state.copyWith(
      requestFetchingStatus: RequestFetchingStatus.loading,
    );
    emit(loadingState);
    try {
      final request = await requestRepository.getRequest(requestId);
      final successState = state.copyWith(
        requestFetchingStatus: RequestFetchingStatus.success,
        request: request,
      );
      emit(successState);
    } catch (error) {
      final errorState = state.copyWith(
        requestFetchingStatus: RequestFetchingStatus.error,
      );
      emit(errorState);
    }
  }

  void toggleRequestComplete() async {
    final loadingState = state.copyWith(
      toggleRequestCompleteStatus: ToggleRequestCompleteStatus.loading,
    );
    emit(loadingState);
    try {
      final request = state.request!;
      await requestRepository.toggleRequestComplete(
        request.isComplete,
        request.id,
      );

      final updatedRequest = request.copyWith(
        isCompleted: !request.isComplete,
      );
      final successState = state.copyWith(
        toggleRequestCompleteStatus: ToggleRequestCompleteStatus.success,
        request: updatedRequest,
      );
      emit(successState);
    } catch (error) {
      final errorState = state.copyWith(
        toggleRequestCompleteStatus: ToggleRequestCompleteStatus.error,
      );
      emit(errorState);
    }
  }

  void onCommentChanged(String newValue) {
    commentController.text = newValue;
    emit(state.copyWith(comment: newValue));
  }

  void addComment() async {
    final loadingState = state.copyWith(
      addCommentStatus: AddCommentStatus.loading,
    );
    emit(loadingState);
    try {
      final comment = commentController.text;
      await requestRepository.addComment(
        actionId: null,
        requestId: requestId,
        comment: comment,
      );
      final successState = state.copyWith(
        addCommentStatus: AddCommentStatus.success,
      );
      emit(successState);
    } catch (error) {
      final errorState = state.copyWith(
        addCommentStatus: AddCommentStatus.error,
      );
      emit(errorState);
    }
  }

// @override
// Future<void> close() {
//   requestRepository.changeNotifier.clearRequest();
//   return super.close();
// }
}
