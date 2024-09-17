// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ticket_type_cm.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TicketTypeCMAdapter extends TypeAdapter<TicketTypeCM> {
  @override
  final int typeId = 6;

  @override
  TicketTypeCM read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TicketTypeCM(
      id: fields[0] as int,
      name: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, TicketTypeCM obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TicketTypeCMAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class TicketTypesCMAdapter extends TypeAdapter<TicketTypesCM> {
  @override
  final int typeId = 7;

  @override
  TicketTypesCM read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TicketTypesCM(
      list: (fields[0] as List).cast<TicketTypeCM>(),
    );
  }

  @override
  void write(BinaryWriter writer, TicketTypesCM obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.list);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TicketTypesCMAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
