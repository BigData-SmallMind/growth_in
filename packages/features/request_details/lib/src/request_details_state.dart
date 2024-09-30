part of 'request_details_cubit.dart';

class RequestDetailsState extends Equatable {
  const RequestDetailsState({
    this.request,
  });

  final Request? request;

  RequestDetailsState copyWith({Request? request}) {
    return RequestDetailsState(
      request: request ?? this.request,
    );
  }

  @override
  List<Object?> get props => [
        request,
      ];
}
