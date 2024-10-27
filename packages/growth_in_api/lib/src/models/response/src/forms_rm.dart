import 'package:growth_in_api/src/models/models.dart';
import 'package:growth_in_api/src/models/response/src/form_rm.dart';
import 'package:json_annotation/json_annotation.dart';

part 'forms_rm.g.dart';

@JsonSerializable(createToJson: false)
class FormsRM {
  FormsRM({
    required this.list,
    required this.previous,
  });

  @JsonKey(name: 'forms')
  final List<FormRM> list;
  @JsonKey(name: 'previous_forms')
  final List<FormRM> previous;

  static const fromJson = _$FormsRMFromJson;
}

