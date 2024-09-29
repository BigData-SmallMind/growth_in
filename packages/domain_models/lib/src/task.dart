class Request {
  const Request({
    required this.id,
    required this.name,
    required this.deadline,
    required this.dateCreated,
  });

  final int id;
  final String name;
  final DateTime deadline;
  final DateTime dateCreated;

  bool get isPastDeadLine => DateTime.now().isAfter(deadline);
}

final dummyRequests = List.generate(
  10,
  (index) => Request(
    id: index,
    name: 'Request $index',
    deadline: DateTime.now().add(Duration(days: index)),
    dateCreated: DateTime.now().subtract(Duration(days: index)),
  ),
);
