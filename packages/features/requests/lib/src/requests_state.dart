part of 'requests_cubit.dart';

class RequestsState extends Equatable {
  const RequestsState({
    this.requests,
    this.filterBy = const FilterBy(),
    this.nextSearchPage,
    this.nextSearchListPageLoadError,
    this.projects,
    this.projectsFetchStatus = ProjectsFetchStatus.initial,
  });

  final List<Request>? requests;
  final FilterBy filterBy;
  final int? nextSearchPage;
  final dynamic nextSearchListPageLoadError;
  final List<Project>? projects;
  final ProjectsFetchStatus projectsFetchStatus;

  RequestsState copyWith({
    List<Request>? requests,
    FilterBy? filterBy,
    int? nextSearchPage,
    dynamic nextSearchListPageLoadError,
    List<Project>? projects,
    ProjectsFetchStatus? projectsFetchStatus,
  }) {
    return RequestsState(
      requests: requests ?? this.requests,
      filterBy: filterBy ?? this.filterBy,
      nextSearchPage: nextSearchPage ?? this.nextSearchPage,
      nextSearchListPageLoadError: nextSearchListPageLoadError,
      projects: projects ?? this.projects,
      projectsFetchStatus: projectsFetchStatus ?? this.projectsFetchStatus,
    );
  }

  @override
  List<Object?> get props => [
        requests,
        filterBy,
        nextSearchPage,
        nextSearchListPageLoadError,
        projects,
        projectsFetchStatus,
      ];
}

enum ProjectsFetchStatus {
  initial,
  loading,
  loaded,
  error,
}
