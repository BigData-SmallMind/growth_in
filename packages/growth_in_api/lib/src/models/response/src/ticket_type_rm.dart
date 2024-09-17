import 'package:json_annotation/json_annotation.dart';

part 'ticket_type_rm.g.dart';

@JsonSerializable(createToJson: false)
class TicketTypeRM {
  TicketTypeRM({
    required this.id,
    required this.name,
  });

  @JsonKey(name: 'id')
  final int id;
  @JsonKey(name: 'name')
  final String name;

  static const fromJson = _$TicketTypeRMFromJson;
}
