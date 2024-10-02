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

// @override
// Future<void> close() {
//   requestRepository.changeNotifier.clearRequest();
//   return super.close();
// }
}
