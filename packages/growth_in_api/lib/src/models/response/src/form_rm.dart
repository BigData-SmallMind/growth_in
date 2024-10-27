import 'package:growth_in_api/src/models/models.dart';
import 'package:json_annotation/json_annotation.dart';

part 'form_rm.g.dart';



@JsonSerializable(createToJson: false)
class FormRM {
  FormRM({
    required this.id,
    required this.name,
    required this.status,
    required this.totalQuestions,
    required this.totalAnsweredQuestions,
    required this.services,
  });

  @JsonKey(name: 'form_id')
  final int id;
  @JsonKey(name: 'form_name')
  final String name;
  @JsonKey(name: 'status')
  final String? status;
  @JsonKey(name: 'total_questions')
  final int? totalQuestions;
  @JsonKey(name: 'answered_questions')
  final int? totalAnsweredQuestions;
  @JsonKey(name: 'services')
  final List<ServiceRM>? services;

  static const fromJson = _$FormRMFromJson;
}

