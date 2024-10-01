part of 'request_details_cubit.dart';

class RequestDetailsState extends Equatable {
  const RequestDetailsState({
    this.requestFetchingStatus = RequestFetchingStatus.initial,
    this.request,
  });

  final RequestFetchingStatus requestFetchingStatus;
  final Request? request;

  RequestDetailsState copyWith({
    RequestFetchingStatus? requestFetchingStatus,
    Request? request,
  }) {
    return RequestDetailsState(
      requestFetchingStatus: requestFetchingStatus ?? this.requestFetchingStatus,
      request: request ?? this.request,
    );
  }

  @override
  List<Object?> get props => [
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
