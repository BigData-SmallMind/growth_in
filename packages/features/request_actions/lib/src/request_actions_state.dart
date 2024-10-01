part of 'request_actions_cubit.dart';

class RequestActionsState extends Equatable {
  const RequestActionsState({
    this.request,
  });

  final Request? request;
  RequestActionsState copyWith({Request? request}) {
    return RequestActionsState(
      request: request ?? this.request,
    );
  }

  @override
  List<Object?> get props => [
        request,
      ];
}
