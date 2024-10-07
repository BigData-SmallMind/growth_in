import 'package:domain_models/domain_models.dart';

class Request {
  const Request({
    required this.id,
    required this.name,
    this.serviceName,
    this.projectName,
    this.campaignName,
    required this.dueDate,
    required this.startDate,
    required this.actions,
    this.comments = const [],
    this.descriptionHtml,
    this.completeActionStepsCount,
    this.totalActionStepsCount,
    this.isCompleted,
  });

  final int id;
  final String name;
  final String? serviceName;
  final String? projectName;
  final String? campaignName;
  final DateTime dueDate;
  final DateTime startDate;
  final List<Action> actions;
  final List<Comment> comments;
  final String? descriptionHtml;
  final int? completeActionStepsCount;
  final int? totalActionStepsCount;
  final bool? isCompleted;

  bool get isPastDeadLine => DateTime.now().isAfter(dueDate);

  double get percentActionStepsComplete => totalActionStepsCount == 0
      ? 0
      : completeActionStepsCount != null && totalActionStepsCount != null
          ? (completeActionStepsCount! / totalActionStepsCount!)
          : actions.where((task) => task.isComplete).length / actions.length;

  int get completeActionsCount => completeActionStepsCount != null
      ? completeActionStepsCount!
      : actions.where((task) => task.isComplete).length;

  bool get isComplete => isCompleted == true;

  Request copyWith({
    List<Action>? actions,
    List<Comment>? comments,
    int? completeActionStepsCount,
    bool? isCompleted,
  }) {
    return Request(
      id: id,
      name: name,
      serviceName: serviceName,
      projectName: projectName,
      campaignName: campaignName,
      dueDate: dueDate,
      startDate: startDate,
      actions: actions ?? this.actions,
      comments: comments ?? this.comments,
      descriptionHtml: descriptionHtml,
      completeActionStepsCount:
          completeActionStepsCount ?? this.completeActionStepsCount,
      totalActionStepsCount: totalActionStepsCount,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}

class RequestListPage {
  RequestListPage({
    required this.requestsList,
    required this.isLastPage,
  });

  final List<Request> requestsList;
  final bool isLastPage;
}
