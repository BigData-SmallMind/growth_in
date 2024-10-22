class FormsSections {
  FormsSections({
    required this.id,
    required this.list,
    required this.isCompleted,
    required this.formName,
    required this.serviceName,
  });

  final List<FormSection> list;
  final String id;
  final bool isCompleted;
  final String formName;
  final String serviceName;
}

class FormSection {
  FormSection({
    required this.id,
    required this.name,
    required this.questions,
  });

  final int id;
  final String name;
  final List<Question> questions;
}

// class QuestionRM {
//   QuestionRM({
//     required this.id,
//     required this.text,
//     required this.description,
//     required this.type,
//     required this.allowMultipleAnswers,
//     required this.allowAnotherAnswer,
//     this.answer,
//     this.anotherAnswer,
//     this.allowDate,
//     this.allowTime,
//     this.isTimeRange,
//     this.choices,
//     this.imageChoices,
//     this.sliderMin,
//     this.sliderMax,
//     required this.isRequired,
//   });
//
//   @JsonKey(name: 'id')
//   final int id;
//   @JsonKey(name: 'question_text')
//   final String text;
//   @JsonKey(name: 'description')
//   final String description;
//   @JsonKey(name: 'question_type')
//   final String type;
//   @JsonKey(name: 'allow_multiple_answers')
//   final bool allowMultipleAnswers;
//   @JsonKey(name: 'allow_another_answers')
//   final bool allowAnotherAnswer;
//   @JsonKey(name: 'answer')
//   final dynamic answer;
//   @JsonKey(name: 'another_answer')
//   final dynamic anotherAnswer;
//   @JsonKey(name: 'allow_date')
//   final bool? allowDate;
//   @JsonKey(name: 'allow_time')
//   final bool? allowTime;
//   @JsonKey(name: 'allow_scale')
//   final bool? isTimeRange;
//   @JsonKey(name: 'options')
//   final List<String>? choices;
//   @JsonKey(name: 'imageOptions')
//   final List<String>? imageChoices;
//   @JsonKey(name: 'scale_from')
//   final int? sliderMin;
//   @JsonKey(name: 'scale_to')
//   final int? sliderMax;
//   @JsonKey(name: 'is_required')
//   final bool isRequired;
//
//   static const fromJson = _$QuestionRMFromJson;
// }

class Question {
  Question({
    required this.id,
    required this.text,
    required this.description,
    required this.type,
    required this.allowMultipleAnswers,
    required this.allowAnotherAnswer,
    this.answer,
    this.anotherAnswer,
    this.allowDate,
    this.allowTime,
    this.isTimeRange,
    this.choices,
    this.sliderMin,
    this.sliderMax,
    required this.isRequired,
  });

  final int id;
  final String text;
  final String description;
  final QuestionType type;
  final bool allowMultipleAnswers;
  final bool allowAnotherAnswer;

  // could be a string, a list of strings or an entirely different type
  final dynamic answer;
  final dynamic anotherAnswer;
  final bool? allowDate;
  final bool? allowTime;
  final bool? isTimeRange;
  final List<String>? choices;
  final int? sliderMin;
  final int? sliderMax;
  final bool isRequired;

  Question copyWith({
    dynamic answer,
    bool? allowMultipleAnswers,
  }) {
    return Question(
      id: id,
      text: text,
      description: description,
      type: type,
      allowMultipleAnswers: allowMultipleAnswers ?? this.allowMultipleAnswers,
      allowAnotherAnswer: allowAnotherAnswer,
      answer: answer ?? this.answer,
      anotherAnswer: anotherAnswer,
      allowDate: allowDate,
      allowTime: allowTime,
      isTimeRange: isTimeRange,
      choices: choices,
      sliderMin: sliderMin,
      sliderMax: sliderMax,
      isRequired: isRequired,
    );
  }
}

enum QuestionType {
  essay,
  longEssay,
  slider,
  multipleChoice,
  dropdown,
  fileUpload,
  multipleImageChoice,
  dateType,
  dateOnly,
  timeOnly,
  dateAndTime,
  dateRange,
  timeRange,
  dateAndTimeRange,
  imageQuestion;
}
