// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ticket_message_rm.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TicketMessageRM _$TicketMessageRMFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'TicketMessageRM',
      json,
      ($checkedConvert) {
        final val = TicketMessageRM(
          id: $checkedConvert('id', (v) => (v as num).toInt()),
          text: $checkedConvert('message_text', (v) => v as String),
          file: $checkedConvert('message_file', (v) => v as String?),
          createdAt: $checkedConvert('created_at', (v) => v as String),
          profileImage: $checkedConvert('profile_image', (v) => v as String?),
          companyName: $checkedConvert('company_name', (v) => v as String),
        );
        return val;
      },
      fieldKeyMap: const {
        'text': 'message_text',
        'file': 'message_file',
        'createdAt': 'created_at',
        'profileImage': 'profile_image',
        'companyName': 'company_name'
      },
    );
