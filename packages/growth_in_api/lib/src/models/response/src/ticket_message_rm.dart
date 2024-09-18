import 'package:json_annotation/json_annotation.dart';

part 'ticket_message_rm.g.dart';

@JsonSerializable(createToJson: false)
class TicketMessageRM {
  TicketMessageRM({
    required this.id,
    required this.text,
    this.file,
    required this.createdAt,
    this.profileImage,
    required this.companyName,
  });

  @JsonKey(name: 'id')
  final int id;
  @JsonKey(name: 'message_text')
  final String text;
  @JsonKey(name: 'message_file')
  final String? file;
  @JsonKey(name: 'created_at')
  final String createdAt;
  @JsonKey(name: 'profile_image')
  final String? profileImage;
  @JsonKey(name: 'company_name')
  final String companyName;

  static const fromJson = _$TicketMessageRMFromJson;
}
