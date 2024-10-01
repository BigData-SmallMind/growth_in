import 'package:json_annotation/json_annotation.dart';

part 'request_rm.g.dart';

@JsonSerializable(createToJson: false)
class RequestRM {
  RequestRM({
    required this.id,
    required this.name,
    required this.service,
    required this.deadline,
    required this.dateCreated,
    this.actions,
    this.descriptionHtml,
    required this.isCompleted,
  });

  @JsonKey(name: 'task_id')
  final int id;
  @JsonKey(name: 'task_name')
  final String name;
  @JsonKey(name: 'service_name')
  final String service;
  @JsonKey(name: 'due_date')
  final String deadline;
  @JsonKey(name: 'start_date')
  final String dateCreated;
  @JsonKey(name: 'description')
  final String? descriptionHtml;
  @JsonKey(name: 'items')
  final List<ActionRM>? actions;
  @JsonKey(name: 'is_completed')
  final bool isCompleted;

  static const fromJson = _$RequestRMFromJson;
}

@JsonSerializable(createToJson: false)
class ActionRM {
  ActionRM({
    required this.id,
    required this.title,
    this.files,
    this.steps,
  });

  @JsonKey(name: 'item_id')
  final int id;
  @JsonKey(name: 'task_title')
  final String title;
  @JsonKey(name: 'task_files')
  final List<String>? files;
  @JsonKey(name: 'task_content')
  final List<StepRM>? steps;

  static const fromJson = _$ActionRMFromJson;
}

@JsonSerializable(createToJson: false)
class StepRM {
  StepRM({
    required this.id,
    required this.content,
    required this.isCompleted,
  });

  @JsonKey(name: 'content_id')
  final int id;
  @JsonKey(name: 'content')
  final String content;
  @JsonKey(name: 'is_completed')
  final bool isCompleted;

  static const fromJson = _$StepRMFromJson;
}

@JsonSerializable(createToJson: false)
class ServiceRM {
  ServiceRM({
    required this.id,
    required this.name,
  });

  @JsonKey(name: 'id')
  final int id;
  @JsonKey(name: 'service_name')
  final String name;

  static const fromJson = _$ServiceRMFromJson;
}