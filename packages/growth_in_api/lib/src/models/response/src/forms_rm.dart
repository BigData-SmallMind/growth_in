import 'package:json_annotation/json_annotation.dart';

part 'forms_rm.g.dart';

@JsonSerializable(createToJson: false)
class FormsRM {
  FormsRM({
    required this.list,
  });

  @JsonKey(name: 'forms')
  final List<FormRM> list;

  static const fromJson = _$FormsRMFromJson;
}

@JsonSerializable(createToJson: false)
class FormRM {
  FormRM({
    required this.id,
    required this.name,
    required this.status,
    required this.totalQuestions,
    required this.totalAnsweredQuestions,
  });

  @JsonKey(name: 'form_id')
  final int id;
  @JsonKey(name: 'form_name')
  final String name;
  @JsonKey(name: 'status')
  final String status;
  @JsonKey(name: 'total_questions')
  final int totalQuestions;
  @JsonKey(name: 'answered_questions')
  final int totalAnsweredQuestions;

  static const fromJson = _$FormRMFromJson;
}
