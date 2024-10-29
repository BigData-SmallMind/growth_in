import 'package:growth_in_api/growth_in_api.dart';
import 'package:json_annotation/json_annotation.dart';

part 'folder_rm.g.dart';

@JsonSerializable(createToJson: false)
class FoldersRM {
  FoldersRM({
    required this.active,
    required this.inactive,
  });

  @JsonKey(name: 'folders')
  final List<FolderRM> active;
  @JsonKey(name: 'previous_folders')
  final List<FolderRM> inactive;

  static const fromJson = _$FoldersRMFromJson;
}

@JsonSerializable(createToJson: false)
class FolderRM {
  FolderRM({
    required this.id,
    required this.name,
    required this.dueDate,
    required this.status,
    this.forms = const [],
    required this.filesCount,
    required this.commentsCount,
    required this.milestone,
    this.project,
  });

  @JsonKey(name: 'id')
  final int id;
  @JsonKey(name: 'folder_name')
  final String name;
  @JsonKey(name: 'due_date')
  final String dueDate;
  @JsonKey(name: 'status')
  final String status;
  @JsonKey(name: 'forms')
  final List<FormRM>? forms;
  @JsonKey(name: 'total_files')
  final int filesCount;
  @JsonKey(name: 'comments_count')
  final int? commentsCount;
  @JsonKey(name: 'current_milestone')
  final MileStoneRM? milestone;
  @JsonKey(name: 'projects')
  final ProjectRM? project;

  static const fromJson = _$FolderRMFromJson;
}

@JsonSerializable(createToJson: false)
class MileStoneRM {
  MileStoneRM({
    this.title,
    this.order,
    this.color,
  });

  @JsonKey(name: 'title')
  final String? title;
  @JsonKey(name: 'order')
  final String? order;
  @JsonKey(name: 'color')
  final String? color;

  static const fromJson = _$MileStoneRMFromJson;
}
