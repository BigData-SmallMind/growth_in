import 'package:json_annotation/json_annotation.dart';

part 'project_rm.g.dart';

@JsonSerializable(createToJson: false)
class ProjectRM {
  ProjectRM({
    required this.id,
    this.name,
    this.description,
  });

  @JsonKey(name: 'project_id')
  final int id;
  @JsonKey(name: 'project_name')
  final String? name;
  @JsonKey(name: 'project_description')
  final String? description;

  static const fromJson = _$ProjectRMFromJson;
}
