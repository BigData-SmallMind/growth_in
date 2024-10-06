import 'package:domain_models/src/project.dart';

class FilterBy {
  const FilterBy({
    required this.projects,
    required this.name,
  });

  final List<Project> projects;
  final RequestStatus name;
}
