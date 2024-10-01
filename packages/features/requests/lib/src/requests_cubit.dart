import 'package:domain_models/domain_models.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:request_repository/request_repository.dart';

part 'requests_state.dart';

class RequestsCubit extends Cubit<RequestsState> {
  RequestsCubit({
    required this.requestRepository,
    required this.onRequestTapped,
  }) : super(const RequestsState()) {
    getRequests();
  }

  final RequestRepository requestRepository;
  final ValueSetter<int> onRequestTapped;

  void getRequests() async {
    final loadingState = state.copyWith(
      fetchingRequestsStatus: FetchingRequestsStatus.loading,
    );
    emit(loadingState);
    try {
      final requests = await requestRepository.getRequests();
      final successState = state.copyWith(
        fetchingRequestsStatus: FetchingRequestsStatus.success,
        requests: requests,
      );
      emit(successState);
    } catch (error) {
      final errorState = state.copyWith(
        fetchingRequestsStatus: FetchingRequestsStatus.error,
      );
      emit(errorState);
    }
  }

// @override
// Future<void> close() {
//   return super.close();
// }
}
