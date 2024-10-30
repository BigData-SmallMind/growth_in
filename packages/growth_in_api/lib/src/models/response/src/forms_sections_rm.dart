import 'package:json_annotation/json_annotation.dart';

part 'forms_sections_rm.g.dart';

@JsonSerializable(createToJson: false)
class FormsSectionsRM {
  FormsSectionsRM({
    required this.id,
    required this.sections,
    required this.formName,
     this.serviceName,
  });

  @JsonKey(name: 'sections')
  final List<FormSectionRM> sections;
  @JsonKey(name: 'form_id')
  final String id;
  @JsonKey(name: 'form_name')
  final String formName;
  @JsonKey(name: 'service_name')
  final String? serviceName;

  static const fromJson = _$FormsSectionsRMFromJson;
}

@JsonSerializable(createToJson: false)
class FormSectionRM {
  FormSectionRM({
    required this.id,
     this.name,
    required this.questions,
  });

  @JsonKey(name: 'id')
  final int id;
  @JsonKey(name: 'section_name')
  final String? name;
  @JsonKey(name: 'questions')
  final List<QuestionRM> questions;

  static const fromJson = _$FormSectionRMFromJson;
}

@JsonSerializable(createToJson: false)
class QuestionRM {
  QuestionRM({
    required this.id,
    required this.text,
     this.description,
    required this.type,
    required this.allowMultipleAnswers,
    required this.allowAnotherAnswer,
    this.answer,
    this.anotherAnswer,
    this.allowDate,
    this.allowTime,
    this.isTimeRange,
    this.choices,
    this.imageChoices,
    this.sliderMin,
    this.sliderMax,
    required this.isRequired,
  });

  @JsonKey(name: 'id')
  final int id;
  @JsonKey(name: 'question_text')
  final String text;
  @JsonKey(name: 'description')
  final String? description;
  @JsonKey(name: 'question_type')
  final String type;
  @JsonKey(name: 'allow_multiple_answers')
  final bool allowMultipleAnswers;
  @JsonKey(name: 'allow_another_answers')
  final bool allowAnotherAnswer;
  @JsonKey(name: 'answer')
  final dynamic answer;
  @JsonKey(name: 'another_answer')
  final dynamic anotherAnswer;
  @JsonKey(name: 'allow_date')
  final bool? allowDate;
  @JsonKey(name: 'allow_time')
  final bool? allowTime;
  @JsonKey(name: 'allow_scale')
  final bool? isTimeRange;
  @JsonKey(name: 'options')
  final List<String>? choices;
  @JsonKey(name: 'image_options')
  final List<String>? imageChoices;
  @JsonKey(name: 'scale_from')
  final int? sliderMin;
  @JsonKey(name: 'scale_to')
  final int? sliderMax;
  @JsonKey(name: 'is_required')
  final bool isRequired;

  static const fromJson = _$QuestionRMFromJson;
}
