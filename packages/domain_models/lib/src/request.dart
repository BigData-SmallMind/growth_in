import 'package:domain_models/domain_models.dart';

class Request {
  const Request({
    required this.id,
    required this.name,
    required this.serviceName,
    required this.deadline,
    required this.dateCreated,
    required this.actions,
    this.comments = const [],
    this.details,
    required this.isComplete,
  });

  final int id;
  final String name;
  final String serviceName;
  final DateTime deadline;
  final DateTime dateCreated;
  final List<Action> actions;
  final List<Comment> comments;
  final String? details;
  final bool isComplete;

  bool get isPastDeadLine => DateTime.now().isAfter(deadline);

  double get percentTasksComplete =>
      actions.where((task) => task.isComplete).length / actions.length;

  int get completeTasksCount => actions.where((task) => task.isComplete).length;
}

final dummyRequests = List.generate(
  10,
  (index) => Request(
    id: index,
    name: 'اسم طلب $index',
    serviceName: 'اسم خدمه $index',
    deadline: DateTime.now().add(Duration(days: index)),
    dateCreated: DateTime.now().subtract(Duration(days: index)),
    actions: List.generate(
      10,
      (index) => Action(
        id: index,
        description: 'Description for Action $index ' * 10,
        steps: List.generate(
          3,
          (index) => Step(
            id: index,
            isCompulsory: randomBool(),
            description: 'Description for Step $index '  * 10,
            isComplete: randomBool(),
          ),
        ),
      ),
    ),
    comments: List.generate(
      4,
      (index) => Comment(
        id: index,
        author: 'مؤلف التعليق $index',
        text: 'نص التعليق $index ' * 10,
        dateCreated: DateTime.now().subtract(Duration(days: index)),
        authorImage: 'https://laravel.growth-in.net/subgrowthin/public/images/avatar.jpg',
      ),
    ),
    details: 'Details for request $index ' * 10,
    isComplete: randomBool(),
  ),
);

// functuio that returns random bool value
bool randomBool() => DateTime.now().microsecond % 2 == 0;
