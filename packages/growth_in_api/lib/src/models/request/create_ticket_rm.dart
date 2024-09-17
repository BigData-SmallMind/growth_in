import 'package:json_annotation/json_annotation.dart';

part 'create_ticket_rm.g.dart';


@JsonSerializable(createFactory: false)
class CreateTicketRM {
  const CreateTicketRM({
    required this.title,
    required this.description,
    required this.ticketType,

  });

  @JsonKey(name: 'title')
  final String title;
  @JsonKey(name: 'message_text')
  final String description;
  @JsonKey(name: 'message_subject')
  final String ticketType;




  Map<String, dynamic> toJson() => _$CreateTicketRMToJson(this);
}
