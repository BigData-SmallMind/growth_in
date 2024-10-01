import 'package:domain_models/domain_models.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:request_repository/request_repository.dart';

part 'request_details_state.dart';

class RequestDetailsCubit extends Cubit<RequestDetailsState> {
  RequestDetailsCubit(
      {required this.requestRepository,
      required this.onProfileInfoTapped,
      required this.onChangePasswordTapped,
      required this.onChangeEmailTapped,
      required this.requestId})
      : super(const RequestDetailsState()) {
    getRequestDetails();
  }

  final RequestRepository requestRepository;
  final VoidCallback onProfileInfoTapped;
  final VoidCallback onChangePasswordTapped;
  final VoidCallback onChangeEmailTapped;
  final int requestId;

  void getRequestDetails() async {
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

// @override
// Future<void> close() {
//   return super.close();
// }
}
