import 'package:domain_models/src/project.dart';
import 'package:domain_models/src/request_status.dart';

class FilterBy {
  const FilterBy({
    this.projects,
    this.requestStatus,
    this.searchText,
  });

  final List<Project>? projects;
  final RequestStatus? requestStatus;
  final String? searchText;

  FilterBy copyWith({
    List<Project>? projects,
    RequestStatus? requestStatus,
    String? searchText,
  }) {
    return FilterBy(
      projects: projects ?? this.projects,
      requestStatus: requestStatus ?? this.requestStatus,
      searchText: searchText ?? this.searchText,
    );
  }
}


