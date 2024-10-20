
class FormsDM {
  FormsDM({
    required this.list,
    required this.previous,
  });

  final List<FormDM> list;
  final List<FormDM> previous;
}

class FormDM {
  FormDM({
    required this.id,
    required this.name,
    required this.status,
    required this.totalQuestions,
    required this.totalAnsweredQuestions,
    required this.services,
  });

  final int id;
  final String name;
  final String status;
  final int totalQuestions;
  final int totalAnsweredQuestions;
  final List<ServiceDM> services;
}

class ServiceDM {
  ServiceDM({
    required this.id,
    required this.name,
  });

  final int id;
  final String name;
}