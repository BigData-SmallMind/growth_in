import 'package:json_annotation/json_annotation.dart';

part 'project_rm.g.dart';

@JsonSerializable(createToJson: false)
class ProjectRM {
  ProjectRM({
    required this.id,
    required this.name,

  });

  @JsonKey(name: 'project_id')
  final int id;
  @JsonKey(name: 'project_name')
  final String name;


  static const fromJson = _$ProjectRMFromJson;
}
