part of 'requests_cubit.dart';

class RequestsState extends Equatable {
  const RequestsState({
    this.fetchingRequestsStatus = FetchingRequestsStatus.initial,
    this.requests = const [],
  });

  final FetchingRequestsStatus fetchingRequestsStatus;
  final List<Request> requests;

  RequestsState copyWith({
    FetchingRequestsStatus? fetchingRequestsStatus,
    List<Request>? requests,
  }) {
    return RequestsState(
      fetchingRequestsStatus:
          fetchingRequestsStatus ?? this.fetchingRequestsStatus,
      requests: requests ?? this.requests,
    );
  }

  @override
  List<Object?> get props => [
        fetchingRequestsStatus,
        requests,
      ];
}

enum FetchingRequestsStatus {
  initial,
  loading,
  success,
  error,
}
