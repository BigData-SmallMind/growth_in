import 'package:json_annotation/json_annotation.dart';

part 'request_v1_rm.g.dart';

@JsonSerializable(createToJson: false)
class RequestV1RM {
  RequestV1RM({
    required this.id,
    required this.name,
    this.serviceName,
    this.projectName,
    this.campaignName,
    required this.type,
    required this.dueDate,
    required this.startDate,
    required this.status,
    required this.actionsCompletedCount,
    required this.actionsTotalCount,
  });

  @JsonKey(name: 'task_id')
  final int id;
  @JsonKey(name: 'task_type')
  final String type;
  @JsonKey(name: 'task_name')
  final String name;
  @JsonKey(name: 'service_name')
  final String? serviceName;
  @JsonKey(name: 'project_name')
  final String? projectName;
  @JsonKey(name: 'campaign_name')
  final String? campaignName;
  @JsonKey(name: 'due_date')
  final String dueDate;
  @JsonKey(name: 'start_date')
  final String startDate;
  @JsonKey(name: 'status')
  final String status;
  @JsonKey(name: 'completed_contents_count')
  final int actionsCompletedCount;
  @JsonKey(name: 'total_contents_count')
  final int actionsTotalCount;

  static const fromJson = _$RequestV1RMFromJson;
}

@JsonSerializable(createToJson: false)
class PaginationRM {
  PaginationRM({
    required this.currentPage,
    required this.lastPage,
  });

  @JsonKey(name: 'current_page')
  final int currentPage;
  @JsonKey(name: 'last_page')
  final int lastPage;

  static const fromJson = _$PaginationRMFromJson;
}


@JsonSerializable(createToJson: false)
class RequestListPageRM {
  RequestListPageRM({
    required this.requestsList,
    required this.pagination,
  });

  @JsonKey(name: 'tasks')
  final List<RequestV1RM> requestsList;
  @JsonKey(name: 'pagination')
  final PaginationRM pagination;

  static const fromJson = _$RequestListPageRMFromJson;
}

