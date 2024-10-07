part of 'request_details_cubit.dart';

class RequestDetailsState extends Equatable {
  const RequestDetailsState({
    this.requestFetchingStatus = RequestFetchingStatus.initial,
    this.toggleRequestCompleteStatus = ToggleRequestCompleteStatus.initial,
    this.request,
    this.addCommentStatus = AddCommentStatus.initial,
    this.comment,
  });

  final ToggleRequestCompleteStatus toggleRequestCompleteStatus;
  final RequestFetchingStatus requestFetchingStatus;
  final Request? request;
  final AddCommentStatus addCommentStatus;
  final String? comment;

  RequestDetailsState copyWith({
    ToggleRequestCompleteStatus? toggleRequestCompleteStatus,
    RequestFetchingStatus? requestFetchingStatus,
    Request? request,
    AddCommentStatus? addCommentStatus,
    String? comment,
  }) {
    return RequestDetailsState(
      toggleRequestCompleteStatus:
          toggleRequestCompleteStatus ?? this.toggleRequestCompleteStatus,
      requestFetchingStatus:
          requestFetchingStatus ?? this.requestFetchingStatus,
      request: request ?? this.request,
      addCommentStatus: addCommentStatus ?? this.addCommentStatus,
      comment: comment ?? this.comment,
    );
  }

  @override
  List<Object?> get props => [
        toggleRequestCompleteStatus,
        requestFetchingStatus,
        request,
        addCommentStatus,
        comment,
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

enum AddCommentStatus {
  initial,
  loading,
  success,
  error,
}
