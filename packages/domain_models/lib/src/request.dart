import 'package:domain_models/domain_models.dart';

class Request {
  const Request({
    required this.id,
    required this.name,
    required this.serviceName,
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
  final String serviceName;
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
    int? id,
    String? name,
    String? serviceName,
    DateTime? dueDate,
    DateTime? startDate,
    List<Action>? actions,
    List<Comment>? comments,
    String? descriptionHtml,
    int? completeActionStepsCount,
    int? totalActionStepsCount,
    bool? isCompleted,
  }) {
    return Request(
      id: id ?? this.id,
      name: name ?? this.name,
      serviceName: serviceName ?? this.serviceName,
      dueDate: dueDate ?? this.dueDate,
      startDate: startDate ?? this.startDate,
      actions: actions ?? this.actions,
      comments: comments ?? this.comments,
      descriptionHtml: descriptionHtml ?? this.descriptionHtml,
      completeActionStepsCount:
          completeActionStepsCount ?? this.completeActionStepsCount,
      totalActionStepsCount:
          totalActionStepsCount ?? this.totalActionStepsCount,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}
