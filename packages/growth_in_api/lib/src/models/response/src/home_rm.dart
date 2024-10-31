import 'package:growth_in_api/growth_in_api.dart';
import 'package:json_annotation/json_annotation.dart';

part 'home_rm.g.dart';

@JsonSerializable(createToJson: false)
class HomeRM {
  HomeRM({
    this.meeting,
    this.posts = const [],
    this.requests = const [],
    this.dashboardLink,
    this.filesCount,
  });

  @JsonKey(name: 'latestUpcomingMeeting')
  final MeetingRM? meeting;
  @JsonKey(name: 'posts')
  final List<PostRM> posts;
  @JsonKey(name: 'delayed_tasks')
  final List<HomeRequestRM> requests;
  @JsonKey(name: 'dashboard_link')
  final String? dashboardLink;
  @JsonKey(name: 'files_count')
  final int? filesCount;

  static const fromJson = _$HomeRMFromJson;
}

@JsonSerializable(createToJson: false)
class HomeRequestRM {
  HomeRequestRM({
    required this.id,
    required this.name,
    required this.startDate,
    required this.dueDate,
  });

  @JsonKey(name: 'id')
  final int id;
  @JsonKey(name: 'task_name')
  final String name;
  @JsonKey(name: 'start_date')
  final String startDate;
  @JsonKey(name: 'due_date')
  final String dueDate;
  static const fromJson = _$HomeRequestRMFromJson;
}
