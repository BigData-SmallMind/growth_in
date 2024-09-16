// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ticket_rm.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TicketRM _$TicketRMFromJson(Map<String, dynamic> json) => $checkedCreate(
      'TicketRM',
      json,
      ($checkedConvert) {
        final val = TicketRM(
          id: $checkedConvert('id', (v) => (v as num).toInt()),
          title: $checkedConvert('title', (v) => v as String),
          subject: $checkedConvert('message_subject', (v) => v as String?),
          status: $checkedConvert('status', (v) => v as String),
          createdAt: $checkedConvert('created_at', (v) => v as String),
        );
        return val;
      },
      fieldKeyMap: const {
        'subject': 'message_subject',
        'createdAt': 'created_at'
      },
    );
