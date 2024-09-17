// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ticket_type_rm.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TicketTypeRM _$TicketTypeRMFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'TicketTypeRM',
      json,
      ($checkedConvert) {
        final val = TicketTypeRM(
          id: $checkedConvert('id', (v) => (v as num).toInt()),
          name: $checkedConvert('name', (v) => v as String),
        );
        return val;
      },
    );
