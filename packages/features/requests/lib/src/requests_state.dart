part of 'requests_cubit.dart';

class RequestsState extends Equatable {
  const RequestsState({
    this.requests = const [],
  });

  final List<Request> requests;

  RequestsState copyWith({List<Request>? requests}) {
    return RequestsState(
      requests: requests ?? this.requests,
    );
  }

  @override
  List<Object?> get props => [
        requests,
      ];
}
