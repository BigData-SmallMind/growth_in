class Action {
  const Action({
    required this.id,
    required this.title,
    required this.steps,
  });

  final int id;
  final String title;
  final List<Step> steps;

  int get completeStepsCount => steps.where((step) => step.isComplete).length;
  bool get isComplete => completeStepsCount == steps.length;

  Action copyWith({
    int? id,
    String? title,
    List<Step>? steps,
  }) {
    return Action(
      id: id ?? this.id,
      title: title ?? this.title,
      steps: steps ?? this.steps,
    );
  }
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

  Step copyWith({
    int? id,
    String? description,
    bool? isComplete,
    bool? isCompulsory,
  }) {
    return Step(
      id: id ?? this.id,
      description: description ?? this.description,
      isComplete: isComplete ?? this.isComplete,
      isCompulsory: isCompulsory ?? this.isCompulsory,
    );
  }
}
