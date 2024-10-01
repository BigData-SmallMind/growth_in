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
    this.remoteCompleteActionsCount,
    this.remoteTotalActionsCount,
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
  final int? remoteCompleteActionsCount;
  final int? remoteTotalActionsCount;
  final bool? isCompleted;

  bool get isPastDeadLine => DateTime.now().isAfter(dueDate);

  double get percentTasksComplete => remoteTotalActionsCount == 0
      ? 0
      : remoteCompleteActionsCount != null && remoteTotalActionsCount != null
          ? (remoteCompleteActionsCount! / remoteTotalActionsCount!)
          : actions.where((task) => task.isComplete).length / actions.length;

  int get completeActionsCount => remoteCompleteActionsCount != null
      ? remoteCompleteActionsCount!
      : actions.where((task) => task.isComplete).length;


}


