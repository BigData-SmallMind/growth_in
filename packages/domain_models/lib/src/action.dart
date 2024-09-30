class Action {
  const Action({
    required this.id,
    required this.description,
    required this.steps,
  });

  final int id;
  final String description;
  final List<Step> steps;

  int get completeStepsCount => steps.where((step) => step.isComplete).length;
  bool get isComplete => completeStepsCount == steps.length;
}

class Step {
  const Step({
    required this.id,
    required this.description,
    required this.isComplete,
    required this.isCompulsory,
  });

  final int id;
  final bool isCompulsory;

  final String description;
  final bool isComplete;
}
