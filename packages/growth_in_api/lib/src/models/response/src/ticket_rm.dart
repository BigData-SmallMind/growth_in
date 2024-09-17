import 'package:json_annotation/json_annotation.dart';

part 'ticket_rm.g.dart';

@JsonSerializable(createToJson: false)
class TicketRM {
  TicketRM({
    required this.id,
    required this.title,
    this.subject,
    required this.status,
    required this.createdAt,
  });

  @JsonKey(name: 'id')
  final int id;
  @JsonKey(name: 'title')
  final String title;
  @JsonKey(name: 'message_subject')
  final String? subject;
  @JsonKey(name: 'status')
  final String status;
  @JsonKey(name: 'created_at')
  final String createdAt;

  static const fromJson = _$TicketRMFromJson;
}

