// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forms_sections_rm.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FormsSectionsRM _$FormsSectionsRMFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'FormsSectionsRM',
      json,
      ($checkedConvert) {
        final val = FormsSectionsRM(
          id: $checkedConvert('form_id', (v) => v as String),
          sections: $checkedConvert(
              'sections',
              (v) => (v as List<dynamic>)
                  .map((e) => FormSectionRM.fromJson(e as Map<String, dynamic>))
                  .toList()),
          isCompleted: $checkedConvert('is_completed', (v) => v as bool),
          formName: $checkedConvert('form_name', (v) => v as String),
          serviceName: $checkedConvert('service_name', (v) => v as String),
        );
        return val;
      },
      fieldKeyMap: const {
        'id': 'form_id',
        'isCompleted': 'is_completed',
        'formName': 'form_name',
        'serviceName': 'service_name'
      },
    );

FormSectionRM _$FormSectionRMFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'FormSectionRM',
      json,
      ($checkedConvert) {
        final val = FormSectionRM(
          id: $checkedConvert('id', (v) => (v as num).toInt()),
          name: $checkedConvert('section_name', (v) => v as String),
          questions: $checkedConvert(
              'questions',
              (v) => (v as List<dynamic>)
                  .map((e) => QuestionRM.fromJson(e as Map<String, dynamic>))
                  .toList()),
        );
        return val;
      },
      fieldKeyMap: const {'name': 'section_name'},
    );

QuestionRM _$QuestionRMFromJson(Map<String, dynamic> json) => $checkedCreate(
      'QuestionRM',
      json,
      ($checkedConvert) {
        final val = QuestionRM(
          id: $checkedConvert('id', (v) => (v as num).toInt()),
          text: $checkedConvert('question_text', (v) => v as String),
          description: $checkedConvert('description', (v) => v as String),
          type: $checkedConvert('question_type', (v) => v as String),
          allowMultipleAnswers:
              $checkedConvert('allow_multiple_answers', (v) => v as bool),
          allowAnotherAnswer:
              $checkedConvert('allow_another_answers', (v) => v as bool),
          answer: $checkedConvert('answer', (v) => v),
          anotherAnswer: $checkedConvert('another_answer', (v) => v),
          allowDate: $checkedConvert('allow_date', (v) => v as bool?),
          allowTime: $checkedConvert('allow_time', (v) => v as bool?),
          isTimeRange: $checkedConvert('allow_scale', (v) => v as bool?),
          choices: $checkedConvert('options',
              (v) => (v as List<dynamic>?)?.map((e) => e as String).toList()),
          imageChoices: $checkedConvert('image_options',
              (v) => (v as List<dynamic>?)?.map((e) => e as String).toList()),
          sliderMin: $checkedConvert('scale_from', (v) => (v as num?)?.toInt()),
          sliderMax: $checkedConvert('scale_to', (v) => (v as num?)?.toInt()),
          isRequired: $checkedConvert('is_required', (v) => v as bool),
        );
        return val;
      },
      fieldKeyMap: const {
        'text': 'question_text',
        'type': 'question_type',
        'allowMultipleAnswers': 'allow_multiple_answers',
        'allowAnotherAnswer': 'allow_another_answers',
        'anotherAnswer': 'another_answer',
        'allowDate': 'allow_date',
        'allowTime': 'allow_time',
        'isTimeRange': 'allow_scale',
        'choices': 'options',
        'imageChoices': 'image_options',
        'sliderMin': 'scale_from',
        'sliderMax': 'scale_to',
        'isRequired': 'is_required'
      },
    );
