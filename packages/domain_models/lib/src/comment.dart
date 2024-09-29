import 'package:domain_models/src/task.dart';

class Request {
  const Request({
    required this.id,
    required this.name,
    required this.serviceName,
    required this.deadline,
    required this.dateCreated,
    required this.tasks,
    this.comments = const [],
    this.details,
  });

  final int id;
  final String name;
  final String serviceName;
  final DateTime deadline;
  final DateTime dateCreated;
  final List<Task> tasks;
  final List<Comment> comments;
  final String? details;

  bool get isPastDeadLine => DateTime.now().isAfter(deadline);

  double get percentTasksComplete =>
      tasks.where((task) => task.isComplete).length / tasks.length;

  int get completeTasksCount => tasks.where((task) => task.isComplete).length;
}

final dummyRequests = List.generate(
  10,
  (index) => Request(
    id: index,
    name: 'اسم طلب $index',
    serviceName: 'اسم خدمه $index',
    deadline: DateTime.now().add(Duration(days: index)),
    dateCreated: DateTime.now().subtract(Duration(days: index)),
    tasks: List.generate(
      10,
      (index) => Task(
        id: index,
        name: 'مهمه $index',
        description: 'Description for Task $index',
        isComplete: randomBool(),
      ),
    ),
    comments: List.generate(5, (index) => 'Comment $index for request $index'),
    details: 'Details for request $index',
  ),
);

// functuio that returns random bool value
bool randomBool() => DateTime.now().microsecond % 2 == 0;
