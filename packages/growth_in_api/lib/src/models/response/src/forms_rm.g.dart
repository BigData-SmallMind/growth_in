// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forms_rm.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FormsRM _$FormsRMFromJson(Map<String, dynamic> json) => $checkedCreate(
      'FormsRM',
      json,
      ($checkedConvert) {
        final val = FormsRM(
          list: $checkedConvert(
              'forms',
              (v) => (v as List<dynamic>)
                  .map((e) => FormRM.fromJson(e as Map<String, dynamic>))
                  .toList()),
        );
        return val;
      },
      fieldKeyMap: const {'list': 'forms'},
    );

FormRM _$FormRMFromJson(Map<String, dynamic> json) => $checkedCreate(
      'FormRM',
      json,
      ($checkedConvert) {
        final val = FormRM(
          id: $checkedConvert('form_id', (v) => (v as num).toInt()),
          name: $checkedConvert('form_name', (v) => v as String),
          status: $checkedConvert('status', (v) => v as String),
          totalQuestions:
              $checkedConvert('total_questions', (v) => (v as num).toInt()),
          totalAnsweredQuestions:
              $checkedConvert('answered_questions', (v) => (v as num).toInt()),
        );
        return val;
      },
      fieldKeyMap: const {
        'id': 'form_id',
        'name': 'form_name',
        'totalQuestions': 'total_questions',
        'totalAnsweredQuestions': 'answered_questions'
      },
    );
