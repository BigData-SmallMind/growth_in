part of 'request_details_cubit.dart';

class RequestDetailsState extends Equatable {
  const RequestDetailsState({
    this.requestFetchingStatus = RequestFetchingStatus.initial,
    this.toggleRequestCompleteStatus = ToggleRequestCompleteStatus.initial,
    this.request,
  });

  final ToggleRequestCompleteStatus toggleRequestCompleteStatus;
  final RequestFetchingStatus requestFetchingStatus;
  final Request? request;

  RequestDetailsState copyWith({
    ToggleRequestCompleteStatus? toggleRequestCompleteStatus,
    RequestFetchingStatus? requestFetchingStatus,
    Request? request,
  }) {
    return RequestDetailsState(
      toggleRequestCompleteStatus:
          toggleRequestCompleteStatus ?? this.toggleRequestCompleteStatus,
      requestFetchingStatus:
          requestFetchingStatus ?? this.requestFetchingStatus,
      request: request ?? this.request,
    );
  }

  @override
  List<Object?> get props => [
        toggleRequestCompleteStatus,
        requestFetchingStatus,
        request,
      ];
}

enum RequestFetchingStatus {
  initial,
  loading,
  success,
  error,
}

enum ToggleRequestCompleteStatus {
  initial,
  loading,
  success,
  error,
}
