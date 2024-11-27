import 'package:json_annotation/json_annotation.dart';

part 'meeting_slot_rm.g.dart';

@JsonSerializable(createToJson: false)
class MeetingSlotRM {
  MeetingSlotRM({
    required this.day,
    required this.hasFreeSlots,
  });

  @JsonKey(name: 'day')
  final String day;
  @JsonKey(name: 'is_slots')
  final bool hasFreeSlots;


  static const fromJson = _$MeetingSlotRMFromJson;
}

