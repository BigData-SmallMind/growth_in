// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meeting_slot_rm.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MeetingSlotRM _$MeetingSlotRMFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'MeetingSlotRM',
      json,
      ($checkedConvert) {
        final val = MeetingSlotRM(
          day: $checkedConvert('day', (v) => v as String),
          hasFreeSlots: $checkedConvert('is_slots', (v) => v as bool),
        );
        return val;
      },
      fieldKeyMap: const {'hasFreeSlots': 'is_slots'},
    );
