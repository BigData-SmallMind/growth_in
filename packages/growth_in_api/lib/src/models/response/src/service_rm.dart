import 'package:json_annotation/json_annotation.dart';

part 'service_rm.g.dart';


@JsonSerializable(createToJson: false)
class ServiceRM {
  ServiceRM({
    required this.id,
    required this.name,
  });

  @JsonKey(name: 'id')
  final int id;
  @JsonKey(name: 'service_name')
  final String name;

  static const fromJson = _$ServiceRMFromJson;
}
